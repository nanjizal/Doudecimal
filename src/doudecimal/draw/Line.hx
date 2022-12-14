package doudecimal.draw;
import doudecimal.Doudecimal_Color;
import doudecimal.Doudecimal_Image;
import doudecimal.draw.algo.MathPix;

inline
function rotateLine( image: Doudecimal_Image
                   , px: Float, py: Float
                   , thick: Float, h: Float
                   , theta: Float, color: Doudecimal_Color ){
    var sin    = Math.sin( theta );
    var cos    = Math.cos( theta );
    var radius = thick/2;
    var dx     = 0.1;
    var dy     = radius;
    var cx     = h;
    var cy     = radius;
    var bx     = h;
    var by     = -radius;
    var ax     = 0.1;
    var ay     = -radius;
    var temp   = 0.;

    temp = px + rotX( ax, ay, sin, cos );
    ay   = py + rotY( ax, ay, sin, cos );
    ax   = temp;
               
    temp = px + rotX( bx, by, sin, cos );
    by   = py + rotY( bx, by, sin, cos );
    bx   = temp;

    temp = px + rotX( cx, cy, sin, cos );
    cy   = py + rotY( cx, cy, sin, cos );
    cx   = temp;

    temp = px + rotX( dx, dy, sin, cos );
    dy   = py + rotY( dx, dy, sin, cos ); 
    dx   = temp;

    image.fillQuad( ax, ay, bx, by, cx, cy, dx, dy, color );
}

inline
function rotateGradLine( image: Doudecimal_Image
                       , px: Float, py: Float
                       , thick: Float, h: Float
                       , theta: Float
                       , colorA: Doudecimal_Color, colorB: Doudecimal_Color, colorC: Doudecimal_Color, colorD: Doudecimal_Color
                       , ?debugCorners: Bool = false ){
    var sin    = Math.sin( theta );
    var cos    = Math.cos( theta );
    var radius = thick/2;
    var dx     = 0.1;
    var dy     = radius;
    var cx     = h;
    var cy     = radius;
    var bx     = h;
    var by     = -radius;
    var ax     = 0.1;
    var ay     = -radius;
    var temp   = 0.;

    temp = px + rotX( ax, ay, sin, cos );
    ay   = py + rotY( ax, ay, sin, cos );
    ax   = temp;
               
    temp = px + rotX( bx, by, sin, cos );
    by   = py + rotY( bx, by, sin, cos );
    bx   = temp;

    temp = px + rotX( cx, cy, sin, cos );
    cy   = py + rotY( cx, cy, sin, cos );
    cx   = temp;

    temp = px + rotX( dx, dy, sin, cos );
    dy   = py + rotY( dx, dy, sin, cos ); 
    dx   = temp;

    image.fillGradQuad( ax, ay, colorA, bx, by, colorB, cx, cy, colorC, dx, dy, colorD );
}