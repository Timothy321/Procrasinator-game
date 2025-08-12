extends Node

@onready var score_label: Label = $score_label

var score = 0

func add_score():
	score += 1
	score_label.text = "You have " + str(score) + " points!"
