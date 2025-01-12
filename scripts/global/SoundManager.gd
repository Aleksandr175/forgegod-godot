extends Node

# We'll keep a single AudioStreamPlayer for the music,
# and an array of players for multiple overlapping SFX.
var music_player: AudioStreamPlayer
var sfx_players: Array = []

var current_music_path: String = ""

func _ready():
	# Music Player Setup
	music_player = AudioStreamPlayer.new()
	music_player.bus = "Music"
	add_child(music_player)

	# Pre-instantiate a few sfx players so we can overlap sounds
	for i in range(4):
		var sfx_player = AudioStreamPlayer.new()
		sfx_player.bus = "SFX"  # or whatever bus you prefer
		add_child(sfx_player)
		sfx_players.append(sfx_player)

func play_sfx(sfx_path: String):
	var sfx_stream = load('res://assets/sounds/' + sfx_path)
	if sfx_stream is AudioStream:
		# Find an available (not playing) player
		for player in sfx_players:
			if not player.playing:
				player.stream = sfx_stream
				player.play()
				return

		# If all are busy, just reuse the first one
		sfx_players[0].stream = sfx_stream
		sfx_players[0].play()

func play_music(music_path: String):
	if current_music_path == music_path:
		# The requested music is already playing
		return

	# If music is playing, fade out current music
	if music_player.playing:
		await fade_out_music(1.0).finished

	current_music_path = music_path

	var music_stream = load(music_path)
	if music_stream is AudioStream:
		music_player.stream = music_stream
		music_player.volume_db = -80  # Start from silence
		music_player.play()
		fade_in_music(1.0)
	else:
		push_warning("Error: Unable to load music stream from path: %s" % music_path)

func fade_out_music(duration: float) -> Tween:
	var tween = create_tween()
	tween.tween_property(music_player, "volume_db", -80, duration)
	return tween

func fade_in_music(duration: float):
	music_player.volume_db = -80
	var tween = create_tween()
	tween.tween_property(music_player, "volume_db", 0, duration)
