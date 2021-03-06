package flash.display;

extern class BitmapData implements IBitmapDrawable {
	var height(default,null) : Int;
	var rect(default,null) : flash.geom.Rectangle;
	var transparent(default,null) : Bool;
	var width(default,null) : Int;
	function new(width : Int, height : Int, ?transparent : Bool, ?fillColor : UInt) : Void;
	function applyFilter(sourceBitmapData : BitmapData, sourceRect : flash.geom.Rectangle, destPoint : flash.geom.Point, filter : flash.filters.BitmapFilter) : Void;
	function clone() : BitmapData;
	function colorTransform(rect : flash.geom.Rectangle, colorTransform : flash.geom.ColorTransform) : Void;
	function compare(otherBitmapData : BitmapData) : Dynamic;
	function copyChannel(sourceBitmapData : BitmapData, sourceRect : flash.geom.Rectangle, destPoint : flash.geom.Point, sourceChannel : Int, destChannel : Int) : Void;
	function copyPixels(sourceBitmapData : BitmapData, sourceRect : flash.geom.Rectangle, destPoint : flash.geom.Point, ?alphaBitmapData : BitmapData, ?alphaPoint : flash.geom.Point, ?mergeAlpha : Bool) : Void;
	function dispose() : Void;
	function draw(source : IBitmapDrawable, ?matrix : flash.geom.Matrix, ?colorTransform : flash.geom.ColorTransform, ?blendMode : BlendMode, ?clipRect : flash.geom.Rectangle, ?smoothing : Bool) : Void;
	function fillRect(rect : flash.geom.Rectangle, color : UInt) : Void;
	function floodFill(x : Int, y : Int, color : UInt) : Void;
	function generateFilterRect(sourceRect : flash.geom.Rectangle, filter : flash.filters.BitmapFilter) : flash.geom.Rectangle;
	function getColorBoundsRect(mask : UInt, color : UInt, ?findColor : Bool) : flash.geom.Rectangle;
	function getPixel(x : Int, y : Int) : UInt;
	function getPixel32(x : Int, y : Int) : UInt;
	function getPixels(rect : flash.geom.Rectangle) : flash.utils.ByteArray;
	function hitTest(firstPoint : flash.geom.Point, firstAlphaThreshold : UInt, secondObject : Dynamic, ?secondBitmapDataPoint : flash.geom.Point, ?secondAlphaThreshold : UInt) : Bool;
	function lock() : Void;
	function merge(sourceBitmapData : BitmapData, sourceRect : flash.geom.Rectangle, destPoint : flash.geom.Point, redMultiplier : UInt, greenMultiplier : UInt, blueMultiplier : UInt, alphaMultiplier : UInt) : Void;
	function noise(randomSeed : Int, ?low : UInt, ?high : UInt, ?channelOptions : UInt, ?grayScale : Bool) : Void;
	function paletteMap(sourceBitmapData : BitmapData, sourceRect : flash.geom.Rectangle, destPoint : flash.geom.Point, ?redArray : Array<Int>, ?greenArray : Array<Int>, ?blueArray : Array<Int>, ?alphaArray : Array<Int>) : Void;
	function perlinNoise(baseX : Float, baseY : Float, numOctaves : UInt, randomSeed : Int, stitch : Bool, fractalNoise : Bool, ?channelOptions : UInt, ?grayScale : Bool, ?offsets : Array<flash.geom.Point>) : Void;
	function pixelDissolve(sourceBitmapData : BitmapData, sourceRect : flash.geom.Rectangle, destPoint : flash.geom.Point, ?randomSeed : Int, ?numPixels : Int, ?fillColor : UInt) : Int;
	function scroll(x : Int, y : Int) : Void;
	function setPixel(x : Int, y : Int, color : UInt) : Void;
	function setPixel32(x : Int, y : Int, color : UInt) : Void;
	function setPixels(rect : flash.geom.Rectangle, inputByteArray : flash.utils.ByteArray) : Void;
	function threshold(sourceBitmapData : BitmapData, sourceRect : flash.geom.Rectangle, destPoint : flash.geom.Point, operation : String, threshold : UInt, ?color : UInt, ?mask : UInt, ?copySource : Bool) : UInt;
	function unlock(?changeRect : flash.geom.Rectangle) : Void;

	#if flash10
	function setVector( rect : flash.geom.Rectangle, inputVector : flash.Vector<UInt> ) : Void;
	function getVector( rect : flash.geom.Rectangle ) : flash.Vector<UInt>;
	function histogram( ?hRect : flash.geom.Rectangle ) : flash.Vector<flash.Vector<Float>>;
	#end

}
