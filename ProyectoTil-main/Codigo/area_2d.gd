extends Area2D

# Usar file para que el Inspector te permita elegir el archivo visualmente
@export_file("*.tscn") var next_scene_path: String

func _ready():
	# En Godot 4, es preferible usar la sintaxis de señales directa
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D):
	# Es mejor verificar por Clase o Grupo que por Nombre
	if body is CharacterBody2D: 
		change_level()

func change_level():
	if next_scene_path == "":
		push_warning("No se ha definido una ruta para la siguiente escena.")
		return
		
	# Verificamos si el archivo existe antes de intentar cambiar
	if ResourceLoader.exists(next_scene_path):
		get_tree().change_scene_to_file(next_scene_path)
	else:
		push_error("La ruta de la escena no es válida: %s" % next_scene_path)
