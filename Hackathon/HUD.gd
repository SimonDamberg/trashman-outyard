extends CanvasLayer

signal buy_speed
signal buy_rate
signal buy_limit

var current_score = 0

func _on_Score_update_score(score):
	$Score.text = str(score)
	current_score = score

func _on_OpenShop_pressed():
	get_node("shop").visible = !get_node("shop").visible
	get_node("BuySpeed").visible = !get_node("BuySpeed").visible
	get_node("SpawnRate").visible = !get_node("SpawnRate").visible
	get_node("TrashLimit").visible = !get_node("TrashLimit").visible

func _on_BuySpeed_pressed():
	emit_signal("buy_speed", current_score)

func _on_SpawnRate_pressed():
	emit_signal("buy_rate", current_score)

func _on_TrashLimit_pressed():
	emit_signal("buy_limit", current_score)

func _on_GameController_update_score(score):
	$Score.text = str(score)
	current_score = score

func _on_Player_update_score(score):
	$Score.text = str(score)
	current_score = score
