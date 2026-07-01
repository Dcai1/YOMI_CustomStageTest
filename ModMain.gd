extends Node

# Loads the CustomStageBuilder class, for use in metadata building
onready var CustomStageBuilder = load("res://custom_stage_loader/CustomStageBuilder.gd")

var Builder
var Loader

# _init() is called when the mod is loaded
func _init(modLoader = ModLoader):
	pass

func _ready():
	# We call the build_stage() function after the game's process queue clears up
	# This is to ensure no errors occur.
	call_deferred("build_stage")

# Here is where the stage building takes place.
func build_stage():
	
	Builder = CustomStageBuilder.new() # For building the stage metadata
	Loader = get_tree().get_root().get_node("CSL"); # For loading the stage itself

	Builder.data.stage_name = "My First Stage"; # Setting the name of the stage
	Builder.data.stage_icon = "res://MyFirstStage/icon.png"; # Setting the icon of the stage

	# Ground
	Builder.make_background("GroundBackground", { # Creating a background to hold our ground layers
		"layer": 1, # setting it's index to 1, so it renders on front of the SkyBackground.
	});

	Builder.make_layer("GroundLayer", Builder.get_material_id("GroundBackground")); # Creating the ground layer, making it a child of GroundBackground

	Builder.make_element("Ground", Builder.get_material_id("GroundLayer"), { # Creating the ground element and changing it's data 
		"frames": Builder.make_spriteframes_image("res://MyFirstStage/layers/ground.png"),
		"position": Vector2(0, 75),
		"h_tile": true,
	});

	## Clouds
	Builder.make_background("SkyBackground", { # Creating a background to hold our ground layers, 
		"layer": 0, # setting it's index to 0, so it renders on front of the SkyBackground.
		"bg_color": Color("#B0CBFF")
	});

	Builder.make_layer("CloudsLayer", Builder.get_material_id("SkyBackground"), {# Creating the clouds layer, making it a child of MainBackground
		"motion_scale": Vector2(0.8, 0.8),
	});

	Builder.make_element("Clouds", Builder.get_material_id("CloudsLayer"), { # Creating the cloud element and changing it's data 
		"active": true,
		"ticks_per_frame": 10,
		"frames": Builder.make_spriteframes_animation("res://MyFirstStage/layers/clouds/"),
		"position": Vector2(0, -150),
		"h_tile": true,
	});

	Loader.add_stage(Builder.data);
