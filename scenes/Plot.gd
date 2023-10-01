extends Node


func _ready():
    await get_tree().create_timer(3).timeout
    start_game()

    
func start_game():
    $Chapter1.start_chapter()


