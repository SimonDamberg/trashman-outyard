extends CanvasLayer

func _on_Score_update_score(score):
	$Score.text = str(score)
