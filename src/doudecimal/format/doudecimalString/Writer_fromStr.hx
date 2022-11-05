package doudecimal.format.doudecimalString;

/**
    Writer for String
**/

#if neko
inline function checkStr( s: String ){
  var len = s.length;
  var b = new StringBuf();
  var no = 0;
  var iter = haxe.iterators.StringIteratorUnicode.unicodeIterator( s );
  for( i in iter ){
    no = i;
    switch( no ){
        case 48:
          b.add( '0' );
        case 49:
          b.add( '1' );
        case 50:
          b.add( '2' );
        case 51:
          b.add( '3' );
        case 52:
          b.add( '4' );
        case 53:
          b.add( '5' );
        case 54:
          b.add( '6' );
        case 55:
          b.add( '7' );
        case 56:
          b.add( '8' );
        case 57:
          b.add( '9' );
        case 97:
          b.add( 'A' );
        case 98:
          b.add( 'B' );
        case 65:
          b.add( 'A' );
        case 66:
          b.add( 'B' );
        case 84:
          b.add( 'A' );
        case 116:
          b.add( 'A' );
        case 88:
          b.add( 'A' );
        case 102:
          b.add( 'A' );
        case 69:
          b.add( 'B' );
        case 90:
          b.add( 'B' );
        case 122:
          b.add( 'B' );
        case 59:
          b.add( ';');
        case 8586:
          b.add( 'A' );	  
        case 8587:
          b.add( 'B' );
        case 35:
          b.add( 'A' );
        case 42:
          b.add( 'B' );
        case 45:
          if( i == 0 ){
            b.add( '-' );
            } else {  
            throw 'invalid Doudecimal';
            }
      case _:
        throw 'invalid Doudecimal';
    } 
  }
  return b.toString();
}
#else 
inline function checkStr( s: String ){
  var len = s.length;
  var b = new StringBuf();
  var no = 0;
  for( i in 0...len ){
    no = StringTools.fastCodeAt( s, i );
    switch( no ){
        case 48:
          b.add( '0' );
        case 49:
          b.add( '1' );
        case 50:
          b.add( '2' );
        case 51:
          b.add( '3' );
        case 52:
          b.add( '4' );
        case 53:
          b.add( '5' );
        case 54:
          b.add( '6' );
        case 55:
          b.add( '7' );
        case 56:
          b.add( '8' );
        case 57:
          b.add( '9' );
        case 97:
          b.add( 'A' );
        case 98:
          b.add( 'B' );
        case 65:
          b.add( 'A' );
        case 66:
          b.add( 'B' );
        case 84:
          b.add( 'A' );
        case 116:
          b.add( 'A' );
        case 88:
          b.add( 'A' );
        case 102:
          b.add( 'A' );
        case 69:
          b.add( 'B' );
        case 90:
          b.add( 'B' );
        case 122:
          b.add( 'B' );
        case 59:
          b.add( ';');
        case '↊'.code:
          b.add( 'A' );	  
        case '↋'.code:
          b.add( 'B' );
        case 35:
          b.add( 'A' );
        case 42:
          b.add( 'B' );
        case 45:
          if( i == 0 ){
            b.add( '-' );
            } else {  
            throw 'invalid Doudecimal';
            }
      case _:
        throw 'invalid Doudecimal';
    } 
  }
  return b.toString();
}
#end