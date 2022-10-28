package doudecimal;

@:forward
abstract Doudecimal( Int ) from Int to Int {
  public inline function new( v: Int ){
		this = v;
  }
  @:to
  public inline function toString(): String {
    var v: Int = this;
    var dd = Doudecimal_.fromInt( v) ;
		return dd.toString();
  }
  @:from
  public static inline function fromString( s: String ): Doudecimal {
		var dd = new Doudecimal_( s );
    return dd.int;
  }
  @:op(A/B) function divide( b: Doudecimal ):Doudecimal;
  @:op(A+B) function add( b: Doudecimal ):Doudecimal;
  @:op(A*B) function multiply( b: Doudecimal ):Doudecimal;
  @:op(++A) function pre():Doudecimal;
  @:op(A++) function post():Doudecimal;
  @:op(-A) function negate():Doudecimal;
  @:op(A%B) function mod( b: Doudecimal ):Doudecimal;
}

@:structInit
class Doudecimal_ {
  public var doudecimal: String;
  public var int: Int;
  public inline function new( doudecimal: String ){
    this.doudecimal = checkStr( doudecimal );
    int = toInt();
  }
  @:keep 
  public inline function toString():String {
		return doudecimal;
  }
  public inline function checkStr( s: String ){
		var len = s.length;
    var b = new StringBuf();
    var no = 0;
    for( i in 0...len ){
			no = StringTools.fastCodeAt( s, i );
      switch( no ){
          case 48:
          	b.add( '0' );
          case 49:
        		b.add( '1' );
          case 50:
            b.add( '2' );
          case 51:
          	b.add( '3' );
          case 52:
            b.add( '4' );
          case 53:
          	b.add( '5' );
          case 54:
            b.add( '6' );
          case 55:
            b.add( '7' );
          case 56:
            b.add( '8' );
          case 57:
            b.add( '9' );
          case 97:
            b.add( 'A' );
          case 98:
            b.add( 'B' );
          case 65:
            b.add( 'A' );
          case 66:
            b.add( 'B' );
          case 84:
            b.add( 'A' );
          case 116:
           b.add( 'A' );
          case 88:
           b.add( 'A' );
          case 102:
           b.add( 'A' );
          case 69:
           b.add( 'B' );
          case 90:
           b.add( 'B' );
          case 122:
           b.add( 'B' );
          case 59:
           b.add( ';');
          case '↊'.code:
        	 b.add( 'A' );	  
        	case '↋'.code:
           b.add( 'B' );
          case 35:
           b.add( 'A' );
          case 42:
           b.add( 'B' );
          case _:
           throw 'invalid Doudecimal';
      } 
    }
    return b.toString();
  }
  public inline function toDozenal():String {
		var len = doudecimal.length;
    var no: Int;
    var b = new StringBuf();
    for( i in 0...len ){
      no = StringTools.fastCodeAt( doudecimal, i ); 
      b.add(switch( no ){
				case 65:
          '↊';
        case 66:
          '↋';
        case _:
          String.fromCharCode( no );
      });
    }
    return b.toString();
  }
  public inline static function fromInt( decimal: Int ): Doudecimal_{
    var tens = decimal;
    var b = new StringBuf();
    var max = 100000000;
    var s: String;
    while( true ){
			if( max-- == 0 ) break;
      var remainder = tens % 12;
      if( remainder == 0 ) break;
      tens = Std.int( (tens - remainder )/12 );
      s = if( remainder < 10 ){
				Std.string( remainder );
      } else if( remainder == 10 ){
				'A';
      } else {
				'B';
      }
      b.add(s);
    }
    var out: Doudecimal_ = Type.createEmptyInstance( Doudecimal_);
    out.doudecimal = b.toString();
    out.int = decimal;
    return out;
  }
  public inline function toInt():Int{
    var len = doudecimal.length;
    var n: Int = len - 1;
    var multi: Float;
    var out = 0.;
    var no = 0.;
    var dozit = '';
    for( i in 0...len ){
			multi = Math.pow( 12, n );
      dozit = doudecimal.charAt( i );
      var no = if( dozit == 'A' ){
				10;
      } else if( dozit == 'B' ){
				11;
      } else { 
				Std.parseInt( dozit );
      }
      out = out + multi*no;
      n--;
    }
    return Std.int( out );
  }        
}
