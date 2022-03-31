extends Area2D

var active = false
onready var chat = get_node("../PlanetChat")

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", self, '_computer_on_body_entered')
	connect("body_exited", self, '_computer_on_body_exited')
	
func _process(delta):
	$QMark.visible = active
	
func _input(event):
	if event.is_action_pressed("ui_accept") and active:
		chat.visible = true
		pass
		
	
func _computer_on_body_entered(body):
	if body.name == 'Player':
		active = true

func _computer_on_body_exited(body):
	if body.name == 'Player':
		active = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
