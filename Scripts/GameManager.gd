extends Node

onready var Game = get_node('/root/Game')
var cardBack = preload("res://Assets-Memorization/cards/cardBack_blue2.png")

var deck = Array()

func _ready():
	fillDeck()
	dealDeck()
	pass
	
func fillDeck():
	#deck.append(Card.new(1,1))
	
	var s = 1
	var v = 1
	while s < 5:
		v = 1
		while v < 14:
			deck.append(Card.new(s,v))
			v = v + 1
			
		s += 1
	pass
func dealDeck():
	#Game.get_node('Grid').add_child(deck[0])
	for i in deck.size():
		Game.get_node('Grid').add_child(deck[i])
