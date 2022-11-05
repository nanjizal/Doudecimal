package doudecimal;
import doudecimal.Doudecimal;

@:transient
@:forward
abstract Doudecimal_UInt( UInt ) from UInt to UInt {
  public inline function new( v: Int ){
    this = v;
  }
  public  function dd():Doudecimal_{
    var v: Int = this;
    var d = Doudecimal_.fromUInt( v );
    return d;
  }
  @:to
  public inline function toString(): String {
    return dd().toString();
  }
  @:from
  public static inline function fromString( s: String ): Doudecimal_UInt {
    var d = new Doudecimal_( s );
    return new Doudecimal_UInt( d.uint );
  }
  public inline function pair( no: Int ): Doudecimal_ {
    return dd().pair( no );
  }
  public inline function single( no: Int ): Doudecimal_ {
    return dd().single( no );
  }
  @:op(A/B) function divide( b: Doudecimal_UInt ): Doudecimal_UInt;
  @:op(A+B) function add( b: Doudecimal_UInt ): Doudecimal_UInt;
  @:op(A*B) function multiply( b: Doudecimal_UInt ): Doudecimal_UInt;
  @:op(++A) function pre(): Doudecimal_UInt;
  @:op(A++) function post(): Doudecimal_UInt;
  @:op(-A)  function negate(): Doudecimal_UInt;
  @:op(A%B) function mod( b: Doudecimal_UInt ): Doudecimal_UInt;
}