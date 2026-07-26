extends Node

class Event extends Resource:
	var signals : Array[Signal] = []
	var callables : Array[Callable] = []
	var arguments : Array = []


## List of events
var events := {
}

## List of signals and/or callables that need to be removed
var _removal_queue := []

func create_event(event: String) -> Error:
	if not event in events:
		events[event] = Event.new()
		return OK
	return ERR_ALREADY_EXISTS

## Register event to event dictionary
func register_event(event: String, sig: Signal, args: Array = []) -> void:
	if not event in events:
		events[event] = Event.new()
		events[event].signals.append(sig)
		events[event].arguments = args
#		_update_links(event)
	else:
		events[event].signals.append(sig)
		events[event].arguments = args
		_update_links(event)

## Connects an event's signals to its callables.
## If there are broken links (a node is freed), it adds them to the removal queue and [code]_clean()[/code]s them
func _update_links(event: String) -> void:
	for callable in events[event].callables as Array[Callable]:
		if callable.get_object():
			for sig in events[event].signals as Array[Signal]:
				if sig.get_object():
					var bound = callable.bindv(events[event].arguments)
					if not sig.is_connected(bound):
						sig.connect(bound)
				else:
					_removal_queue.append([event, 'signals', sig])
		else:
			_removal_queue.append([event, 'callables', callable])
	
	if _removal_queue.size() > 0:
		_clean()

## Disconnects links in the removal queue
func _clean() -> void:
	for trash in _removal_queue:
		events[trash[0]].get(trash[1]).erase(trash[2])
	_removal_queue.clear()

## Connects an event to a method
func link_event(event: String, method: Callable) -> Error:
	if event in events:
		events[event].callables.append(method)
		for sig in events[event].signals:
			sig.connect(method)
		return OK
	else:
		push_error('Event does not exist')
		return ERR_DOES_NOT_EXIST
