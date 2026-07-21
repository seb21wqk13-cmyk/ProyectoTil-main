extends CharacterBody2D

# Ruta a la escena emergente (Popup)
var popup_scene = preload("res://pregunta.tscn")
var popup_instance = null

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	# Verifica que el cuerpo con el que colisiona sea el que quieres (opcional)
	if body.is_in_group("player"):  # Por ejemplo, si el jugador está en grupo "player"
		if popup_instance == null:
			popup_instance = popup_scene.instance()
			get_tree().get_root().add_child(popup_instance)
			popup_instance.popup_centered()  # Si es un Popup o WindowDialog
