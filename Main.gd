extends Node2D

export(PackedScene) var card_scene

var card_colors = [
	Color(1, 0, 0), Color(1, 0, 0),
	Color(0, 1, 0), Color(0, 1, 0),
	Color(0, 0, 1), Color(0, 0, 1),
	Color(1, 1, 0), Color(1, 1, 0),
	Color(0, 1, 1), Color(0, 1, 1),
	Color(1, 0, 1), Color(1, 0, 1),
	Color(1, 0.5, 0), Color(1, 0.5, 0),
	Color(0.5, 0, 1), Color(0.5, 0, 1)
]

var first_card = null
var second_card = null
var can_flip = true
var move_count = 0
var total_pairs = 0
var matched_pairs = 0

onready var move_counter = $MoveCounter
onready var time_counter = $TimeCounter
onready var game_timer = $GameTimer
onready var win_popup = $WinPopup
onready var win_label = $WinPopup/Label

func _ready():
	# Inicializa el juego en modo fácil por defecto
	start_game(4)

func start_game(pairs):
	total_pairs = pairs
	move_count = 0
	matched_pairs = 0
	can_flip = true
	move_counter.text = "Moves: 0"
	time_counter.text = "Time: 0"
	game_timer.start()
	_initialize_board(pairs)

func _initialize_board(pairs):
	card_colors.shuffle()
	var selected_colors = card_colors.slice(0, pairs * 2)
	selected_colors.shuffle()

	# Eliminar todos los hijos de CardGrid
	for child in $CardGrid.get_children():
		$CardGrid.remove_child(child)
		child.queue_free()

	for color in selected_colors:
		var card = card_scene.instance()
		card.set_card_front_color(color)
		var result = card.connect("pressed", self, "_on_card_pressed", [card])
		assert(result == OK)
		$CardGrid.add_child(card)

func _on_card_pressed(card):
	if not can_flip or card.is_flipped or card.is_matched:
		return

	card.flip_up()

	if first_card == null:
		first_card = card
	elif second_card == null:
		second_card = card
		can_flip = false
		_check_for_match()
		move_count += 1
		move_counter.text = "Moves: %d" % move_count

func _check_for_match():
	if first_card.card_front.color == second_card.card_front.color:
		first_card.is_matched = true
		second_card.is_matched = true
		matched_pairs += 1
		if matched_pairs == total_pairs:
			_game_won()
		_reset_cards()
	else:
		yield(get_tree().create_timer(1.0), "timeout")
		first_card.flip_down()
		second_card.flip_down()
		_reset_cards()

func _reset_cards():
	first_card = null
	second_card = null
	can_flip = true

func _on_GameTimer_timeout():
	var time = game_timer.time_left
	time_counter.text = "Time: %d" % time

func _game_won():
	game_timer.stop()
	show_message("You won in %d moves and %d seconds!" % [move_count, game_timer.time_left])

func show_message(text):
	win_label.text = text
	win_popup.popup_centered()
