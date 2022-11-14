package doudecimal.format.doudecimalString;

#if neko
inline function toDozenal( doudecimal: String ):String {
    var len = doudecimal.length;
    var no: Int;
    var b = new StringBuf();
    var iter = haxe.iterators.StringIteratorUnicode.unicodeIterator( doudecimal );
    for( i in iter ){
      no = i; 
      b.add(switch( no ){
        case 65:
          '↊';
        case 66:
          '↋';
        case _:
          String.fromCharCode( no );
      });
    }
    return b.toString();
}
#else 
inline function toDozenal( doudecimal: String ):String {
    var len = doudecimal.length;
    var no: Int;
    var b   = new StringBuf();
    for( i in 0...len ){
        no = StringTools.fastCodeAt( doudecimal, i ); 
        b.add(  switch( no ){
                    case 65:
                        '↊';
                    case 66:
                        '↋';
                    case _:
                        String.fromCharCode( no );
                });
    }
    return b.toString();
}
#end
