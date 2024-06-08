extends Button

var is_flipped = false
var is_matched = false

onready var card_front = $CardFront
onready var card_back = $CardBack

func _ready():
	card_front.visible = false
	card_back.visible = true
	connect("pressed", self, "_on_card_pressed")

func _on_card_pressed():
	if is_matched:
		return

	if is_flipped:
		flip_down()
	else:
		flip_up()

func flip_up():
	is_flipped = true
	card_front.visible = true
	card_back.visible = false

func flip_down():
	is_flipped = false
	card_front.visible = false
	card_back.visible = true

func set_card_front_texture(texture):
	card_front.texture = texture
