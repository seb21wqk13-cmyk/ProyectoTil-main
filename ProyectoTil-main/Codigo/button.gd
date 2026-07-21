extends Button

func _ready():
	connect("pressed", Callable(self, "_on_button_pressed"))

func _on_button_pressed():
	var nivel_1_scene = load("res://nivel_1.tscn")
	get_tree().change_scene_to_packed(nivel_1_scene)
