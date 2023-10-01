extends Control

var character: Node2D
var sticky: bool = false
signal pressedAccept

func _input(event):
    if event.is_action_pressed("ui_accept"):
        pressedAccept.emit()
    elif event.is_action_pressed("ui_select"):
        pressedAccept.emit()

func add_message(source_character: Node2D, text: String):
    character = source_character
    var scene = load("res://scenes/message.tscn")
    var message = scene.instantiate()
    var stylebox = message.get_theme_stylebox("normal").duplicate()
    stylebox.border_color = character.color
    message.add_theme_stylebox_override("normal", stylebox)
    message.text = '[b][color=#' + character.color.to_html() + ']' + character.firstname + ':[/color][/b] ' + text
    $ChatContainer.add_child(message)
    if sticky:
        $ChatContainer.move_child(message, 1)
    else:
        $ChatContainer.move_child(message, 0)
    $".."/MessageLine/InnerLine.default_color = character.color
    $".."/MessageLine/LineFade.start()


func add_notice(text: String):
    var scene = load("res://scenes/message.tscn")
    var message = scene.instantiate()
    var stylebox = message.get_theme_stylebox("normal").duplicate()
    stylebox.border_color = Color(0.75, 0.75, 0.75, 1.0)
    message.add_theme_stylebox_override("normal", stylebox)
    message.text = text
    $ChatContainer.add_child(message)
    if sticky:
        $ChatContainer.move_child(message, 1)
    else:
        $ChatContainer.move_child(message, 0)


func player_message(text: String):
    sticky = true
    var scene = load("res://scenes/message.tscn")
    var sticky_message = scene.instantiate()
    var stylebox = sticky_message.get_theme_stylebox("normal").duplicate()
    stylebox.border_color = Color(0.0, 0.0, 0.0, 0.0)
    stylebox.content_margin_bottom = 4.0
    sticky_message.add_theme_stylebox_override("normal", stylebox)
    sticky_message.text = "[i]Press space...[/i]"
    $ChatContainer.add_child(sticky_message)
    $ChatContainer.move_child(sticky_message, 0)
    await pressedAccept
    sticky = false
    $ChatContainer.remove_child(sticky_message)
    character = $".."/Characters/Player
    var message = scene.instantiate()
    stylebox = message.get_theme_stylebox("normal").duplicate()
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
        if sticky:
            vector_array.append(Vector2(280, -185))
            vector_array.append(head_position.move_toward(Vector2(280, -185), 30.0))
        else:
            vector_array.append(Vector2(280, -230))
            vector_array.append(head_position.move_toward(Vector2(280, -230), 30.0))
        $".."/MessageLine/InnerLine.points = vector_array
        $".."/MessageLine/OuterLine.points = vector_array
        $".."/MessageLine/InnerLine.default_color.a = $".."/MessageLine/LineFade.time_left / $".."/MessageLine/LineFade.wait_time
        $".."/MessageLine/OuterLine.default_color.a = $".."/MessageLine/LineFade.time_left / $".."/MessageLine/LineFade.wait_time
