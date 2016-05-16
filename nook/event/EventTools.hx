package nook.event;

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
		var index = s.listeners.indexOf( l );
		if ( index >= 0 ) {
			s.listeners.splice( index, 1 );
			return true;
		} else {
			return false;
		}
	}

	public static function emitAsync<T>( s: EventSource<T>, event: T ) {
		for ( l in s.listeners ) {
			l.onEvent( s, event );
		}
	}

	public static var locked(default,null) = false;
	static var emitQueue = new Array<Void->Void>();

	public static function emit<T>( s: EventSource<T>, event: T ) {
		if ( !locked ) {
			locked = true;
			emit( s, event );
			
			var i = 0;
			while ( i < emitQueue.length ) {
				emitQueue[i]();
				i += 1;
			}

			if ( emitQueue.length > 0 ) {
				emitQueue = [];
			}
			locked = false;
		} else {
			emitQueue.push( function() emitAsync( s, event ));
		}
	}
}

