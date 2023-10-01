extends Node2D

var head: Node2D



func attach_line(character: Node2D):
    $InnerLine.default_color = character.color
    head = character.get_node("Head")
    $LineFade.start()

    
func _process(delta):
    if head and $LineFade.time_left:
        var vector_array = PackedVector2Array()
        vector_array.append(Vector2(280, -230))
        vector_array.append((head.global_position - Vector2(275, 275)).move_toward(Vector2(280, -230), 30.0))
        $InnerLine.points = vector_array
        $OuterLine.points = vector_array
        $InnerLine.default_color.a = $LineFade.time_left / $LineFade.wait_time
        $OuterLine.default_color.a = $LineFade.time_left / $LineFade.wait_time
