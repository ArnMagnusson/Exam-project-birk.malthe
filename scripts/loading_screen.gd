extends Control

func _ready():
	ResourceLoader.load_threaded_request(Loadmanager.next_scene) #loads loadmanger request
	
func _process(delta):
	var progress = [] #array
	ResourceLoader.load_threaded_get_status(Loadmanager.next_scene, progress)
	$ProgressBar.value = progress[0]*100
	
	if progress[0] ==1:
		var packed_scene = ResourceLoader.load_threaded_get(Loadmanager.next_scene)
		get_tree().change_scene_to_packed(packed_scene)
	
