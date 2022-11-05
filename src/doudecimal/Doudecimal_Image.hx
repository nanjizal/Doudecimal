package doudecimal;

import haxe.io.UInt8Array;
import doudecimal.Doudecimal_Color;
import doudecimal.draw.Triangle;
import doudecimal.draw.Line;
import doudecimal.Doudecimal;
/**
  This struct is the base of Doudecimal_image
**/
@:structInit
class Image8Struct {
  public var width:  Int;
  public var height: Int;
  public var image:  UInt8Array;
  // for composing shapes where overwitting set as false, for alpha blending set as true.
  public var transparent: Bool = false;
  // set these when using relative offset x,y
  public var virtualX: Float = 0;
  public var virtualY: Float = 0;
  public var useVirtualPos: Bool = false;
  public function new( width: Int, height: Int, image: UInt8Array ){
    this.width    = width;
    this.height   = height;
    this.image    = image;
    this.transparent = false;
  }
}

@:transient
abstract Doudecimal_Image( Image8Struct ) from Image8Struct to Image8Struct {
    /**
        provides the width used by the UInt32Array
    **/
    public var width( get, never ): Int;
    inline function get_width(): Int
       return this.width;
    /**
        provides the height used by the UInt32Array
    **/
    public var height( get, never ): Int;
    inline function get_height(): Int
        return this.height;
    /**
        setting relative position provide a drawing offset, it must be positive
        update is no currentl use yet
    **/
    public function setRelativePosition( x: Int, y: Int, ?update: Bool = false ){
        this.useVirtualPos = true;
        if( x < 0 ) x = 0;
        if( y < 0 ) y = 0;
        this.virtualX = x;
        this.virtualY = y;
        // TODO: update to implement
    }
    /**
        transparent to false will allow setARGB to overwrite pixels, true will alpha blend them when new pixel is semi transparent
    **/
    public var transparent( get, set ): Bool;
    inline function get_transparent(): Bool
        return this.transparent;
    inline function set_transparent( v: Bool ): Bool {
        this.transparent = v;
        return v;
    }

    public var image( get, never ): UInt8Array;
    inline function get_image():  UInt8Array
        return this.image;
    
    inline
    public function new( w: Int, h: Int ){
       this = ( 
        { width:  w, height: h
        , image:  new haxe.io.UInt8Array( Std.int( w * h * 4  ) ) 
        }: Image8Struct
        );
    }
    /*
    public var length( get, set ): Int;
    inline function get_length():Int
        return this.image.length;
    */
    /**
        this provides a location for a UIn8 access of a color
        color from base 12 is extracts 4 colors and saves them over 3.
    **/
    inline
    public function pos4( x: Int, y: Int, ?off: Int = 0 ): Int
        return Std.int( position( x, y ) * 4  + off ); 
    /**
        provides the location of the pixel after considering any relative internal x,y offset
    **/
    inline 
    public function position( x: Int, y: Int ){
        return ( this.useVirtualPos )? /* allows off set position when drawing */
            Std.int( ( y - this.virtualY ) * this.width + x - this.virtualX ):
            Std.int( y * this.width + x );
    }
    public inline function stringPixel( x: Float, y: Float ): String {
        var pos:Int = pos4( Std.int( x ), Std.int( y ) );
        return StringTools.hex( this.image[ pos ], 2 ) 
             + StringTools.hex( this.image[ pos + 1], 2 ) 
             + StringTools.hex( this.image[ pos + 2 ], 2 )
             + StringTools.hex( this.image[ pos + 3 ], 2 );
    }
    public inline function extractPixels( x: Float, y: Float ):Doudecimal_Color {
        var v = Std.parseInt( '0x'+stringPixel( x, y ) );
        var d: Doudecimal_Color = cast Doudecimal_.fromUInt( v );
        d.pad();
        return d;
      }
    public inline function get_doudecimalPixel( x: Float, y: Float ): Doudecimal_Color {
        
        var pos = pos4( Std.int( x ), Std.int( y ) );
        var d: Doudecimal_Color = Doudecimal_Color.fromChannelEncodeHex(
             image[ pos ], image[ pos + 1 ], image[ pos + 2 ], image[ pos + 3 ] );
        return d;
             
        //return extractPixels( x, y );
    }
    public inline function set_doudecimalPixel( x: Float, y: Float, newColor: Doudecimal_Color ): Doudecimal_Color {
        var small = 1/143;
        var pos:Int = pos4( Std.int( x ), Std.int( y ) );
        if( (newColor.alpha < (1.-small)) && this.transparent ){
            var c0 = this.image[ pos ];
            var c1 = this.image[ pos + 1 ];
            var c2 = this.image[ pos + 1 ];
            var c3 = this.image[ pos + 2 ];
            var currColor = Doudecimal_Color.fromChannelEncodeHex( c0, c1, c2, c3 );
            currColor.blend( newColor );
            this.image[ pos     ] = currColor.c0;
            this.image[ pos + 1 ] = currColor.c1;
            this.image[ pos + 2 ] = currColor.c2;
            this.image[ pos + 3 ] = currColor.c3;
        } else {
            this.image[ pos     ] = newColor.c0;
            this.image[ pos + 1 ] = newColor.c1;
            this.image[ pos + 2 ] = newColor.c2;
            this.image[ pos + 3 ] = newColor.c3;
        }
        return newColor;
    }
    /**
        provides a simple filled Rectangle
    **/
    inline public 
    function simpleRect( x: Float, y: Float
                       , w: Float, h: Float
                       , color: Doudecimal_Color ){
        var p = Std.int( x );
        var xx = p;
        var q = Std.int( y );
        var maxX = Std.int( x + w );
        var maxY = Std.int( y + h );
        while( true ){
            set_doudecimalPixel( p++, q, color );
            if( p > maxX ){
                p = xx;
                q++;
            } 
            if( q > maxY ) break;
        }
    }
    /**
        provides a simple filled square a short cut 
        @see simpleRect
    **/
    public inline
    function fillSquare( x: Float, y: Float
                       , d: Float
                       , color: Doudecimal_Color ) {
        simpleRect( x-d/2, y-d/2, d, d, color );
    }

    /**
        provides a filled triangle give a,b,c coordinates
        automagically rearranges coordinates so it always renders
    **/
    public inline
    function fillTri( ax: Float, ay: Float
                    , bx: Float, by: Float
                    , cx: Float, cy: Float
                    , color: Doudecimal_Color ){
        var adjustWinding = ( (ax * by - bx * ay) + (bx * cy - cx * by) + (cx * ay - ax * cy) )>0;
        if( !adjustWinding ){// TODO: this is inverse of cornerContour needs thought, but provides required protection
            // swap b and c
            // probably wrong way as y is down?
            var bx_ = bx;
            var by_ = by;
            bx = cx;
            by = cy;
            cx = bx_;
            cy = by_;
        }
        fillTriUnsafe( this, ax, ay, bx, by, cx, cy, color );
    }
        /**
        uses two triangles to create a filled quad using four coordinates a,b,c,d arranged clockwise 
    **/
    public inline
    function fillQuad( ax: Float, ay: Float
                     , bx: Float, by: Float
                     , cx: Float, cy: Float
                     , dx: Float, dy: Float 
                     , color: Doudecimal_Color ){
        // tri e - a b d
        // tri f - b c d
        fillTri( ax, ay, bx, by, dx, dy, color );
        fillTri( bx, by, cx, cy, dx, dy, color );
    }
    /**
        creates a filled gradient triangle in OpenGL 3 color style for coordinates a,b,c
        with respective colors after coordinate pairs
    **/
    public inline
    function fillGradTri( ax: Float, ay: Float, colA: Doudecimal_Color
                        , bx: Float, by: Float, colB: Doudecimal_Color
                        , cx: Float, cy: Float, colC: Doudecimal_Color ){
        fillGradTriangle( this, ax, ay, colA, bx, by, colB, cx, cy, colC );
    }
    /**
        uses two triangles to form rectangle x,y,width,height with a,b,c,d clockwise gradient colours
    **/
    public inline 
    function fillGradRect( x:   Float, y: Float
                         , wid: Float, hi: Float
                         , colorA: Doudecimal_Color, colorB: Doudecimal_Color, colorC: Doudecimal_Color, colorD: Doudecimal_Color ){
        var bx = x + wid;
        var cy = y + hi;
        fillGradQuad( x,  y,  colorA
                    , bx, y,  colorB
                    , bx, cy, colorC
                    , x,  cy, colorD );
    }
    /**
        uses two triangle to form a quad with clockwise coordinates a,b,c,d
        with respective colours after each coordinate pair
        a better render maybe possible see commented out code in algo.QuadPixel and lerp code in algo.GeomPixel
        ( better render approach compiles but does not yet work, maybe easy? ). 
    **/
    public inline
    function fillGradQuad( ax: Float, ay: Float, colorA: Doudecimal_Color
                         , bx: Float, by: Float, colorB: Doudecimal_Color
                         , cx: Float, cy: Float, colorC: Doudecimal_Color
                         , dx: Float, dy: Float, colorD: Doudecimal_Color ){
        // tri e - a b d
        // tri f - b c d
        fillGradTri( ax, ay, colorA, bx, by, colorB, dx, dy, colorD );
        fillGradTri( bx, by, colorB, cx, cy, colorC, dx, dy, colorD );
    }

    public inline
    function lineGrid( x: Float, y: Float, w: Float, h: Float, delta: Float, thick: Float, color: Doudecimal_Color ){
        var h_ = Math.floor( h/delta )*delta;
        var w_ = Math.floor( w/delta )*delta;
        for( i in 0...Math.floor( w/delta )+1 ){
            simpleRect( x + i*delta -thick/2, y, thick, h_, color );
        }
        for( i in 0...Math.floor( h/delta )+1 ){
            simpleRect( x, y + i* delta - thick/2, w_, thick, color );
        }
    }
    #if js
    inline
    public function drawToContext( ctx: js.html.CanvasRenderingContext2D, x: Int, y: Int  ){
        var data = new js.lib.Uint8ClampedArray( image.length );
        var pos: Int = 0;
        var d: Doudecimal_Color = new Doudecimal_Color();
        var i: Int = 0;
        var s = '';
        var l = Std.int( image.length/4 );
        for( i in 0...l ){
            pos = Std.int( i*4 );
            d = Doudecimal_Color.fromChannelEncodeHex( 
                  image[ pos     ]
                , image[ pos + 1 ]
                , image[ pos + 2 ] 
                , image[ pos + 3 ] );
            data[ pos     ] = d.hexAlpha;
		    data[ pos + 1 ] = d.hexBlue;
			data[ pos + 2 ] = d.hexGreen;
			data[ pos + 3 ] = d.hexRed;
        }
        // package raw Uint8Array
        var imageData = new js.html.ImageData( data, width, height );
        // put on the canvas
        ( this.useVirtualPos )? 
            ctx.putImageData( imageData, x - this.virtualX, y - this.virtualY ):
            ctx.putImageData( imageData, x, y );
    }
    // no method yet for getting off the canvas.
    #end
}