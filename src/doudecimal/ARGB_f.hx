package doudecimal;
import doudecimal.UNorm;
@:structInit
class ARGB_f {
    public var a: UNorm;
    public var r: UNorm;
    public var g: UNorm;
    public var b: UNorm;
    public inline function new( a: UNorm, r: UNorm, g: UNorm, b: UNorm ){
        this.a = a;
        this.r = r;
        this.g = g;
        this.b = b;
    }
}