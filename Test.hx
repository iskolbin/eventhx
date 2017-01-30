import nook.event.EventListener;
import nook.event.EventSource;
using nook.event.EventTools;

enum TestEvent {
	First(name: String);
	Second(value: Int);
	Third(k: Float);
}

class TestObj 
	implements EventSource<TestEvent>
	implements EventListener<TestEvent>
{
	
	public var name: String;
	public var listeners(default,null) = new Array<EventListener<TestEvent>>();
	
	public function new( name: String ) {
		this.name = name;
	}
	
	public function onEvent( s: EventSource<TestEvent>, e: TestEvent ) {
		switch( e ) {
			case First(srcname): 
				trace( 'first: "${srcname}", processed by: "${name}"' );
				emit( Second(42));
			case Second(value):
				trace( 'second: "${value}", processed by: "${name}"' );
				emit( Third(14.15));
			case Third(v):
				trace( 'third: "${v}", processed by: "${name}"' );
		} 
	}	

	public function send() {
		emit( First(name));
	}
}

class Test {
	public static function main() {
		var o = new TestObj("o");
		var oA = new TestObj("oA");
		var oB = new TestObj("oB");
		var oA1 = new TestObj("oA1");
		var oA2 = new TestObj("oA2");
		var oB1 = new TestObj("oB1");
		var oB2 = new TestObj("oB2");
		var oAA1 = new TestObj("oAA1");
		var oAA2 = new TestObj("oAA2");
		var oBB1 = new TestObj("oBB1");
		var oBB2 = new TestObj("oBB2");


		o.addListener( oA );
		o.addListener( oB );
		oA.addListener( oA1 );
		oA.addListener( oA2 );
		oB.addListener( oB1 );
		oB.addListener( oB2 );
		oA1.addListener( oAA1 );
		oA2.addListener( oAA2 );
		oB1.addListener( oBB1 );
		oB2.addListener( oBB2 );

		o.send();
	}
}

