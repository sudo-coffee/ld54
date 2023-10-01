extends Control

var character: Node2D


func add_message(text: String, source_character: Node2D):
    character = source_character
    var scene = load("res://scenes/message.tscn")
    var message = scene.instantiate()
    var stylebox = message.get_theme_stylebox("normal").duplicate()
    stylebox.border_color = character.color
    message.add_theme_stylebox_override("normal", stylebox)
    message.text = '[b][color=#' + character.color.to_html() + ']' + character.firstname + ':[/color][/b] ' + text
    $ChatContainer.add_child(message)
    $ChatContainer.move_child(message, 0)
    $".."/MessageLine/InnerLine.default_color = character.color
    $".."/MessageLine/LineFade.start()

    
func _process(delta):
    if character and $".."/MessageLine/LineFade.time_left:
        var head_position = character.get_node("Head").global_position - Vector2(275, 275)
        var vector_array = PackedVector2Array()
        vector_array.append(Vector2(280, -230))
        vector_array.append(head_position.move_toward(Vector2(280, -230), 30.0))
        $".."/MessageLine/InnerLine.points = vector_array
        $".."/MessageLine/OuterLine.points = vector_array
        $".."/MessageLine/InnerLine.default_color.a = $".."/MessageLine/LineFade.time_left / $".."/MessageLine/LineFade.wait_time
        $".."/MessageLine/OuterLine.default_color.a = $".."/MessageLine/LineFade.time_left / $".."/MessageLine/LineFade.wait_time
