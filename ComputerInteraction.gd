extends Area2D

var active = false

var windows = ["../PlanetChat", "", ""]
var timelines = ['computer-timeline1', 'chat', 'projects', 'big-day', 'food']

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", self, '_computer_on_body_entered')
	connect("body_exited", self, '_computer_on_body_exited')
	
func _process(delta):
	$QMark.visible = active
	
func _input(event):
	if event.is_action_pressed("ui_accept") and active and len(timelines) > 0:
		# if get_node_or_null('DialogNode') == null:
		get_tree().paused = true
		var dialog = Dialogic.start(timelines[0])
		dialog.pause_mode = Node.PAUSE_MODE_PROCESS
		dialog.connect('timeline_end', self, 'unpause')
		add_child(dialog)
		pass
		
func unpause(timeline_name):
	timelines.remove(0)
	if windows[0] != "":
		var window = get_node(windows[0])
		window.visible = true
	windows.remove(0)
	get_tree().paused = false
		
	
func _computer_on_body_entered(body):
	if body.name == 'Player':
		active = true

func _computer_on_body_exited(body):
	if body.name == 'Player':
		active = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
