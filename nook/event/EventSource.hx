package nook.event;

interface EventSource<T>{
	public var listeners(default,null): Array<EventListener<T>>;
}
