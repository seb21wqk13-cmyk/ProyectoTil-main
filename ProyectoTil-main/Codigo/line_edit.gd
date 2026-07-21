extends LineEdit

func _ready():
	connect("text_submitted", _on_text_submitted)

func _on_text_submitted(texto: String):
	var label = get_node("/root/Node2D/Label")
	var label2 = get_node("/root/Node2D/Label/LineEdit/Label2")
	
	if label == null or label2 == null:
		print("Nodos no encontrados")
		return
	
	var respuesta = texto.strip_edges().to_lower()
	var correcta = label.palabra_con.strip_edges().to_lower()
	
	if respuesta == correcta:
		label2.text = "✅ ¡Correcto! La palabra es: %s" % label.palabra_con
		label2.modulate = Color.GREEN
		await get_tree().create_timer(2.0).timeout
		get_tree().change_scene_to_file("res://nivel_2.tscn")
	else:
		label2.text = "❌ Incorrecto. La respuesta era: %s" % label.palabra_con
		label2.modulate = Color.RED
		clear()
		await get_tree().create_timer(2.0).timeout
		label2.text = ""
		label2.modulate = Color.WHITE
