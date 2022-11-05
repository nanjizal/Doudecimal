package doudecimal.format.doudecimalString;

/**
    Reader form doudecimal digit string to Digit Int
**/

inline function toDigit( str: String ): UInt {
    return if( str == 'A' ){
      10;
    } else if( str == 'B' ){
      11;
    } else {
      Std.parseInt( str );
    }
}