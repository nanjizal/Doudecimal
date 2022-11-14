package doudecimal.draw;

import doudecimal.draw.iter.BoundIterator;
                            // boundIterator3
import doudecimal.draw.iter.IteratorRange;
import doudecimal.Doudecimal_Color;
import doudecimal.Doudecimal_Image;
import doudecimal.draw.algo.MathPix;

// Triangle module

    inline 
    function fillTriUnsafe( image: Doudecimal_Image
                          , ax: Float, ay: Float
                          , bx: Float, by: Float
                          , cx: Float, cy: Float
                          , color: Doudecimal_Color ){
        var s0 = ay*cx - ax*cy;
        var sx = cy - ay;
        var sy = ax - cx;
        var t0 = ax*by - ay*bx;
        var tx = ay - by;
        var ty = bx - ax;
        var A = -by*cx + ay*(-bx + cx) + ax*(by - cy) + bx*cy; 
        var yIter3: IteratorRange = boundIterator3( ay, by, cy );
        var foundY = false;
        var s = 0.;
        var t = 0.;
        var sxx = 0.;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
        var txx = 0.;
        for( x in boundIterator3( ax, bx, cx ) ){
            sxx = sx*x;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
            txx = tx*x;
            foundY = false;
            for( y in yIter3 ){
                s = s0 + sxx + sy*y;
                t = t0 + txx + ty*y;
                if( s <= 0 || t <= 0 ){
                    // after filling break
                    if( foundY ) break;
                } else {
                    if( (s + t) < A ) {
                        // store first hit
                        image.set_doudecimalPixel( x, y, color );
                        foundY = true;
                    } else {
                        // after filling break
                        if( foundY ) break;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
                    }
                }
            }                                                                                                                                                                                                                                                                                                                                                                                                                                
        }
    }

    inline
    function fillGradTriangle(  image: Doudecimal_Image
                            ,   ax: Float, ay: Float, colA: Doudecimal_Color
                            ,   bx: Float, by: Float, colB: Doudecimal_Color
                            ,   cx: Float, cy: Float, colC: Doudecimal_Color ){
        var aA  = colB.alpha;
        var rA  = colB.red;
        var gA  = colB.green;
        var bA  = colB.blue;
        var aB  = colA.alpha;
        var rB  = colA.red;
        var gB  = colA.green;
        var bB  = colA.blue;
        var aC  = colC.alpha;
        var rC  = colC.red;
        var gC  = colC.green;
        var bC  = colC.blue;
        var bcx = bx - cx;
        var bcy = by - cy;
        var acx = ax - cx; 
        var acy = ay - cy;
        // Had to re-arrange algorithm to work so dot names may not quite make sense.
        var dot11 = dotSame( bcx, bcy );
        var dot12 = dot( bcx, bcy, acx, acy );
        var dot22 = dotSame( acx, acy );
        var denom1 = 1/( dot11 * dot22 - dot12 * dot12 );
        for( px in boundIterator3( cx, bx, ax ) ){
            var pcx = px - cx;
            for( py in boundIterator3( cy, by, ay ) ){
                var pcy = py - cy;
                var dot31 = dot( pcx, pcy, bcx, bcy );
                var dot32 = dot( pcx, pcy, acx, acy );
                var ratioA = (dot22 * dot31 - dot12 * dot32) * denom1;
                var ratioB = (dot11 * dot32 - dot12 * dot31) * denom1;
                var ratioC = 1.0 - ratioB - ratioA;
                if( ratioA >= 0 && ratioB >= 0 && ratioC >= 0 ){
                    var a = aA*ratioA + aB*ratioB + aC*ratioC;
                    var r = rA*ratioA + rB*ratioB + rC*ratioC;
                    var g = gA*ratioA + gB*ratioB + gC*ratioC;
                    var b = bA*ratioA + bB*ratioB + bC*ratioC;
                    var d = new Doudecimal_Color();
                    d.ARGB = { a: a, r: r, g: g, b: b };
                    image.set_doudecimalPixel( px, py, d );
                }
            }
        }
    }