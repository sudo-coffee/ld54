extends Node

signal pressedDirection
signal pressedAccept
var fighting_started = false
var playerInRangeOfButtons = false
var textspeed: float = 1.0
var rng = RandomNumberGenerator.new()
var random_messages = [
    "Sandwiches!",
    "Cheesecake!",
    "( ╯°□°)╯ ┻━━┻",
    "Aaah!",
    "Come back and fight like a human!",
    "Ha ha ha ha ha ha ha ha ha ha ha ha ha ha ha ha ha.",
    "You know what you've done?",
    "Sandwich, any sandwich?",
    "Lonely.",
    "We'll rip your bones off!",
    "Please... A sandwich...",
    "I'm drooling.",
    "Cheescake?",
    "Where's your money now, kid!",
    "What was is it I was looking for?",
    "Could- Could- I- Just a bone?",
    "♫ Count your bones tomorrow ♫",
    "ψ( ` ∇ ´ )ψ",
    "＼o／",
]
var random_screams = [
    "Eeeeeekk!!!",
    "Noooo cheesecake!",
    "(ノωヽ)",
    "My sandwhiches :(",
    "Aaaaaahhhh!!!",
    "Bwa ha ha ha ha ha ha ha ha ha.",
    "Terrible?",
    "Noooooooooo.",
    "Afraid.",
    "Eeeeaaaaahhhh.",
    "Wooooaaaahhhh.",
    "Bye bye.",
    "Where did the cheesecake go?",
    "〜(＞＜)〜",
    "＼(〇_ｏ)／",
    "＼(º □ º l|l)/",
]

func wait(time, exact=false):
    if exact:
        await get_tree().create_timer(time).timeout
    else:
        await get_tree().create_timer(time / textspeed).timeout

func _input(event):
    if event.is_action_pressed("ui_up"):
        pressedDirection.emit()
    elif event.is_action_pressed("ui_down"):
        pressedDirection.emit()
    elif event.is_action_pressed("ui_left"):
        pressedDirection.emit()
    elif event.is_action_pressed("ui_right"):
        pressedDirection.emit()
    elif event.is_action_pressed("ui_accept"):
        pressedAccept.emit()
    elif event.is_action_pressed("ui_select"):
        pressedAccept.emit()


func start_chapter():
    
    # Some variables.
    var player = $".."/".."/Characters/Player
    var char0 = $".."/".."/Characters/NPCs.get_child(0)
    var char1 = $".."/".."/Characters/NPCs.get_child(5)
    var char2 = $".."/".."/Characters/NPCs.get_child(10)
    var char3 = $".."/".."/Characters/NPCs.get_child(15)
    var char4 = $".."/".."/Characters/NPCs.get_child(20)
    var char5 = $".."/".."/Characters/NPCs.get_child(25)
    var char6 = $".."/".."/Characters/NPCs.get_child(12)
    var char7 = $".."/".."/Characters/NPCs.get_child(17)
    var char8 = $".."/".."/Characters/NPCs.get_child(22)
    var char9 = $".."/".."/Characters/NPCs.get_child(27)
    var gallery = [
        $".."/".."/Characters/NPCs.get_child(1),
        $".."/".."/Characters/NPCs.get_child(2),
        $".."/".."/Characters/NPCs.get_child(3),
        $".."/".."/Characters/NPCs.get_child(4),
        $".."/".."/Characters/NPCs.get_child(6),
        $".."/".."/Characters/NPCs.get_child(7),
        $".."/".."/Characters/NPCs.get_child(8),
        $".."/".."/Characters/NPCs.get_child(9),
        $".."/".."/Characters/NPCs.get_child(11),
        $".."/".."/Characters/NPCs.get_child(13),
        $".."/".."/Characters/NPCs.get_child(14),
        $".."/".."/Characters/NPCs.get_child(16),
        $".."/".."/Characters/NPCs.get_child(18),
        $".."/".."/Characters/NPCs.get_child(19),
        $".."/".."/Characters/NPCs.get_child(21),
        $".."/".."/Characters/NPCs.get_child(23),
        $".."/".."/Characters/NPCs.get_child(24),
        $".."/".."/Characters/NPCs.get_child(26),
        $".."/".."/Characters/NPCs.get_child(28),
        $".."/".."/Characters/NPCs.get_child(29),
    ]
    var chat = $".."/".."/Chat
    $".."/".."/Fade/AnimationPlayer.play("fade")
    player.get_node("Shoulders").constant_force = Vector2(0.0, -600000.0)
    await wait(5.0, true); $".."/".."/Elevator.toggle_doors()
    await wait(4.5, true); chat.add_notice("[i]Use the arrow keys to move.[/i]")
    $".."/".."/Characters.player_active = true

    var keys_to_press = ['ui_left', 'ui_right', 'ui_up', 'ui_down']
    while keys_to_press:
        await pressedDirection
        if Input.is_action_pressed("ui_left"):
            keys_to_press.erase("ui_left")
        if Input.is_action_pressed("ui_right"):
            keys_to_press.erase("ui_right")
        if Input.is_action_pressed("ui_up"):
            keys_to_press.erase("ui_up")
        if Input.is_action_pressed("ui_down"):
            keys_to_press.erase("ui_down")

    await wait(8.0); chat.add_message(char4, "Just the one of you this time?")
    await wait(3.0); chat.player_message("Hmm?")
    await pressedAccept
    await wait(1.0); chat.add_message(player, "...")
    await wait(1.0); chat.add_message(player, "What is this?")
    await wait(3.0); chat.add_message(char4, "Not a fan of that attitude.")
    await wait(3.0); chat.add_message(char4, "But...")
    await wait(1.0); chat.add_message(char4, "I want to see you [i]try[/i] and reach those elevator buttons.")
    await wait(5.0); chat.add_message(char2, "Wait- are we ready?")
    await wait(1.0); chat.add_message(char3, "What??")
    await wait(1.0); chat.add_message(char1, "[i][b]Attack!!!")
    await wait(2.0);
    for npc in $".."/".."/Characters/NPCs.get_children():
        npc.moving = true
    while not playerInRangeOfButtons:
        fighting_started = true
        chat.add_message(
            gallery[rng.randi() % gallery.size()],
            random_messages[rng.randi() % random_messages.size()]
        )
        await get_tree().create_timer(rng.randf() * 1.5 + 0.5).timeout
    for npc in $".."/".."/Characters/NPCs.get_children():
        npc.moving = false
        npc.get_node("Shoulders").constant_force = Vector2(0.0, 0.0)
    chat.add_message(char4, "No! Don't press the button!!")
    await wait(3.0); chat.add_notice("[i]Press the button?[/i]")
    await wait(1.0); chat.player_message("Aaaaeeeggghhkkk!")
    await pressedAccept
    $".."/".."/Elevator.toggle_doors()
    # Set the default gravity direction to `Vector2(0, 1)`.
    PhysicsServer2D.area_set_param(get_viewport().find_world_2d().space, PhysicsServer2D.AREA_PARAM_GRAVITY_VECTOR, Vector2.DOWN)
    await wait(2.0)
    while true:
        chat.add_message(
            gallery[rng.randi() % gallery.size()],
            random_screams[rng.randi() % random_screams.size()]
        )
        await get_tree().create_timer(rng.randf() * 0.3 + 0.2).timeout
    

    
    


func _on_button_area_body_entered(body):
    if body == $".."/".."/Characters/Player/Shoulders:
        if fighting_started:
            playerInRangeOfButtons = true
