extends Node

var score = 0

@onready var score_count: Label = $score_count

func add_point():
		score += 1
		score_count.text = "You have collected " +str(score) + " coins!"
		
