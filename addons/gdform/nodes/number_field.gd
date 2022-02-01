extends VBoxContainer

onready var label: Label = $Label
onready var description: Label = $Description
onready var spin_box: SpinBox = $SpinBox

export(String) var label_text = "" setget set_label_text, get_label_text
export(String) var description_text = "" setget set_description_text, get_description_text
export(float) var value = 0.0 setget set_value, get_value
signal data_changed(label, new_number)
var property setget set_property, get_property


func set_property(new_property):
	property = new_property
	label_text = property.name
	description_text = property.description


func get_property() -> float:
	return value


func set_value(new_value: float):
	value = new_value
	if not spin_box:
		yield(self, "ready")
	spin_box.value = value


func get_value() -> float:
	return value


func set_label_text(text: String):
	label_text = text
	if not label:
		yield(self, "ready")
	label.text = label_text.capitalize()


func get_label_text() -> String:
	return label_text


func get_description_text() -> String:
	return description_text


func set_description_text(text: String):
	description_text = text
	if not description:
		yield(self, "ready")
	description.text = description_text


func _ready():
	var step = 1 if property.type == "integer" else 0.01
	if property.has("multipleOf"):
		step = property.multipleOf
		
	var maximum = property.maximum if property.has("maximum") else 999999999
	if property.has("exclusiveMaximum"):
		maximum = property.exclusiveMaximum-1
		
	var minimum = property.minimum if property.has("minimum") else -999999999
	if property.has("exclusiveMinimum"):
		minimum = property.exclusiveMinimum+1
		
	
	spin_box.step = step
	spin_box.min_value = minimum
	spin_box.max_value = maximum

func _on_SpinBox_value_changed(value):
	emit_signal("data_changed", label_text, value)
