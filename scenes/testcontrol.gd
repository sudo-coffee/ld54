extends Node2D

func _physics_process(delta):
    var direction = Input.get_vector('ui_left', 'ui_right', 'ui_up', 'ui_down')
    $Shoulders.constant_force = direction * 10000

