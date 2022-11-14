package doudecimal;

@:structInit
class ARGB_f {
    public var a: Float;
    public var r: Float;
    public var g: Float;
    public var b: Float;
    public inline function new( a: Float, r: Float, g: Float, b: Float ){
        this.a = a;
        this.r = r;
        this.g = g;
        this.b = b;
    }
}