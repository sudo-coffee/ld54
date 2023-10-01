extends Node2D

var rng = RandomNumberGenerator.new()


func _ready():
    add_random_npc()

func add_random_npc():
    var scene = load("res://scenes/character.tscn")
    var npc = scene.instantiate()
    npc.set_meta("color", Color(rng.randf(), rng.randf(), rng.randf(), 1))
    add_child(npc)
    
