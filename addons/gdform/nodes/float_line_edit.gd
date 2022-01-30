extends LineEdit
class_name FloatLineEdit

var regex = RegEx.new()
var oldtext = ""

signal number_changed(new_number)


func _ready():
	connect("text_changed", self, "_on_text_changed")
	regex.compile("^[0-9\\.]*$")


func _on_text_changed(new_text):
	if regex.search(new_text):
		oldtext = new_text
	else:
		text = oldtext
	set_cursor_position(text.length())
	emit_signal("number_changed", get_value())


func get_value() -> float:
	return float(text)
