package nook.event;

@:enum abstract EventStatus(Int) {
	var Processed = 0;
	var Queued = 1;
}

class EventTools {
	public static function addListener<T>( s: EventSource<T>, l: EventListener<T> ) {
		if ( s.listeners.indexOf( l ) < 0 ) {
			s.listeners.push( l );
			return true;
		} else {
			return false;
		}
	}

	public static function removeListener<T>( s: EventSource<T>, l: EventListener<T> ) {
		return s.listeners.remove( l );
	}

	public static function notify<T>( s: EventSource<T>, event: T ) {
		for ( l in s.listeners ) {
			l.onEvent( s, event );
		}
	}

	static var messageQueue = new Array<Void->Void>();

	public static function emit<T>( s: EventSource<T>, event: T ): EventStatus {
		if ( messageQueue.length == 0 ) {
			messageQueue.push( null );
			notify( s, event );
			var i = 0;
			while ( ++i < messageQueue.length ) {
				messageQueue[i]();
			}
			messageQueue.splice( 0, messageQueue.length );
			return Processed;
		} else {
			messageQueue.push( function() notify( s, event ));
			return Queued;
		}
	}
}

