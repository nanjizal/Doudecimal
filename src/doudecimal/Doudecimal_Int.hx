package doudecimal;
import doudecimal.Doudecimal;

@:transient
@:forward
abstract Doudecimal_Int( Int ) from Int to Int {
  public inline function new( v: Int ){
    this = v;
  }
  public  function dd():Doudecimal_{
    var v: Int = this;
    var d = Doudecimal_.fromInt( v );
    return d;
  }
  @:to
  public inline function toString(): String {
    return dd().toString();
  }
  @:from
  public static inline function fromString( s: String ): Doudecimal_Int {
    var d = new Doudecimal_( s );
    return new Doudecimal_Int( d.int );
  }
  public inline function pair( no: Int ): Doudecimal_ {
    return dd().pair( no );
  }
  public inline function single( no: Int ): Doudecimal_ {
    return dd().single( no );
  }
  @:op(A/B) function divide( b: Doudecimal_Int ): Doudecimal_Int;
  @:op(A+B) function add( b: Doudecimal_Int ): Doudecimal_Int;
  @:op(A*B) function multiply( b: Doudecimal_Int ): Doudecimal_Int;
  @:op(++A) function pre(): Doudecimal_Int;
  @:op(A++) function post(): Doudecimal_Int;
  @:op(-A)  function negate(): Doudecimal_Int;
  @:op(A%B) function mod( b: Doudecimal_Int ): Doudecimal_Int;
}