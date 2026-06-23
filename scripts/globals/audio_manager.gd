extends Node

var _constant_players: Dictionary = {

}

func add_constant_player(id: StringName, stream: AudioStream) -> AdvancedAudioPlayer:
	if _constant_players.has(id): return _constant_players[id]

	var player: AdvancedAudioPlayer = AdvancedAudioPlayer.new()
	player.stream = stream
	add_child(player)
	_constant_players[id] = player
	player.play()
	return player

func remove_constant_player(id: StringName) -> AdvancedAudioPlayer:
	var player: AdvancedAudioPlayer = _constant_players[id]
	var ret: bool = _constant_players.erase(id)
	if not ret:
		print("remove constant player does not exsist")
	return player

func get_constant_player(id: StringName) -> AdvancedAudioPlayer:
	if not _constant_players.has(id): return null

	return _constant_players[id]

## Creates an [class AdvancedAudioPlayer] with [param stream] and returns it.
func create_player(stream: AudioStream = null) -> AdvancedAudioPlayer:
	var player: AdvancedAudioPlayer = AdvancedAudioPlayer.new()
	add_child(player)
	player.stream = stream
	return player

## Creates an [class AdvancedAudioPlayer3D] with [param stream] and returns it.
func create_player_3d(stream: AudioStream = null) -> AdvancedAudioPlayer3D:
	var player: AdvancedAudioPlayer3D = AdvancedAudioPlayer3D.new()
	add_child(player)
	player.stream = stream
	return player

## Plays [param stream] at [param volume_db] on [param bus] with [param pitch_scale] from [param from_position].
func play_stream(stream: AudioStream, volume_db: float = 0.0, bus: StringName = &'Master', pitch_scale: float = 1.0, from_position: float = 0.0) -> void:
	#create_player().set_volume(volume_db).set_audio_bus(bus).set_pitch(pitch_scale).play_oneshot(from_position)
	var player: AdvancedAudioPlayer = AdvancedAudioPlayer.new()
	add_child(player)
	player.stream = stream
	player.volume_db = volume_db
	player.bus = bus
	player.pitch_scale = pitch_scale
	player.play(from_position)
	await player.finished
	player.queue_free()

## Plays [param stream] at [param volume_db] on [param bus] with [param pitch_scale] from [param from_position].
func play_stream_3d(stream: AudioStream, global_position: Vector3, volume_db: float = 0.0, bus: StringName = &'Master', pitch_scale: float = 1.0, from_position: float = 0.0) -> void:
	#create_player().set_volume(volume_db).set_audio_bus(bus).set_pitch(pitch_scale).play_oneshot(from_position)
	var player: AdvancedAudioPlayer3D = AdvancedAudioPlayer3D.new()
	add_child(player)
	player.global_position = global_position
	player.stream = stream
	player.volume_db = volume_db
	player.bus = bus
	player.pitch_scale = pitch_scale
	player.play(from_position)
	await player.finished
	player.queue_free()
