package doudecimal;
import doudecimal.format.doudecimalString.Writer;
import doudecimal.format.doudecimalString.Reader;

@:structInit
class Doudecimal_ {
    public var doudecimal: String;
    public var uint: UInt;
    public inline
    function new( doudecimal: String = '0' )
        writeValue( doudecimal );
    
    public inline
    function writeValue( str: String ){
        if( str == '' || str == '0' ){
            uint = 0;
            doudecimal = '0';
        } else {
            doudecimal = toStr( str );
            uint       = toUInt_( doudecimal );
        }
    }
    public inline function toUInt(){
        uint = toUInt_( doudecimal );
        return uint;
    }
    inline static
    function empty()
        return Type.createEmptyInstance( Doudecimal_ );
    
    public inline static
    function quickZero(): Doudecimal_ {
        var out = empty();
        out.uint = 0;
        out.doudecimal = '0';
        return out;
    }
    public inline
    function zeroPad( no: Int ){
        if( no > 0 ){
            var s = '';
            for( i in 0...no - length ) s += '0';
            s = s + this.doudecimal;
            this.doudecimal = s;
        }
    }
    public var length( get, never ): Int;
    public inline
    function get_length(): Int
        return doudecimal.length;
    
    public inline
    function toDozenal(): String
        return toDozenal_( doudecimal );

    public inline
    function substr( pos: Int, len: Int )
        return doudecimal.substr( pos, len );

    public inline
    function pair( no: Int ): Doudecimal_{
        var no1 = no;
        return  if( length >= Std.int( no*2 ) ){
                    var p = substr( Std.int( no1*2 ), 2 );
                    new Doudecimal_( p );
                } else {
                    quickZero(); 
                }
    }
    public inline
    function splicePair( no: Int, pair_: Doudecimal_ ){
        var buf: StringBuf = new StringBuf();
        var pos0           = 2*(no-1);
        var pos1           = pos0+1;
        var l              = this.doudecimal.length;
        var toggle         = true;
        for( i in 0...l ){
            if( i != pos0 && i != pos1 ){
                buf.addChar( StringTools.fastCodeAt(this.doudecimal, i ) ); 
            } else {
            if( toggle ){
                toggle = false;
                buf.addChar( StringTools.fastCodeAt( pair_.doudecimal, 0 ) );  
            } else {
                buf.addChar( StringTools.fastCodeAt( pair_.doudecimal, 1 ) );
            }
        }
    }
        writeValue( buf.toString() );
    }
    public inline function replaceAt( no: Int, d: Doudecimal_ ){
        var buf: StringBuf = new StringBuf();
        var l              = this.length;
        var l2             = d.length;
        var pos0           = no;
        var pos1           = pos0 + l2;
        var dCount = 0;
        for( i in 0...l ){
            if( i < pos0 && i > pos1 ){
                buf.addChar( StringTools.fastCodeAt( doudecimal, i ) ); 
            } else {
                buf.addChar( StringTools.fastCodeAt( d.doudecimal, dCount ) );
                dCount++;
            }
        }
        writeValue( buf.toString() );
    }
    public inline
    function single( no: Int ): Doudecimal_{
        return  if( length >= no ){
                    var p = substr( no, 1 );
                    new Doudecimal_( p );
                } else {
                    quickZero();
                }
    }
    @:keep 
    public inline function toString(): String
        return doudecimal;

    static inline 
    function convertPair( targ: Int ): String
        return convertPair( targ );

    public inline static 
    function fromDigit( dig: UInt ): String
        return fromDigit_( dig );
    
    public inline static
    function toDigit( str: String ): UInt
        return digitToUInt( str );

    public inline static
    function from2Channel( decimal: UInt ): Doudecimal_ {
        // assumes positive and within range as only called for colors?
        var out: Doudecimal_ = Type.createEmptyInstance( Doudecimal_ );
        out.doudecimal = convertPair( decimal );
        out.uint = decimal;
        return out;
    }
    public inline static
    function fromUInt( decimal: UInt ): Doudecimal_{
        var out = empty();
        out.doudecimal = fromUInt_( decimal );
        out.uint = decimal;
        return out;
    } 
}
