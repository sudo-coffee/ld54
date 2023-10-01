extends Sprite2D


func _process(delta):
    global_position = ($".."/Shoulders.global_position - Vector2(275.0, 275.0)) * 1.1 + Vector2(275.0, 275.0)
    global_rotation = $".."/Shoulders.global_rotation
