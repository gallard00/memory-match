extends Node2D

export(PackedScene) var card_scene
export(Array) var card_textures

var first_card = null
var second_card = null
var can_flip = true

func _ready():
	_initialize_board()

func _initialize_board():
	var cards = []
	
	# Create pairs of card textures
	for texture in card_textures:
		cards.append(texture)
		cards.append(texture)
	
	# Shuffle the cards
	cards.shuffle()

	# Instantiate card scenes
	for texture in cards:
		var card = card_scene.instance()
		card.set_card_front_texture(texture)
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
	if first_card.card_front.texture == second_card.card_front.texture:
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
