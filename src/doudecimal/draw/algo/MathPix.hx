package doudecimal.draw.algo;

import doudecimal.Doudecimal_Color;
import doudecimal.Doudecimal_Image;

// Module GeomPix

// Ken Perlin smoothStep 
inline 
function smootherStep( t: Float ): Float {
    return t * t * t * (t * (t * 6.0 - 15.0) + 10.0);
}
inline 
function lerp( a: Float, b: Float, t: Float ): Float
    return b + ( b - a ) * t;
inline
function lerp4Colors( colorhiA: Doudecimal_Color, colorhiB: Doudecimal_Color
                    , colorloC: Doudecimal_Color, colorloD: Doudecimal_Color
                    , u: Float, v: Float
                    , smooth: Bool = true ): Doudecimal_Color {
    var hiColor = lerp2Colors( colorhiA, colorhiB, u, smooth );
    var loColor = lerp2Colors( colorloC, colorloD, u, smooth );
    return lerp2Colors( hiColor, loColor, v, smooth );
}
// HSL better, but this for initial test.
inline
function lerp2Colors( colA: Doudecimal_Color, colB: Doudecimal_Color, t: Float
                    , smooth: Bool = true ): Doudecimal_Color {
    var aA = colB.alpha;
    var rA = colB.red;
    var gA = colB.green;
    var bA = colB.blue;
    var aB = colA.alpha;
    var rB = colA.red;
    var gB = colA.green;
    var bB = colA.blue;
    var v = ( smooth )? smootherStep( t ): t;
    // check if values same.
    var af = lerp( aA, aB, v );
    var rf = lerp( rA, rB, v );
    var gf = lerp( gA, gB, v );
    var bf = lerp( bA, bB, v );
    var d = new Doudecimal_Color();
    d.ARGB = { a: af, r: rf, g: gf, b: bf };
    return d;
}

inline
function cross2d( ax: Float, ay: Float, bx: Float, by: Float ): Float
    return ax * by - ay * bx;

inline
function dot( ax: Float, ay: Float, bx: Float, by: Float ): Float
    return ax * bx + ay * by;

inline
function dotSame( ax: Float, ay: Float ): Float
    return dot( ax, ay, ax, ay );

inline
function distanceSquarePointToSegment( x:  Float, y: Float
                                        , x1: Float, y1:Float
                                        , x2: Float, y2:Float
                                        ): Float {
    var p1_p2_squareLength = (x2 - x1)*(x2 - x1) + (y2 - y1)*(y2 - y1);
    var dotProduct = ((x - x1)*(x2 - x1) + (y - y1)*(y2 - y1)) / p1_p2_squareLength;
    return if ( dotProduct < 0 ){
                (x - x1)*(x - x1) + (y - y1)*(y - y1);
            } else if ( dotProduct <= 1 ){
                var p_p1_squareLength = (x1 - x)*(x1 - x) + (y1 - y)*(y1 - y);
                p_p1_squareLength - dotProduct * dotProduct * p1_p2_squareLength;
            } else {
                (x - x2)*(x - x2) + (y - y2)*(y - y2);
            }
}
inline
function rotX( x: Float, y: Float, sin: Float, cos: Float )
    return x * cos - y * sin;

inline
function rotY( x: Float, y: Float, sin: Float, cos: Float )
    return y * cos + x * sin;
    
inline
function boundChannel( f: Float ): Int {
    var i = Std.int( f );
    if( i > 143 ) i = 143;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
    if( i < 0 ) i = 0;
    return i;
}