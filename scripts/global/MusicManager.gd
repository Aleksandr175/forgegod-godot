extends Node

var music_player: AudioStreamPlayer = AudioStreamPlayer.new()
var current_music_path: String = ""

func _ready():
	add_child(music_player)
	music_player.bus = "Music"
	music_player.autoplay = false

func play_music(music_path: String):
	if current_music_path == music_path:
		# The requested music is already playing
		return

	# If music is playing, fade out current music
	if music_player.playing:
		await fade_out_music(1.0).finished

	current_music_path = music_path

	# Load the new music stream
	var music_stream = load(music_path)

	if music_stream is AudioStream:
		# Set the looped property to true
		#music_stream.looped = true

		# Assign the stream to the player
		music_player.stream = music_stream

		# Start with volume at minimum for fade-in
		music_player.volume_db = -80  # Silence

		# Play the music
		music_player.play()

		# Fade in the new music
		fade_in_music(1.0)
	else:
		print("Error: Unable to load music stream from path:", music_path)

func fade_out_music(duration: float) -> Tween:
	var tween = create_tween()
	tween.tween_property(music_player, "volume_db", -80, duration)
	return tween

func fade_in_music(duration: float):
	music_player.volume_db = -80  # Start from silence
	var tween = create_tween()
	tween.tween_property(music_player, "volume_db", 0, duration)
