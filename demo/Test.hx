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
    // neko highest = 175598
    // gets dodgy after about 0xFFFFFF on JS.
    for( i in 0...1000 ){
        var d: Doudecimal = i;
        trace( i + ' = ' + d.toString() );
    }
    
}