package tools.haxelib;
import tools.haxelib.Datas;
import tools.haxelib.SiteDb;

class SiteApi {

	var db : neko.db.Connection;

	public function new( db ) {
		this.db = db;
	}

	public function search( word : String ) : List<{ name : String }> {
		return Project.manager.containing(word);
	}

	public function infos( project : String ) : ProjectInfos {
		var p = Project.manager.search({ name : project }).first();
		if( p == null )
			throw "No such Project : "+project;
		var vl = Version.manager.search({ project : p.id });
		var versions = new Array();
		for( v in vl )
			versions.push({ name : v.name, comments : v.comments, date : v.date });
		return {
			name : p.name,
			curversion : if( p.version == null ) null else p.version.name,
			desc : p.description,
			versions : versions,
			owner : p.owner.name,
			website : p.website,
		};
	}

	public function user( name : String ) : UserInfos {
		var u = User.manager.search({ name : name }).first();
		if( u == null )
			throw "No such user : "+name;
		var pl = Project.manager.search({ owner : u.id });
		var projects = new Array();
		for( p in pl )
			projects.push(p.name);
		return {
			name : u.name,
			fullname : u.fullname,
			email : u.email,
			projects : projects,
		};
	}

	public function register( name : String, pass : String, mail : String, fullname : String ) : Bool {
		if( !Datas.alphanum.match(name) )
			throw "Invalid user name, please use alphanumeric characters";
		var u = new User();
		u.name = name;
		u.pass = pass;
		u.email = mail;
		u.fullname = fullname;
		u.insert();
		return null;
	}

	public function isNewUser( name : String ) : Bool {
		return User.manager.search({ name : name }).first() == null;
	}

	public function checkOwner( prj : String, user : String ) : Void {
		var p = Project.manager.search({ name : prj }).first();
		if( p == null )
			return;
		if( p.owner.name != user )
			throw "Owner of "+p.name+" is '"+p.owner.name+"'";
	}

	public function checkPassword( user : String, pass : String ) : Bool {
		var u = User.manager.search({ name : user }).first();
		return u != null && u.pass == pass;
	}

	public function getSubmitId() : String {
		return Std.string(Std.random(100000000));
	}

	public function processSubmit( id : String, pass : String ) : String {
		var path = Site.TMP_DIR+"/"+Std.parseInt(id)+".tmp";

		var file = try neko.io.File.read(path,true) catch( e : Dynamic ) throw "Invalid file id #"+id;
		var zip = try neko.zip.File.read(file) catch( e : Dynamic ) { file.close(); neko.Lib.rethrow(e); };
		file.close();

		var infos = Datas.readInfos(zip);
		var u = User.manager.search({ name : infos.owner }).first();
		if( u == null || u.pass != pass )
			throw "Invalid username or password";

		var p = Project.manager.search({ name : infos.project }).first();
		if( p == null ) {
			p = new Project();
			p.name = infos.project;
			p.description = infos.desc;
			p.website = infos.website;
			p.owner = u;
			p.insert();
			neko.FileSystem.deleteFile(path);
			return "Project added : submit one more time to send a first version";
		}

		// check owner
		if( p.owner != u )
			throw "Invalid owner";

		// update public infos
		var update = false;
		if( infos.desc != p.description || p.website != infos.website ) {
			p.description = infos.desc;
			p.website = infos.website;
			p.update();
			update = true;
			neko.FileSystem.deleteFile(path);
			return "Project infos updated : submit one more time to send a new version";
		}

		// check version
		var vl = Version.manager.search({ project : p.id });
		for( v in vl )
			if( v.name == infos.version ) {
				neko.FileSystem.deleteFile(path);
				return "This version is already commited, please change version number";
			}

		neko.FileSystem.rename(path,Site.REP_DIR+"/"+Datas.fileName(p.name,infos.version));

		var v = new Version();
		v.project = p;
		v.name = infos.version;
		v.comments = infos.versionComments;
		v.downloads = 0;
		v.date = Date.now().toString();
		v.insert();

		p.version = v;
		p.update();
		return "Version "+v.name+" (id#"+v.id+") added";
	}

}
