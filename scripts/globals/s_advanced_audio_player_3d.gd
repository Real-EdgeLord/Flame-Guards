class_name AdvancedAudioPlayer3D extends AudioStreamPlayer3D

## Adds methods to [AudioStreamPlayer3D] that return [member self] to allow method chaining for simplified calls.

## Plays [member AudioStreamPlayer3D.stream] from [param from_position] and deletes it after it finishes.
func play_oneshot(from_position: float = 0.0) -> void:
	play(from_position)
	finish()

## Sets [member volume_db] to [param _volume_db].
func set_volume(_volume_db: float) -> AdvancedAudioPlayer3D:
	volume_db = _volume_db
	return self

## Sets [member pitch_scale] to [param _pitch_scale].
func set_pitch(_pitch_scale: float) -> AdvancedAudioPlayer3D:
	pitch_scale = _pitch_scale
	return self

## Sets [member AudioStreamPlayer3D.bus] to [param _bus].
func set_audio_bus(_bus: StringName) -> AdvancedAudioPlayer3D:
	bus = _bus
	return self

## Sets [member AudioStreamPlayer3D.stream] to [param _stream].
func set_audio_stream(_stream: AudioStream) -> AdvancedAudioPlayer3D:
	stream = _stream
	return self

## Picks a random stream from [param streams], sets [member AudioStreamPlayer3D.stream] to it.
func set_random_stream(streams: Array[AudioStream]) -> AdvancedAudioPlayer3D:
	stream = streams.pick_random()
	return self

## Sets [member AudioStreamPlayer3D.pitch_scale] to a random value between [param min_pitch] and [param max_pitch].
func set_random_pitch(min_pitch: float, max_pitch: float) -> AdvancedAudioPlayer3D:
	pitch_scale = randf_range(min_pitch, max_pitch)
	return self

## Sets [member AudioStreamPlayer3D.volume_db] to a random value between [param min_volume] and [param max_volume].
func set_random_volume(min_volume: float, max_volume: float) -> AdvancedAudioPlayer3D:
	volume_db = randf_range(min_volume, max_volume)
	return self

## Fades [member AudioStreamPlayer3D.volume_db] to [param final_value] with [param duration], ease type of [param ease], and transition type of [param trans].
func fade(final_value: float = -64.0, duration: float = 1.0, ease_type: Tween.EaseType = Tween.EASE_IN, trans: Tween.TransitionType = Tween.TRANS_LINEAR) -> AdvancedAudioPlayer3D:
	var tween: Tween = create_tween()
	var tween_property: PropertyTweener = tween.tween_property(self, "volume_db", final_value, duration)
	tween_property = tween_property.set_ease(ease_type)
	tween_property = tween_property.set_trans(trans)
	await tween.finished
	return self

## Sets [member AudioStreamPlayer.stream_paused] to true
func pause_stream() -> AdvancedAudioPlayer3D:
	stream_paused = true
	return self

## Sets [member AudioStreamPlayer.stream_paused] to false
func resume_stream() -> AdvancedAudioPlayer3D:
	stream_paused = false
	return self

## Waits for [member AudioStreamPlayer3D.stream] to finish then deletes itself
func finish() -> void:
	await finished
	queue_free()
