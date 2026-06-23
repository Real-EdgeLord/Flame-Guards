extends AudioStreamPlayer

class_name AdvancedAudioPlayer

## Adds methods to [AudioStreamPlayer] that return [member self] to allow method chaining for simplified calls.

## Plays [member AudioStreamPlayer.stream] from [param from_position] and deletes it after it finishes.
func play_oneshot(from_position: float = 0.0) -> void:
	play(from_position)
	finish()

## Sets [member volume_db] to [param _volume_db].
func set_volume(_volume_db: float) -> AdvancedAudioPlayer:
	volume_db = _volume_db
	return self

## Sets [member pitch_scale] to [param _pitch_scale].
func set_pitch(_pitch_scale: float) -> AdvancedAudioPlayer:
	pitch_scale = _pitch_scale
	return self

## Sets [member AudioStreamPlayer.bus] to [param _bus].
func set_audio_bus(_bus: StringName) -> AdvancedAudioPlayer:
	bus = _bus
	return self

## Sets [member AudioStreamPlayer.stream] to [param _stream].
func set_audio_stream(_stream: AudioStream) -> AdvancedAudioPlayer:
	stream = _stream
	return self

## Picks a random stream from [param streams], sets [member AudioStreamPlayer.stream] to it.
func set_random_stream(streams: Array[AudioStream]) -> AdvancedAudioPlayer:
	stream = streams.pick_random()
	return self

## Sets [member AudioStreamPlayer.pitch_scale] to a random value between [param min_pitch] and [param max_pitch].
func set_random_pitch(min_pitch: float, max_pitch: float) -> AdvancedAudioPlayer:
	pitch_scale = randf_range(min_pitch, max_pitch)
	return self

## Sets [member AudioStreamPlayer.volume_db] to a random value between [param min_volume] and [param max_volume].
func set_random_volume(min_volume: float, max_volume: float) -> AdvancedAudioPlayer:
	volume_db = randf_range(min_volume, max_volume)
	return self
 
## Fades [member AudioStreamPlayer.volume_db] to [param final_value] with [param duration], ease type of [param ease], and transition type of [param trans].
func fade(final_value: float = -64.0, duration: float = 1.0, ease_type: Tween.EaseType = Tween.EASE_IN, trans: Tween.TransitionType = Tween.TRANS_LINEAR) -> AdvancedAudioPlayer:
	var tween = create_tween().tween_property(self, 'volume_db', final_value, duration).set_ease(ease_type).set_trans(trans)
	await tween.finished
	return self

## Sets [member AudioStreamPlayer.stream_paused] to true
func pause_stream() -> AdvancedAudioPlayer:
	stream_paused = true
	return self

## Sets [member AudioStreamPlayer.stream_paused] to false
func resume_stream() -> AdvancedAudioPlayer:
	stream_paused = false
	return self

## Waits for [member AudioStreamPlayer.stream] to finish then deletes itself
func finish() -> void:
	await finished
	queue_free()
