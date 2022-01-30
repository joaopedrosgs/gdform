extends VBoxContainer

var property_dictionary: Dictionary

export(String, FILE, "*.json") var json_schema setget set_json_schema, get_json_schema
export(Dictionary) var data setget set_data, get_data
export(bool) var show_send_button = false setget set_show_send_button, get_show_send_button
var final_data: Dictionary
signal submitted(data)


func set_show_send_button(value: bool):
	show_send_button = value
	if show_send_button:
		var button = Button.new()
		add_child(button)
		button.text = "Submit"
		button.connect("pressed", self, "_on_submit_button_pressed")


func get_show_send_button() -> bool:
	return show_send_button


func set_data(value: Dictionary):
	data = value
	final_data = data
	if data != null:
		fill_data(property_dictionary, data)


func get_data() -> Dictionary:
	return data


func set_json_schema(file: String):
	json_schema = file
	var jsonfile = File.new()
	jsonfile.open(json_schema, File.READ)
	var data = parse_json(jsonfile.get_as_text())
	property_dictionary = parse_properties(data)
	instantiate_properties(property_dictionary)
	pass


func get_json_schema() -> String:
	return json_schema


func instantiate_properties(properties: Dictionary):
	for key in properties:
		var property = properties[key]
		var node_instance = property.node.instance()
		self.add_child(node_instance)
		node_instance.set_owner(self)
		node_instance.set_custom_minimum_size(Vector2(50, 24))
		node_instance.label_text = key
		node_instance.description_text = property.description
		node_instance.connect("data_changed", self, "_on_field_data_changed")
		properties[key].instance = node_instance


func parse_properties(data) -> Dictionary:
	var dictionary: Dictionary
	for key in data.properties:
		var property = data.properties[key]
		var node_class = NodeMapping.type_to_field(property.type)
		dictionary[key] = {
			"type": property.type, "node": node_class, "description": property.description
		}
	return dictionary


func fill_data(properties: Dictionary, data: Dictionary):
	for key in properties:
		if not data.has(key):
			continue
		var property = properties[key]
		property.instance.set_value(data[key])


func _on_submit_button_pressed():
	emit_signal("submitted", final_data)


func _on_field_data_changed(field, data):
	final_data[field] = data
