tool
class_name NodeMapping

const TextField = preload("res://addons/gdform/nodes/TextField.tscn")
const FloatField = preload("res://addons/gdform/nodes/FloatField.tscn")
const BooleanField = preload("res://addons/gdform/nodes/BooleanField.tscn")
func _ready():
	pass # Replace with function body.


static func type_to_field(type:String):
	match type:
		"string":
			return TextField
		"number", "integer":
			return FloatField
		"boolean":
			return BooleanField
		
