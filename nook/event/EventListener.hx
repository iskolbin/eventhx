package nook.event;

interface EventListener<T> {
	public function onEvent( source: EventSource<T>, event: T ): Void;
}
