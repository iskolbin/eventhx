import nook.event.EventListener;
import nook.event.EventSource;
using nook.event.EventTools;

enum TestEvent {
	SourceName(name: String);
}

class TestObj implements EventSource<TestEvent> implements EventListener<TestEvent> {
	public var name: String;
	public var listeners(default,null) = new Array<EventListener<TestEvent>>();
	
	public function new( name: String ) {
		this.name = name;
	}
	
	public function onEvent( s: EventSource<TestEvent>, e: TestEvent ) {
		switch( e ) {
			case SourceName(srcname): 
				trace( 'source: "${srcname}", processed by: "${name}"' );
				send();
		} 
	}	

	public function send() {
		emit( SourceName(name));
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
	
		o.addListener( oA );
		o.addListener( oB );
		oA.addListener( oA1 );
		oA.addListener( oA2 );
		oB.addListener( oB1 );
		oB.addListener( oB2 );

		o.send();
	}
}

