extends Node2D

var player_active: bool = false
var fading_out: bool = false


func _ready():
    $Player.firstname = "You"
    $Player.is_player = true
    $Player/Shoulders.mass = 1200


func _process(delta):
    if $Player/Shoulders.global_position.y > 800 and not fading_out:
        fading_out = true
        $".."/Fade/AnimationPlayer.play_backwards("fade")
        await get_tree().create_timer(8.0).timeout
        get_tree().change_scene_to_file("res://scenes/title.tscn")


func _physics_process(delta):
    if player_active:
        # Player movement.
        var direction = Input.get_vector('ui_left', 'ui_right', 'ui_up', 'ui_down')
        $Player/Shoulders.constant_force = Vector2(0.0, direction.y).rotated($Player/Shoulders.rotation) * 1000000.0
        $Player/Shoulders.constant_torque = direction.x * 48000000.0
