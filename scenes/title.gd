extends Node2D


func _ready():
    # Set the default gravity direction to `Vector2(0, 0)`.
    PhysicsServer2D.area_set_param(get_viewport().find_world_2d().space, PhysicsServer2D.AREA_PARAM_GRAVITY_VECTOR, Vector2(0.0, 0.0))
    await get_tree().create_timer(0.1).timeout
    $Fade/AnimationPlayer.play("fade_title")


func _input(event):
    if event.is_action("ui_accept") or event.is_action("ui_select"):
        $Fade/AnimationPlayer.play_backwards("fade_title")
        await get_tree().create_timer(3.0).timeout
        get_tree().change_scene_to_file("res://scenes/main_scene.tscn")
