extends Node2D



func _physics_process(delta):
    # Player movement.
    var direction = Input.get_vector('ui_left', 'ui_right', 'ui_up', 'ui_down')
    $Player/Shoulders.constant_force = Vector2(0.0, direction.y).rotated($Player/Shoulders.rotation) * 50000.0
    $Player/Shoulders.constant_torque = direction.x * 2400000.0
