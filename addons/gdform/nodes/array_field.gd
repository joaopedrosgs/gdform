extends VBoxContainer

onready var label: Label = $Label
onready var description: Label = $Description
onready var fields: VBoxContainer = $Fields

export(String) var label_text = "" setget set_label_text, get_label_text
export(String) var description_text = "" setget set_description_text, get_description_text
export(Array) var value setget set_value, get_value

signal data_changed(label, button_pressed)

var property setget set_property, get_property


func set_property(new_property):
	property = new_property
	label_text = property.name
	description_text = property.description
	# TODO: Need to read default values in the array and instance them

func get_property() -> float:
	return value


func set_value(new_value: Array):
	# TODO: decide how to instantiate them, should we use only this function to do this?
	value = new_value


func get_value() -> Array:
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


# Called when the node enters the scene tree for the first time.
func _ready():
	pass  # Replace
