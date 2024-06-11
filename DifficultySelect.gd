extends Node2D

func _on_Easy_pressed():
	get_tree().change_scene("res://Main.tscn")
	var main_scene = get_tree().current_scene
	main_scene.start_game(4) # 4 pairs

func _on_Medium_pressed():
	get_tree().change_scene("res://Main.tscn")
	var main_scene = get_tree().current_scene
	main_scene.start_game(8) # 8 pairs

func _on_Hard_pressed():
	get_tree().change_scene("res://Main.tscn")
	var main_scene = get_tree().current_scene
	main_scene.start_game(12) # 12 pairs
