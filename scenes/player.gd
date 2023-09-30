extends Node2D

func _physics_process(delta):
    
    # Player movement.
    var direction = Input.get_vector('ui_left', 'ui_right', 'ui_up', 'ui_down')
    $Shoulders.constant_force = Vector2(0.0, direction.y).rotated($Shoulders.rotation) * 50000.0
    $Shoulders.constant_torque = direction.x * 1200000.0
