extends Label

const FILE_PATH_SIN = "res://sin.txt"
const FILE_PATH_CON = "res://con_tilde.txt"

var palabra_sin := ""
var palabra_con := ""

func _ready():
	actualizar_pregunta()

func actualizar_pregunta():
	var pares = cargar_pares()
	
	if pares.size() > 0:
		var indice = randi() % pares.size()
		palabra_sin = pares[indice][0]
		palabra_con = pares[indice][1]
		text = "¿Dónde lleva la tilde '%s'?" % palabra_sin
	else:
		text = "No se encontraron palabras."

func cargar_pares() -> Array:
	var lista = []
	
	print("¿Existe sin.txt? ", FileAccess.file_exists(FILE_PATH_SIN))
	print("¿Existe con.txt? ", FileAccess.file_exists(FILE_PATH_CON))
	
	if not FileAccess.file_exists(FILE_PATH_SIN) or not FileAccess.file_exists(FILE_PATH_CON):
		print("Error: Alguno de los archivos no existe.")
		return []
	
	var file_sin = FileAccess.open(FILE_PATH_SIN, FileAccess.READ)
	var file_con = FileAccess.open(FILE_PATH_CON, FileAccess.READ)
	
	while not file_sin.eof_reached() and not file_con.eof_reached():
		var linea_sin = file_sin.get_line().strip_edges()
		var linea_con = file_con.get_line().strip_edges()
		
		print("SIN: [", linea_sin, "] | CON: [", linea_con, "]")
		
		if linea_sin == "" or linea_sin.begins_with("|") or linea_sin.begins_with("[source"):
			continue
		
		var sin = linea_sin.split(",")[0].strip_edges()
		var con = linea_con.split(",")[0].strip_edges()
		
		if sin != "" and con != "":
			lista.append([sin, con])
	
	print("Total pares cargados: ", lista.size())
	return lista
