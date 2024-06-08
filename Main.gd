extends Node2D

export(PackedScene) var card_scene

var card_colors = [
	Color(1, 0, 0), Color(1, 0, 0),  # Red pairs
	Color(0, 1, 0), Color(0, 1, 0),  # Green pairs
	Color(0, 0, 1), Color(0, 0, 1),  # Blue pairs
	Color(1, 1, 0), Color(1, 1, 0),  # Yellow pairs
	Color(0, 1, 1), Color(0, 1, 1),  # Cyan pairs
	Color(1, 0, 1), Color(1, 0, 1),  # Magenta pairs
	Color(1, 0.5, 0), Color(1, 0.5, 0),  # Orange pairs
	Color(0.5, 0, 1), Color(0.5, 0, 1)   # Purple pairs
]

var first_card = null
var second_card = null
var can_flip = true

func _ready():
	_initialize_board()

func _initialize_board():
	card_colors.shuffle()

	for color in card_colors:
		var card = card_scene.instance()
		card.set_card_front_color(color)
		card.connect("pressed", self, "_on_card_pressed", [card])
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

func _check_for_match():
	if first_card.card_front.color == second_card.card_front.color:
		first_card.is_matched = true
		second_card.is_matched = true
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
