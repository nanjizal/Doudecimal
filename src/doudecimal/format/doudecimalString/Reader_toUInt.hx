package doudecimal.format.doudecimalString;

/**
    Reader to convert Doudecimal string into an UInt
**/

inline function toUInt( doudecimal: String ): UInt{ 
    var len = doudecimal.length;
    var n: Int = len - 1;
    var multi: Float;
    var out = 0.;
    var no = 0.;
    var dozit = '';
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
    return Std.int( out );
}  