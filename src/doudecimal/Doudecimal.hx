package doudecimal;

@:forward
abstract Doudecimal( Int ) from Int to Int {
  public inline function new( v: Int ){
    this = v;
  }
  @:to
  public inline function toString(): String {
    var v: Int = this;
    var dd = Doudecimal_.fromInt( v );
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
  #if neko
  public inline function checkStr( s: String ){
    var len = s.length;
    var b = new StringBuf();
    var no = 0;
    var iter = haxe.iterators.StringIteratorUnicode.unicodeIterator( s );
    for( i in iter ){
      no = i;
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
          case 8586:
            b.add( 'A' );	  
          case 8587:
            b.add( 'B' );
          case 35:
            b.add( 'A' );
          case 42:
            b.add( 'B' );
          case 45:
            if( i == 0 ){
              b.add( '-' );
	          } else {  
              throw 'invalid Doudecimal';
	          }
        case _:
          throw 'invalid Doudecimal';
      } 
    }
    return b.toString();
  }
  #else 
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
          case 45:
            if( i == 0 ){
              b.add( '-' );
	          } else {  
              throw 'invalid Doudecimal';
	          }
        case _:
          throw 'invalid Doudecimal';
      } 
    }
    return b.toString();
  }
  #end
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
  /*
  public static function convert( decimal: Int ): String {
    var tens = decimal;
    var max = 100000;
    var b: String = '';
    var s: String = '';
    var remainder = 0;
    while( true ){ 
      if( max-- == 0 ) break;
      remainder = tens % 12;
      tens = Std.int( (tens - remainder )/12 );
      if( remainder == 0 ){
        if( tens == 0 ) break;
        trace( '------ ' + tens );
        s = fromDigit( tens );
        if( s != '?' ) {
          b = s + '0' + b;
          break;
        }
        tens = decimal + 1;
        var count = 0;
        while( true ){ 
          if( max-- == 0 ) break;
          remainder = tens % 12;
          tens = Std.int( (tens - remainder )/12 );
          if( remainder == 0 ){
            if( tens == 0 ) break;
          }
          s = fromDigit( remainder );
          b = s + b;
        }
        trace('fixing');
        b = b.substr( 0, b.length - 1 ) + 'v';
        break;
      }
      s = fromDigit( remainder );
      b = s + b;
    }
    return b;
  }
  */
  public inline static function fromDigit( dig: Int ): String {
    return if( dig < 10 ){
      Std.string( dig );
    } else if( dig == 10 ){
      'A';
    } else if( dig == 11 ){
      'B';
    } else {
      '?';
    }
  }
  public inline static function toDigit( str: String ): Int {
    return if( str == 'A' ){
      10;
    } else if( str == 'B' ){
      11;
    } else {
      Std.parseInt( str );
    }
  }
  
  public inline static function fromInt( decimal: Int ): Doudecimal_{
    var tens = decimal;
    var s: String;
    var negative: Bool = false;
    if( decimal <= 0 ){
      tens = -decimal;
      negative = true; 
    }
    var b: String = '';
    b = convert( tens );
    var out: Doudecimal_ = Type.createEmptyInstance( Doudecimal_);
    if( negative ){
      out.doudecimal = '-' + b;
    } else {
      out.doudecimal = b;
    }
    out.int = decimal;
    return out;
  }
  static inline function convert( targ: Int ): String {
    var v10 = Std.int(Math.pow(12,10));
    var v9 =  Std.int(Math.pow(12,9));
    var v8 =  Std.int(Math.pow(12,8));
    var v7 =  Std.int(Math.pow(12,7));
    var v6 =  Std.int(Math.pow(12,6));
    var v5 =  Std.int(Math.pow(12,5));
    var v4 =  Std.int(Math.pow(12,4));
    var v3 =  Std.int(Math.pow(12,3));
    var v2 =  Std.int(Math.pow(12,2));
    var v1 =  12;
    var s = '';
    var o = 0;
    var n = '';

    o = 0;
    for( i in 0...12 ){
      if( targ - v10 >= 0 ){
        targ = targ - v10;
        o++;
      } else {
        n = ( o == 10 )? 'A': (( o == 11 )? 'B': Std.string( o ));
        s = s + n;
        break;
      }
    }
    o = 0;
    for( i in 0...12 ){
      if( targ - v9 >= 0 ){
        targ = targ - v9;
        o++;
      } else {
        n = ( o == 10 )? 'A': (( o == 11 )? 'B': Std.string( o ));
        s = s + n;
        break;
      }
    }
    o = 0;
    for( i in 0...12 ){
      if( targ - v8 >= 0 ){
        targ = targ - v8;
        o++;
      } else {
        n = ( o == 10 )? 'A': (( o == 11 )? 'B': Std.string( o ));
        s = s + n;
        break;
      }
    }
    o = 0;
    for( i in 0...12 ){
      if( targ - v7 >= 0 ){
        targ = targ - v7;
        o++;
      } else {
        n = ( o == 10 )? 'A': (( o == 11 )? 'B': Std.string( o ));
        s = s + n;
        break;
      }
    }
    o = 0;
    for( i in 0...12 ){
      if( targ - v6 >= 0 ){
        targ = targ - v6;
        o++;
      } else {
        n = ( o == 10 )? 'A': (( o == 11 )? 'B': Std.string( o ));
        s = s + n;
        break;
      }
    }
    o = 0;
    for( i in 0...12 ){
      if( targ - v5 >= 0 ){
        targ = targ - v5;
        o++;
      } else {
        n = ( o == 10 )? 'A': (( o == 11 )? 'B': Std.string( o ));
        s = s + n;
        break;
      }
    }
    o = 0;
    for( i in 0...12 ){
      if( targ - v4 >= 0 ){
        targ = targ - v4;
        o++;
      } else {
        n = ( o == 10 )? 'A': (( o == 11 )? 'B': Std.string( o ));
        s = s + n;
        break;
      }
    }
    o = 0;
    for( i in 0...12 ){
      if( targ - v3 >= 0 ){
        targ = targ - v3;
        o++;
      } else {
        n = ( o == 10 )? 'A': (( o == 11 )? 'B': Std.string( o ));
        s = s + n;
        break;
      }
    }
    o = 0;
    for( i in 0...12 ){
      if( targ - v2 >= 0 ){
        targ = targ - v2;
        o++;
      } else{
        n = ( o == 10 )? 'A': (( o == 11 )? 'B': Std.string( o ));
        s = s + n;
        break;
      }
    }
    o = 0;
    for( i in 0...12 ){
      if( targ - v1 >= 0 ){
        targ = targ - v1;
        o++;
      } else {
        n = ( o == 10 )? 'A': (( o == 11 )? 'B': Std.string( o ));
        s = s + n;
        break;
      }
    }
    o = 0;
    for( i in 0...12 ){
      if( targ - 1 >= 0 ){
          targ = targ - 1;
        o++;
      } else {
        n = ( o == 10 )? 'A': (( o == 11 )? 'B': Std.string( o ));
        s = s + n;
        break;
      }
    }
    var so: String = '';
    var j = 0;
    for( i in 0...s.length ){
      if( s.charAt( i ) != '0' ){
        j = i;
        break;
      }
    }
    so = s.substr( j );
    return so;
  }
  public inline function toInt(): Int{ 
    var len = doudecimal.length;
    var n: Int = len - 1;
    var multi: Float;
    var out = 0.;
    var no = 0.;
    var dozit = '';
    var negative = false;
    if( doudecimal.charAt(0) == '-' ){
      doudecimal = doudecimal.substr( 1 );
      len = doudecimal.length;
      negative = true;
    }
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
    return ( negative )? -Std.int( out ): Std.int( out );
  }        
}
