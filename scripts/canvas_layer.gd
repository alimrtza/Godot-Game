extends CanvasLayer

var score = 0

@onready var score_label = $scorelabel

func add_point():
	score += 1
	score_label.text = "Score: " + str(score)
	
 
