extends Node2D

var open: bool = false # Target door state.
var speed: float = 0.0 # How fast the door is currently closing.


func _on_test_door_timer_timeout():
    toggle_doors()
    $".."/Chat.add_message("HI THERE!!! Some more text.", $".."/Characters/Player)


func toggle_doors():
    if open:
        # Close doors.
        open = false
        $".."/ShakeTimer.start()
        $DoorLeft.visible = true
        $DoorRight.visible = true
        $CloseDoors.start()
    else:
        # Open doors.
        open = true
        $".."/ShakeTimer.start()
        $DoorLeft.position.y = 477.0
        $DoorRight.position.y = 477.0
        $OpenDoors.start()


func _physics_process(delta):
    if speed != 0:
        $DoorLeft.position.x += delta * speed
        $DoorRight.position.x -= delta * speed

    if speed > 0 and $DoorLeft.position.x >= 123.0:
        speed = 0
        $DoorLeft.position.x = 125.0
        $DoorRight.position.x = 250.0
        $LockDoors.start()
        $".."/ShakeTimer.start()
    elif speed < 0 and $DoorLeft.position.x <= 2.0:
        speed = 0
        $DoorLeft.position.x = 0.0
        $DoorRight.position.x = 375.0
        $DoorLeft.visible = false
        $DoorRight.visible = false
        $".."/ShakeTimer.start()


func _on_lock_doors_timeout():
    $DoorLeft.position.y = 475.0
    $DoorRight.position.y = 475.0


func _on_open_doors_timeout():
    speed = -40.0


func _on_close_doors_timeout():
    speed = 40.0
