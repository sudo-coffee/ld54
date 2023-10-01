extends Node2D

var rng = RandomNumberGenerator.new()


func shake():
    $ShakeTimer.start()


func _physics_process(delta):
    if not $ShakeTimer.is_stopped():
        $Elevator.position = Vector2(rng.randf_range(22.0, 28.0), rng.randf_range(22.0, 28.0))
        $Characters.position = Vector2(rng.randf_range(-1.0, 1.0), rng.randf_range(-1.0, 1.0))


func _on_shake_timer_timeout():
    $Elevator.position = Vector2(25.0, 25.0)
    $Characters.position = Vector2(0.0, 0.0)
