extends Node2D

var rng = RandomNumberGenerator.new()


func _ready():
    add_random_npcs(30)


func add_random_npcs(count):
    for n in count:
        var scene = load("res://scenes/character.tscn")
        var npc = scene.instantiate()
        npc.rotation = rng.randf() * deg_to_rad(360.0)
        npc.position.y = -150.0
        npc.position.x = [-100.0, 100.0][rng.randi() % 2]
        add_child(npc)
        await get_tree().create_timer(0.04).timeout
    
