package doudecimal;
import doudecimal.Doudecimal;

@:transient
@:forward
abstract Doudecimal_Color( Doudecimal_ ){
    public inline function new( ?str: String = '0' ){
        if( str.length > 8 ) throw 'DoudecColour string length max is 8';
        for( i in 0...8-str.length ) str += '0';
        this = new Doudecimal_( str );
    }
    public inline function pad(){
        var s = '';
        for( i in 0...8-this.length ) s += '0';
        s += this.doudecimal;
        this.doudecimal = s;
    }
    @:from
    public static inline function fromString( s: String ): Doudecimal_Color {
      return new Doudecimal_Color( s );
    }
    // not really used, or tested..
    public inline function third( dig: Int, four: Int ){
        if( four != 0 || four != 1 || four != 2 ) return null;
        var s = this.single( dig );
        return { four0: s.int & 0x3
               , four1: s.int >> 2 & 0x3
               , four2: s.int >> 4 & 0x3 }  
    }
    public inline function setARGB( a: Float, r: Float, g: Float, b: Float ): Doudecimal_Color{
      var aD = Math.round( a * 143 );
      var rD = Math.round( r * 143 );
      var gD = Math.round( g * 143 );
      var bD = Math.round( b * 143 );
      var col = aD << 18 | rD << 12 | gD << 6 | bD;
      setIntDirect( col );
      return abstract;
    }
    public inline function fromIntDirect( v: Int ): Doudecimal_Color {
      var out: Doudecimal_Color = cast Type.createEmptyInstance( Doudecimal_ );
      out.setIntDirect( v );
      return out;
    }
    public inline function setIntDirect( v: Int ): Doudecimal_Color{
      var temp = Doudecimal_.fromInt( v );
      this.doudecimal = temp.doudecimal;
      this.int = this.toInt();
      if( this.length != 8 ) pad();
      return abstract;
    }
    public inline function setRGB( a: Float, r: Float, g: Float, b: Float ): Doudecimal_Color{
      var s = this.pair( 0 );
      var aD = s.int;
      var rD = Math.round( r * 143 );
      var gD = Math.round( g * 143 );
      var bD = Math.round( b * 143 );
      var col = aD << 18 | rD << 12 | gD << 6 | bD;
      setIntDirect( col );
      return abstract;
    }
    public var alpha( get, set ): Float;
    inline function get_alpha(): Float {
      //if( length != 8 ) pad();
      var s = this.pair( 0 );
      var i = s.int;
      return ( i == 0 )? 0.: i/143;
    }
    inline function set_alpha( a: Float ): Float {
      this.splicePair( 0, Doudecimal_.from2Channel( Math.round( a * 143 ) ) );
      return a;
    }
    public var red( get, set ): Float;
    inline function get_red(): Float {
      //if( length != 8 ) pad();
      var s = this.pair( 1 );
      var i = s.int;
      return ( i == 0 )? 0.: i/143;
    }
    inline function set_red( r: Float ): Float {
      this.splicePair( 1, Doudecimal_.from2Channel( Math.round( r * 143 ) ) );
      return r;
    }
    public var green( get, set ): Float;
    inline function get_green(): Float {
      //if( length != 8 ) pad();
      var s = this.pair( 2 );
      var i = s.int;
      return ( i == 0 )? 0.: i/143;
    }
    inline function set_green( g: Float ): Float {
      this.splicePair( 2, Doudecimal_.from2Channel( Math.round( g * 143 ) ) );
      return g;
    }
    public var blue( get, set ): Float;
    inline function get_blue(): Float {
      //if( length != 8 ) pad();
      var s = this.pair( 3 );
      var i = s.int;
      return ( i == 0 )? 0.: i/143;
    }
    inline function set_blue( b: Float ): Float {
      this.splicePair( 3, Doudecimal_.from2Channel( Math.round( b * 143 ) ) );
      return b;
    }
    // to extract colors for hex argb, for instance populating canvas.
    public var hexAlpha( get, never ): Int;
    inline function get_hexAlpha():Int
      return ( Std.int( Math.round( alpha * 255. )) << 24 );
    public var hexRed( get, never ): Int;
    inline function get_hexRed():Int
      return ( Std.int( Math.round( red * 255. )) << 16 );
    public var hexGreen( get, never ):Int;
    inline function get_hexGreen():Int
      return ( Std.int( Math.round( green * 255. )) << 8 );
    public var hexBlue( get, never ): Int;
    inline function get_hexBlue():Int
      return ( Std.int( Math.round( blue * 255. )));

    public inline function colorHex(): Int {
      return ( Std.int( Math.round( alpha * 255. )) << 24 ) 
            | ( Std.int( Math.round( red * 255. )) << 16 ) 
            | ( Std.int( Math.round( green * 255. )) << 8 ) 
            | ( Std.int( Math.round( blue * 255. )));
    }
    public inline function colorflip13(): Int {
      return ( Std.int( Math.round( alpha * 255. )) << 24 ) 
            | ( Std.int( Math.round( blue * 255. )) << 16 ) 
            | ( Std.int( Math.round( green * 255. )) << 8 ) 
            | ( Std.int( Math.round( red * 255. )));
    }
    public inline function blend( color2: Doudecimal_Color ){
        var a1 = alpha;
        var r1 = red;
        var g1 = green;
        var b1 = blue;
        var a2 = color2.alpha;
        var r2 = color2.red;
        var g2 = color2.green;
        var b2 = color2.blue;
        var a3 = a1 * ( 1. - a2 );
        var r = colBlendFunc( r1, r2, a3, a2 );
        var g = colBlendFunc( g1, g2, a3, a2 );
        var b = colBlendFunc( b1, b2, a3, a2 );
        var a = alphaBlendFunc( a3, a2 );
        setARGB( a, r, g, b );
    }
    inline
    static function colBlendFunc( x1: Float, x2: Float, a3: Float, a2: Float ): Float
        return x1 * a3 + x2 * a2;
    inline
    static function alphaBlendFunc( a3: Float, a2: Float ): Float
        return a3 + a2;

    // add UInt8 access
  /*
  0xFF FF FF
  alpha       | red         | green         |  Blue       | 
  8         8 .    |  8     .   8      |  8 .       8     .
  1 2 3 1   2 3 1 2   3 1 2 3   1 2 3 1   2 3 1 2   3 1 2 3
  */
// sets and gets color like RGB 0xFFFFFF to a image store but the color is still in Doudecimal

  public var c1( get, set ): Int;

  inline
  function get_c1(): Int 
      return this.int >> 16 & 0xFF;
  inline
  function set_c1( v: Int ): Int {
    setIntDirect( fromChannels( v, c2, c3 ) );
    return v;
  }

  public var c2( get, set ): Int;
  inline
  function get_c2(): Int 
    return this.int >> 8 & 0xFF;
  inline
  function set_c2( v: Int ): Int {
    setIntDirect( fromChannels( c1, v, c3 ) );
    return v;
  }

  public var c3( get, set ): Int;
  inline
  function get_c3(): Int 
      return this.int & 0xFF;
  inline
  function set_c3( v: Int ): Int {
      setIntDirect( fromChannels( c1, c2, v ) );
      return v;
  }

  public static function fromChannels( ch1: Int, ch2: Int, ch3: Int ): Int
    return ch1 << 16 | ch2 << 8 | ch3;


  // some default colors would be idea to precalculate...
  public static var RED( get, never ): Doudecimal_Color;
  static inline function get_RED(): Doudecimal_Color {
    return new Doudecimal_Color('AAAA0000');
  }
  public static var GREEN( get, never ): Doudecimal_Color;
  static inline function get_GREEN(): Doudecimal_Color {
    return new Doudecimal_Color('AA00AA00');
  }
  public static var BLUE( get, never ): Doudecimal_Color;
  static inline function get_BLUE(): Doudecimal_Color {
    return new Doudecimal_Color('AA0000AA');
  }
  public static var YELLOW( get, never ): Doudecimal_Color;
  static inline function get_YELLOW(): Doudecimal_Color {
    return new Doudecimal_Color('AAAAAA00');
  }
  public static var CYAN( get, never ): Doudecimal_Color;
  static inline function get_CYAN(): Doudecimal_Color {
    return new Doudecimal_Color('AA00AAAA');
  }
  public static var MAGENTA( get, never ): Doudecimal_Color;
  static inline function get_MAGENTA(): Doudecimal_Color {
    return new Doudecimal_Color('AAAA00AA');
  }
  public static var BLACK( get, never ): Doudecimal_Color;
  static inline function get_BLACK(): Doudecimal_Color {
    return new Doudecimal_Color('AA000000');
  }
  public static var WHITE( get, never ): Doudecimal_Color;
  static inline function get_WHITE(): Doudecimal_Color {
    return new Doudecimal_Color('AAAAAAAA');
  }
  // need more colors and grays.
  public static var GREY4( get, never ): Doudecimal_Color;
  static inline function get_GREY4(): Doudecimal_Color {
    return new Doudecimal_Color('AA444444');
  }
  public static var GREY6( get, never ): Doudecimal_Color;
  static inline function get_GREY6(): Doudecimal_Color {
    return new Doudecimal_Color('AA666666');
  }
  public static var GREY8( get, never ): Doudecimal_Color;
  static inline function get_GREY8(): Doudecimal_Color {
    return new Doudecimal_Color('AA888888');
  }
}