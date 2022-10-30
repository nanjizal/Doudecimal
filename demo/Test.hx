package;

import doudecimal.Doudecimal;

inline function main(){
    trace('test');

    var dd:Doudecimal_ = {doudecimal:"2↊↋"};
    
    trace( dd );
    trace( dd.toDozenal() );
    var v1: Doudecimal = -1;
    trace(v1);
    var v2: Doudecimal = '2A4';
    trace( v2 );
    var v6: Int = v2;
    trace( v6 );
    var v3: Int = v2;
    trace( v3 );
    trace( v1+v2 );
    var v4: Doudecimal = v1+v2;
    var v5: Int = v4;
    var v7: Doudecimal = 1584;
    trace( 'v7 ' + v7 );
    trace( v5 );
    var d0: Doudecimal = 'AB10';
    trace( 'pair ' + d0.pair(0) );
    trace( 'pair ' + d0.pair(1) );

    trace( 'pair ' + d0.single(0) );
    trace( 'pair ' + d0.single(1) );
    trace( 'pair ' + d0.single(2) );
    trace( 'pair ' + d0.single(3) );
    var d2: Doudecimal = 'BBbbBB00';
    for( i in 0...4 ){
        trace( d2.pair(i) );
    }
    // test color
    
    trace( 'color ' + StringTools.hex( d2.dd().colorHex(), 8 ) );
    //var d1: Doudecimal = 'AB10';
    //trace( 'pair ' + d1.pair(1) );
    #if !js
    /*
    var i: Int = 1;
    while( i > 0 ){
        var d: Doudecimal = i;
        trace( i + ' = ' + d.toString() );
        i+=1;
    }
    */
    #end
    var dd:Doudecimal_ = {doudecimal:"BBBBBBBB"};
    var v8: String = StringTools.hex(dd.toInt(),8);
    trace(v8);
}