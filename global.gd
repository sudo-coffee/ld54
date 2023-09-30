extends Node

var rng = RandomNumberGenerator.new()


func shake():
    $root/ShakeTimer.start()


func _physics_process(delta):
    if not $root/ShakeTimer.is_stopped():
        $rool/Elevator.position = Vector2(rng.randf_range(22.0, 28.0), rng.randf_range(22.0, 28.0))
