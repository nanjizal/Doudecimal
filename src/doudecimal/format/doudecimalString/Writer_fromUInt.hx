package doudecimal.format.doudecimalString;
import doudecimal.format.doudecimalString.Powers;

/**
    writer for Int
**/
inline function convertPair( targ: UInt ): String {
    return if( targ == 0 ){
      '0';
    } else {
      targTemp = targ;
      var s = '';
      s = digitProcess( v1, s );
      s = digitProcess( v0, s );
      //s = stripLeading0( s );  
      s;
    }
}
inline function getBigBase12( no: UInt ): String {
	var out = '';
    var large = no > 0xFFFFFF;
    return if( large ){
        // no / 144*144 can consider no>>4/3 no<<4*3
        var topU: Int = Std.int( ( no>>8 )/81 );
        var bottomU: Int = no - (topU<<8)*81; 
        var bottomS = getBase12( bottomU );
        bottomS     = stripLeading0s( bottomS );
        var topS    = getBase12( topU );
        topS        = stripLeading0s( topS );
        topS + bottomS;
    } else {
	    var allS = getBase12( no );
        allS = stripLeading0s( allS );
        allS;
    }
}

inline function padLeading0s( str: String, no: Int ): String {
    var s = '';
    for( i in 0...no-str.length ) s += '0';
    s = s + str;
    return s;
}
inline function stripLeading0s( s: String ): String {
    var j = 0;
    for( i in 0...s.length ){
        if( s.charAt( i ) != '0' ){
            j = i;
            break;
        }
    }
    return s.substr( j );
}
inline function getBase12( no: UInt ): String {
	var str = '';
	targTemp = no;
    // TODO: unwrap for loop and remove array? Reconsider removing some of these terms as not needed.
	var v:Array<UInt> = [ v8, v7, v6, v5, v4, v3, v2, v1, v0 ];
	for (i in 0...9) {
		str = digitProcess( v[ i ], str);
	}
	return str;
}
var targTemp:Int;
inline function digitProcess( vx: Int, s: String ): String {
	var o = 0;
	for (i in 0...12) {
		var tt:Int = targTemp - vx;
		if (tt >= 0) {
			targTemp = targTemp - vx;
			o++;
		} else {
			s = s + ((o == 10) ? 'A' : ((o == 11) ? 'B' : Std.string(o)));
			break;
		}
	}
	return s;
}
