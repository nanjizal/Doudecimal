package doudecimal;
import doudecimal.Doudecimal;
import doudecimal.ARGB_f;
import doudecimal.format.doudecimalString.Writer;

@:transient
@:forward
abstract Doudecimal_Color( Doudecimal_ ){

    public inline
    function new( ?str: String = '0' ){
        if( str == null ) str = '0';
        if( str.length > 8 ) str = '0'; //throw 'DoudecColour string length max is 8' + str;
        for( i in 0...8-str.length ) str += '0';
        this = new Doudecimal_( str );
    }
    
    public inline
    function pad(){
        var s = '';
        for( i in 0...8-this.length ) s += '0';
        s = s + this.doudecimal;
        this.doudecimal = s;
    }

    @:from
    public static inline function fromString( s: String ): Doudecimal_Color
        return new Doudecimal_Color( s );
    
    inline static function empty(): Doudecimal_Color
        return new Doudecimal_Color( '0' );
    
    public var hexadecimal( get, never ): String;
    inline
    function get_hexadecimal(): String
        return StringTools.hex( this.uint, 8 );

    @:from
    public static inline
    function fromIntDirect( v: Int ): Doudecimal_Color {
        var d = Doudecimal_.fromUInt( v );
        var out = Doudecimal_Color.empty();
        out.doudecimal = d.doudecimal;
        out.uint = d.uint;
        if( out.length != 8 ) out.pad();
        return out;
    }

    public inline
    function setStringDirect( s: String ): Doudecimal_Color {
        var temp = new Doudecimal_Color( s );
        this.doudecimal = temp.doudecimal;
        this.uint = temp.uint;
        temp = null;
        return abstract;
    }

    public inline
    function setIntDirect( v: UInt ): Doudecimal_Color{
        var temp = Doudecimal_.fromUInt( v );
        this.doudecimal = temp.doudecimal;
        this.uint = v;
        if( this.length != 8 ) pad();
        return abstract;
    }

    public var ARGB( get, set ): ARGB_f;
    inline
    function get_ARGB(): ARGB_f {
        return { a: alpha, r: red, g: green, b: blue };
    }
    inline
    function set_ARGB( c: ARGB_f ): ARGB_f {
        var aD = Math.round( Math.max( 143, c.a * 143 ) );
        var rD = Math.round( Math.max( 143, c.r * 143 ) );
        var gD = Math.round( Math.max( 143, c.g * 143 ) );
        var bD = Math.round( Math.max( 143, c.b * 143 ) );
        var s = getBase12fromColorChannel_( aD, rD, gD, bD );
        setStringDirect( s );
        return c;
    }

    public var alpha( get, set ): Float;
    inline
    function get_alpha(): Float {
        var s = this.pair( 0 );
        var i = s.uint;
        return ( i == 0 )? 0.: i/143;
    }
    inline
    function set_alpha( a: Float ): Float {
        this.splicePair( 0, Doudecimal_.from2Channel( Math.round( a * 143 ) ) );
        return a;
    }
    
    public var red( get, set ): Float;
    inline
    function get_red(): Float {
        var s = this.pair( 1 );
        var i = s.uint;
        return ( i == 0 )? 0.: i/143;
    }
    inline
    function set_red( r: Float ): Float {
        this.splicePair( 1, Doudecimal_.from2Channel( Math.round( r * 143 ) ) );
        return r;
    }
    
    public var green( get, set ): Float;
    inline
    function get_green(): Float {
        var s = this.pair( 2 );
        var i = s.uint;
        return ( i == 0 )? 0.: i/143;
    }
    inline
    function set_green( g: Float ): Float {
        this.splicePair( 2, Doudecimal_.from2Channel( Math.round( g * 143 ) ) );
        return g;
    }
    
    public var blue( get, set ): Float;
    inline
    function get_blue(): Float {
        var s = this.pair( 3 );
        var i = s.uint;
        return ( i == 0 )? 0.: i/143;
    }
    inline
    function set_blue( b: Float ): Float {
        this.splicePair( 3, Doudecimal_.from2Channel( Math.round( b * 143 ) ) );
        return b;
    }
    
    // to extract colors for hex argb, for instance populating canvas.
    public var hexAlpha( get, never ): Int;
    inline
    function get_hexAlpha():Int
        return Std.int( Math.min(  ( Std.int( Math.round( alpha * 255. )) << 24 ), 0xFF ));
    
    public var hexRed( get, never ): Int;
    inline
    function get_hexRed():Int
        return Std.int( Math.min(  ( Std.int( Math.round( red * 255. )) << 16 ), 0xFF ));
    
    public var hexGreen( get, never ):Int;
    inline
    function get_hexGreen():Int
        return Std.int( Math.min(  ( Std.int( Math.round( green * 255. )) << 8 ), 0xFF ));
    
    public var hexBlue( get, never ): Int;
    inline
    function get_hexBlue():Int
        return Std.int( Math.min(  ( Std.int( Math.round( blue * 255. ))), 0xFF ));

    public inline
    function colorHex(): Int {
        return  ( Std.int( Math.round( alpha * 255. )) << 24 ) 
                | ( Std.int( Math.round( red * 255. )) << 16 ) 
                | ( Std.int( Math.round( green * 255. )) << 8 ) 
                | ( Std.int( Math.round( blue * 255. )));
    }
    
    public inline
    function colorflip13(): Int {
        return  ( Std.int( Math.round( alpha * 255. )) << 24 ) 
                | ( Std.int( Math.round( blue * 255. )) << 16 ) 
                | ( Std.int( Math.round( green * 255. )) << 8 ) 
                | ( Std.int( Math.round( red * 255. )));
    }
    
    public inline
    function blend( color2: Doudecimal_Color ){
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
        var argb: ARGB_f = { a:a, r:r, g:g, b:b };
        ARGB = argb;
    }
    
    inline
    static function colBlendFunc( x1: Float, x2: Float, a3: Float, a2: Float ): Float
        return x1 * a3 + x2 * a2;
    
    inline
    static function alphaBlendFunc( a3: Float, a2: Float ): Float
        return a3 + a2;
    
    
    // 4 + 4 + 4 = 12   4 + 4 + 4 + 4 = 16
    // add UInt8 access
  /*
  0xFF FF FF
  alpha       | red         | green         |  Blue       | 
  8         8 .    |  8     .   8      |  8 .       8     .
  1 2 3 1   2 3 1 2   3 1 2 3   1 2 3 1   2 3 1 2   3 1 2 3
  */
// sets and gets color like RGB 0xFFFFFF to a image store but the color is still in Doudecimal

  // for debug
    public inline function channel_dds( channelNo: UInt ): String {
        return switch( channelNo ){
            case 0:
                Doudecimal_.fromUInt( c0 ).doudecimal;
            case 1:
                Doudecimal_.fromUInt( c1 ).doudecimal;
            case 2:
                Doudecimal_.fromUInt( c2 ).doudecimal;
            case 3:
                Doudecimal_.fromUInt( c3 ).doudecimal;
            case _:
                throw 'only 4 channel - 1, 2, 3';
        }
    }
    // for debug
    public inline function channel_ddi( channelNo: UInt ): UInt {
        return switch( channelNo ){
            case 0:
                Doudecimal_.fromUInt( c0 ).uint;
            case 1:
                Doudecimal_.fromUInt( c1 ).uint;
            case 2:
                Doudecimal_.fromUInt( c2 ).uint;
            case 3:
                Doudecimal_.fromUInt( c3 ).uint;
            case _:
                throw 'only 4 channel - 1, 2, 3';
        }
    }

    public var c0( get, never ): UInt;
    inline
    function get_c0(): UInt 
        return ( this.uint >> 32 ) & 0xFF;

    public var c1( get, never ): Int;
    inline
    function get_c1(): UInt 
        return ( this.uint >> 16 ) & 0xFF;


    public var c2( get, never ): UInt;
    inline
    function get_c2(): UInt 
        return ( this.uint >> 8 ) & 0xFF;


    public var c3( get, never ): UInt;
    inline
    function get_c3(): UInt 
        return this.uint & 0xFF;


    // not currently workind need thought see fromChannelEncodeHex for more verbose.
    public static function fromChannels( ch0: UInt, ch1: UInt, ch2: UInt, ch3: UInt ): UInt
        return ch0 << 32 | ch1 << 16 | ch2 << 8 | ch3;

    public static inline function fromChannelEncodeHex( ch0: UInt, ch1: UInt, ch2: UInt, ch3: UInt ): Doudecimal_Color {
        var fromRGB = fromChannels( ch0, ch1, ch2, ch3 );
        var d: Doudecimal_Color = cast Doudecimal_.fromUInt( fromRGB );
        d.pad();
        return d;
    }
    
  /*
  public inline function extractPixels():Doudecimal_Color {
    var v = Std.parseInt( '0x'+stringPixel() );
    var d: Doudecimal_Color = cast Doudecimal_.fromUInt( v );
    d.pad();
    return d;
  }
  */
    public inline function stringPixel(): String {
        return    StringTools.hex( c0, 2 )
                + StringTools.hex( c1, 2 ) 
                + StringTools.hex( c2, 2 )
                + StringTools.hex( c3, 2 );
    }

    // some default colors would be idea to precalculate...
    public static var RED( get, never ): Doudecimal_Color;
    static inline function get_RED(): Doudecimal_Color
        return new Doudecimal_Color('BBBB0000');
    
    public static var GREEN( get, never ): Doudecimal_Color;
    static inline function get_GREEN(): Doudecimal_Color
        return new Doudecimal_Color('BB00BB00');
    
    public static var BLUE( get, never ): Doudecimal_Color;
    static inline function get_BLUE(): Doudecimal_Color
        return new Doudecimal_Color('BB0000BB');
    
    public static var YELLOW( get, never ): Doudecimal_Color;
    static inline function get_YELLOW(): Doudecimal_Color
        return new Doudecimal_Color('BBBBBB00');
    
    public static var CYAN( get, never ): Doudecimal_Color;
    static inline function get_CYAN(): Doudecimal_Color
        return new Doudecimal_Color('BB00BBBB');
    
    public static var MAGENTA( get, never ): Doudecimal_Color;
    static inline function get_MAGENTA(): Doudecimal_Color
        return new Doudecimal_Color('BBBB00BB');
    
    public static var BLACK( get, never ): Doudecimal_Color;
    static inline function get_BLACK(): Doudecimal_Color
        return new Doudecimal_Color('BB000000');
    
    public static var WHITE( get, never ): Doudecimal_Color;
    static inline function get_WHITE(): Doudecimal_Color
        return new Doudecimal_Color('BBBBBBBB');
    
    // need more colors and grays.

    public static var GREY44( get, never ): Doudecimal_Color;
    static inline function get_GREY44(): Doudecimal_Color 
        return new Doudecimal_Color('BB444444');
    
    public static var GREY66( get, never ): Doudecimal_Color;
    static inline function get_GREY66(): Doudecimal_Color 
        return new Doudecimal_Color('BB666666');
    
    public static var GREY88( get, never ): Doudecimal_Color;
    static inline function get_GREY88(): Doudecimal_Color 
        return new Doudecimal_Color('BB888888');
    
    // 144/2 = 72 in doudecimal that is 60
    public static var PURPLE( get, never ): Doudecimal_Color;
    static inline function get_PURPLE(): Doudecimal_Color 
        return new Doudecimal_Color('BB600060');
    public static var OLIVE( get, never ): Doudecimal_Color;
    static inline function get_OLIVE(): Doudecimal_Color 
        return new Doudecimal_Color('BB606000');
    public static var NAVY( get, never ): Doudecimal_Color;
    static inline function get_NAVY(): Doudecimal_Color 
        return new Doudecimal_Color('BB000060');
    public static var TEAL( get, never ): Doudecimal_Color;
    static inline function get_TEAL(): Doudecimal_Color 
        return new Doudecimal_Color('BB006060');
    public static var MAROON( get, never ): Doudecimal_Color;
    static inline function get_MAROON(): Doudecimal_Color 
        return new Doudecimal_Color('BB600000');
    public static var DEEPGREEN( get, never ): Doudecimal_Color;
    static inline function get_DEEPGREEN(): Doudecimal_Color 
        return new Doudecimal_Color('BB006000');
    public static var GREY( get, never ): Doudecimal_Color;
    static inline function get_GREY(): Doudecimal_Color 
        return new Doudecimal_Color('BB606060');
    public static var ORANGE( get, never ): Doudecimal_Color;
    static inline function get_ORANGE(): Doudecimal_Color 
        return new Doudecimal_Color('BBBB6000');

    public static function COLORARRAY(): Array<Doudecimal_Color> {
        return [ MAROON, RED, ORANGE, YELLOW, GREEN, DEEPGREEN, OLIVE, CYAN, TEAL, BLUE, NAVY, MAGENTA, BLACK, WHITE, GREY, GREY44, GREY66, GREY88 ];
    }
}