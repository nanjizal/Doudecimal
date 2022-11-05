import htmlHelper.canvas.CanvasSetup;
import htmlHelper.canvas.Surface;

import doudecimal.Doudecimal_Image;
import doudecimal.Doudecimal_Color;

function main() new Test();
class Test {

    public var canvasSetup = new CanvasSetup();
    
    public function new(){
        trace( 'Doudecimal example on Canvas' );
        var g   = canvasSetup.surface;
        // check encoding
        var p = new Doudecimal_Image( 1, 1 );
        var d = new Doudecimal_Color( 'BBAA9988' ); 
        // 19 9C D4 38
        // 429708344
        trace( d.uint );
           
        // 6C 7E 5B E4
        trace( d.uint );
        trace( d.channel_dds( 0 ) + ' '
             + d.channel_dds( 1 ) + ' '
             + d.channel_dds( 2 ) + ' ' 
             + d.channel_dds( 2 ) );
             trace( d.uint );
        trace( StringTools.hex( d.channel_ddi( 0 ), 2 ) + ' '
             + StringTools.hex( d.channel_ddi( 1 ), 2 ) + ' '
             + StringTools.hex( d.channel_ddi( 2 ), 2 ) + ' ' 
             + StringTools.hex( d.channel_ddi( 3 ), 2 )
             );  

        trace( d.stringPixel() );
        p.set_doudecimalPixel( 0., 0., d );
        trace( p.stringPixel( 0., 0. ) );
        var d2 = p.get_doudecimalPixel( 0., 0. );
        trace( d.uint + ' '+ d.doudecimal + ' '+ d2.uint + ' ' + d2.doudecimal );  


/*
        trace( 'creating image' );
        var p = new Doudecimal_Image( 5, 5 );
        p.fillSquare( 1, 1, 4, 'BBAA9988' );
        trace( p );
        p.drawToContext( g.me, 0, 0 );
*/

        //p.transparent = true;
        //p.setRelativePosition( 0, 0 );

        
        //var d = new Doudecimal_Color( 'AABB0000' );
        //trace( d );
        //p.fillSquare( 1, 1, 3, d );
        //
        //drawGrid( p );
        //p.drawToContext( g.me, 0, 0 );
        
        //
        //drawAlphaTriangle( p );
        //drawRadials( p );
        //drawGridMask( ( p: Pixelimage ) );
        //simonSays( p );
        //p.fillGrad4RoundRect( 1340, 280, 150, 280, 0xff8a7676, 0xff757567, 0xff545951, 0xff51515d );
        //

     }

     public function drawGrid( p: Doudecimal_Image ){
        //p.lineGrid( 10, 10, 240, 240, 100, 2.5, 'AA002200' );
   }
     //public old(){
        // applying Vision test 
        // p == Pixelshape or Pixelimage
        // transfer flips channel 1 and 3 around as I store ABGR for canvas.
        // this is lightly a bit heavy as 1024*4 x 768*4 pixelimage at the moment.
        //
        /*
        var img = new vision.ds.Image( p.width, p.height );
        //p.transferClone()
        injectBytesInImage( p.getBytes(), img );
        Vision.grayscale(img);
        //Vision.convolve( img, BoxBlur);
        //Vision.convolve(img, UnsharpMasking);
        var pTemp = new Pixelimage( p.width, p.height );
        //p.transferIn( pTemp );
        pTemp.fromBytes( extractBytesFromImage( img ), 0 );
        pTemp.drawToContext( g.me, 0, 0 );
*/
        //p.drawFromContext( g.me, 0, 0 );
        //trace( p.getPixelString( 101, 101) );
     //}
    /*
     public function drawRadials( p: Pixelshape ){
          p.fillRadialRectangle( 150, 150, 500, 300, 0xFFc0FF00, 0xFF00c0FF, -0.25, -0.25 );
          p.lineRadialEllipseTri( 600, 650, 290, 200, 100, 100,0xffe100ff, 0xff3a20af, -0.75, -0.75, Math.PI/6 );
     }

     public function simonSays( p: Pixelshape ){
          p.testFillSimonSaysQuadrant( 300, 300, 100 );
     }

     public function drawGridMask( p: Pixelimage ){
          p.hasMask = true;
          var pimage =  p.mask;
          var pixelShape: Pixelshape = cast pimage;
          pixelShape.lineGrid( 150, 150, 1024*3, 768*3, 100, 2.5, 0x0cFFFFFF );
     }

     public function drawGrid( p: Pixelshape ){
          p.lineGrid( 100, 100, 1024*3, 768*3, 100, 2.5, 0xfF003300 );
     }

     public function drawAlphaTriangle( p: Pixelshape ){
        var a = [ 0x33F000c0
                , 0x99F000c0
                , 0xaaF000c0
                , 0xccF000c0
                , 0xeeF000c0];
        var gap = 200;
        for( i in 0...5 ){
            p.fillTri( 100 + i*gap, 900
                     , 300 + i*gap, 1200
                     , 500 + i*gap, 1000
                     , a[i] );
        }
   }
   */
}