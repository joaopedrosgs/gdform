tool
class_name NodeMapping

const TextField = preload("res://addons/gdform/nodes/TextField.tscn")
const NumberField = preload("res://addons/gdform/nodes/NumberField.tscn")
const BooleanField = preload("res://addons/gdform/nodes/BooleanField.tscn")
func _ready():
	pass # Replace with function body.


static func type_to_field(type:String):
	match type:
		"string":
			return TextField
		"number", "integer":
			return NumberField
		"boolean":
			return BooleanField
		
