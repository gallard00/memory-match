extends Node

onready var Game = get_node('/root/Game')
var cardBack = preload("res://Assets-Memorization/cards/cardBack_blue2.png")

var deck = Array()

func _ready():
	fillDeck()
	dealDeck()
	pass
	
func fillDeck():
	deck.append(Card.new(1,1))
	pass
	
func dealDeck():
	Game.get_node('Grid').add_child(deck[0])
