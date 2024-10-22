extends Area2D
@onready var timer: Timer = $Timer
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
var door_opened = false
const file_begin = "res://scenes/levels/level"
func _ready():
	$AnimatedSprite2D.stop()
	$AnimatedSprite2D.frame = 0  # Assuming frame 0 is the closed frame
func _process(delta):
	if Global.flags_collected == true and door_opened==false:
		#print("collected")
		animated_sprite.play("open")  # Play the open animation only once
		door_opened=true


func _on_body_entered(body: Node2D) -> void:
	#print("collided")
	if Global.flags_collected == true:
		timer.start()

	


func _on_timer_timeout() -> void:
	#print("timeup")
	var current_scene_file = get_tree().current_scene.scene_file_path
	var next_level_number = current_scene_file.to_int()+1
	var next_level_path = file_begin+str(next_level_number)+".tscn"
	#print(next_level_path)
	get_tree().change_scene_to_file(next_level_path)
