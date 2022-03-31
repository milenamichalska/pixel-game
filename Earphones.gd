extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var active = false
onready var player = get_node("../Player/PlayerSprite")

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", self, '_hp_on_body_entered')
	connect("body_exited", self, '_hp_on_body_exited')
	
func _process(delta):
	$QMark.visible = (active && $Sprite.visible)
	
func _input(event):
	if event.is_action_pressed("ui_accept") and active:
		if get_node_or_null('DialogNode') == null:
			get_tree().paused = true
			var dialog = Dialogic.start('timeline1')
			dialog.pause_mode = Node.PAUSE_MODE_PROCESS
			dialog.connect('timeline_end', self, 'unpause')
			add_child(dialog)
		$Sprite.visible = false
		player.set_texture(load("res://player/PlayerEars.png"))
		
func unpause(timeline_name):
	get_tree().paused = false
	
func _hp_on_body_entered(body):
	if body.name == 'Player':
		active = true

func _hp_on_body_exited(body):
	if body.name == 'Player':
		active = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
