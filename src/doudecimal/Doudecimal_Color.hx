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
    public inline function setARGB( a: Float, r: Float, g: Float, b: Float ){
      var aD = Math.round( a * 143 );
      var rD = Math.round( r * 143 );
      var gD = Math.round( g * 143 );
      var bD = Math.round( b * 143 );
      var col = aD << 18 | rD << 12 | gD << 6 | bD;
      var temp = Doudecimal_.fromInt( col );
      this.doudecimal = temp.doudecimal;
      this.int = this.toInt();
      if( this.length != 8 ) pad();
    }
    public inline function setRGB( a: Float, r: Float, g: Float, b: Float ){
      var s = this.pair( 0 );
      var aD = s.int;
      var rD = Math.round( r * 143 );
      var gD = Math.round( g * 143 );
      var bD = Math.round( b * 143 );
      var col = aD << 18 | rD << 12 | gD << 6 | bD;
      var temp = Doudecimal_.fromInt( col );
      this.doudecimal = temp.doudecimal;
      this.int = this.toInt();
      if( this.length != 8 ) pad();
    }
    public var alpha( get, set ): Float;
    public inline function get_alpha(): Float {
      //if( length != 8 ) pad();
      var s = this.pair( 0 );
      var i = s.int;
      return ( i == 0 )? 0.: i/143;
    }
    public inline function set_alpha( a: Float ): Float {
      this.splicePair( 0, Doudecimal_.from2Channel( Math.round( a * 143 ) ) );
    }
    public var red( get, set ): Float;
    public inline function get_red(): Float {
      //if( length != 8 ) pad();
      var s = this.pair( 1 );
      var i = s.int;
      return ( i == 0 )? 0.: i/143;
    }
    public inline function set_red( r: Float ): Float {
      this.splicePair( 1, Doudecimal_.from2Channel( Math.round( r * 143 ) ) );
    }
    public var green( get, set ): Float;
    public inline function get_green(): Float {
      //if( length != 8 ) pad();
      var s = this.pair( 2 );
      var i = s.int;
      return ( i == 0 )? 0.: i/143;
    }
    public inline function set_green( g: Float ): Float {
      this,splicePair( 2, Doudecimal_.from2Channel( Math.round( g * 143 ) ) );
    }
    public var blue( get, set ): Float;
    public inline function get_blue(): Float {
      //if( length != 8 ) pad();
      var s = this.pair( 3 );
      var i = s.int;
      return ( i == 0 )? 0.: i/143;
    }
    public inline function set_blue( b: Float ): Float {
      this,splicePair( 0, Doudecimal_.from2Channel( Math.round( b * 143 ) ) );
    }
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
    // add UInt8 access
  /*
  0xFF FF FF
  alpha       | red         | green         |  Blue       | 
  8         8 .    |  8     .   8      |  8 .       8     .
  1 2 3 1   2 3 1 2   3 1 2 3   1 2 3 1   2 3 1 2   3 1 2 3
  */
}