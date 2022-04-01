extends Area2D

var active = false
var end = false

var windows = ["../PlanetChat", "../ProjectWindow", "../BigMail", "../Pierogi", "","../f-days", "../f-days2", "../f-days3"]
var timelines = ['computer-timeline1', 'chat', 'projects', 'big-day', 'food']
var overlays = ['../darker1', '../darker2', '../darker3']

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
	elif event.is_action_pressed("ui_accept") and active:
		if len(windows) > 0 and windows[0] != "":
			if len(overlays) > 0:
				var overlay = get_node(overlays[0])
				overlay.visible = true
				overlays.remove(0)
			var window = get_node(windows[0])
			window.visible = true
			windows.remove(0)
		else:
			if not end:
				timelines.append("anime")
				end = true
			else:
				get_node('../Bg').visible = true
		pass
		
func unpause(timeline_name):
	timelines.remove(0)
	if len(windows) > 0 and windows[0] != "":
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
