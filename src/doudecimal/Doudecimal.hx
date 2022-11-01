package doudecimal;

@:structInit
class Doudecimal_ {
  public static final v11 = 743008370688;
  public static final v10 = 1787822080;
  public static final v9  = 864813056;
  public static final v8  = 429981696;
  public static final v7  = 35831808;
  public static final v6  = 2985984;
  public static final v5  = 248832;
  public static final v4  = 20736;
  public static final v3  = 1728;
  public static final v2  = 144;
  public static final v1  = 12;
  public static final v0  = 1;
  public var doudecimal: String;
  public var int: Int;
  public inline function new( doudecimal: String ){
    this.doudecimal = checkStr( doudecimal );
    int = toInt();
  }
  public inline function writeValue( str: String ){
    this.doudecimal = checkStr( str );
    int = toInt();
  }
  public var length( get, never ):Int;
  public inline function get_length(): Int {
    return doudecimal.length;
  }
  public inline function substr( pos: Int, len: Int ){
    return doudecimal.substr( pos, len );
  }
  public inline function pair( no: Int ): Doudecimal_{
    no = no-1;
    return if( length >= Std.int( no*2 ) ){
      var p = substr( Std.int( no*2 ), 2 );
      new Doudecimal_( p );
    } else {
      quickZero(); 
    }
  }
  public inline function splicePair( no: Int, pair_: Doudecimal_ ){
    var buf: StringBuf = new StringBuf();
    var pos0 = 2*(no-1);
    var pos1 = pos0+1;
    var l = this.doudecimal.length;
    var toggle = true;
    for( i in 0...l ){
      if( i != pos0 && i != pos1 ){
        buf.addChar( StringTools.fastCodeAt(this.doudecimal, i ) ); 
      } else {
        if( toggle ){
          toggle = false;
          buf.addChar( StringTools.fastCodeAt( pair_.doudecimal, 0 ) );  
        } else {
          buf.addChar( StringTools.fastCodeAt( pair_.doudecimal, 1 ) );
        }
      }
    }
    writeValue( buf.toString() );
  }
  public inline function replaceAt( no: Int, d: Doudecimal_ ){
    var buf: StringBuf = new StringBuf();
    var l = this.length;
    var l2 = d.length;
    var pos0 = no;
    var pos1 = pos0 + l2;
    var dCount = 0;
    for( i in 0...l ){
      if( i < pos0 && i > pos1 ){
        buf.addChar( StringTools.fastCodeAt( doudecimal, i ) ); 
      } else {
        buf.addChar( StringTools.fastCodeAt( d.doudecimal, dCount ) );
        dCount++;
      }
    }
    writeValue( buf.toString() );
  }
  public inline function single( no: Int ):Doudecimal_{
    return if( length >= no ){
      var p = substr( no, 1 );
      new Doudecimal_( p );
    } else {
      quickZero();
    }
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
  public inline static function quickZero(): Doudecimal_ {
    var out: Doudecimal_ = Type.createEmptyInstance( Doudecimal_ );
    out.int = 0;
    out.doudecimal = '0';
    return out;
  }
  public inline static function from2Channel( decimal: Int ): Doudecimal_ {
    // assumes positive and within range as only called for colors?
    var out: Doudecimal_ = Type.createEmptyInstance( Doudecimal_ );
    out.doudecimal = convertPair( decimal );
    out.int = decimal;
    return out;
  }
  public inline static function fromInt( decimal: Int ): Doudecimal_{
    var tens = decimal;
    var s: String;
    var negative: Bool = false;
    if( decimal < 0 ){
      tens = -decimal;
      negative = true; 
    }
    var b: String = '';
    b = convert( tens );
    var out: Doudecimal_ = Type.createEmptyInstance( Doudecimal_ );
    if( negative ){
      out.doudecimal = '-' + b;
    } else {
      out.doudecimal = b;
    }
    out.int = decimal;
    return out;
  }
  static var targTemp: Int;
  static inline function digitProcess( vx: Int, s: String ){
      var o = 0;
      for( i in 0...12 ){
        if( targTemp - vx >= 0 ){
          targTemp = targTemp - vx;
          o++;
        } else {
          s = s + (( o == 10 )? 'A': (( o == 11 )? 'B': Std.string( o )));
          break;
        }
      }
    return s;
  }
  static inline function convertPair( targ: Int ): String {
    return if( targ == 0 ){
      '0';
    } else {
      targTemp = targ;
      var s = '';
      s = digitProcess( v1, s );
      s = digitProcess( v0, s );
      //s = stripLeading0( s );  
    }
  }
  static inline function convert( targ: Int ): String {
    return if( targ == 0 ){
      '0';
    } else {
      targTemp = targ;
      var s = '';
      s = digitProcess( v10, s );
      s = digitProcess( v9, s );
      s = digitProcess( v8, s );
      s = digitProcess( v7, s );
      s = digitProcess( v6, s );
      s = digitProcess( v5, s );
      s = digitProcess( v4, s );
      s = digitProcess( v3, s );
      s = digitProcess( v2, s );
      s = digitProcess( v1, s );
      s = digitProcess( v0, s );
      s = stripLeading0( s );  
    }
  }
  public static inline function stripLeading0( s: String ): String {
    var j = 0;
    for( i in 0...s.length ){
      if( s.charAt( i ) != '0' ){
        j = i;
        break;
      }
    }
    return s.substr( j );
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
