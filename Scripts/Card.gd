extends TextureButton
class_name Card

var suit
var face
var back
var value


func _ready():
	pass

func _init(var s, var v):
	suit = s
	value = v
	face = load("res://Assets-Memorization/cards/card-"+str(suit)+"-"+str(value)+".png")
	back = GameManager.cardBack
	set_normal_texture(face)
	pass 
