package doudecimal.format.doudecimalString;

/**
    Writer form digit to doudecimal digit string
**/

inline function fromDigit( dig: UInt ): String {
    return if( dig < 10 ){
        Std.string( dig );
    } else if( dig == 10 ){
        'A';
    } else if( dig == 11 ){
        'B';
    } else {
        '?';
    }
}