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

	Builder = CustomStageBuilder.new()
	Loader = get_tree().get_root().get_node("CSL")

	Builder.data.stage_name = "Animated Stage"
	Builder.data.stage_icon = "res://YOMI_CustomStageTest/icon.png"

	# Animated background
	Builder.make_background("AnimatedBackground", {
		"layer": 0,
		"bg_color": Color("#171717"),
	})

	Builder.make_layer("BgLayer", Builder.get_material_id("AnimatedBackground"))

	Builder.make_element("BgAnimation", Builder.get_material_id("BgLayer"), {
		"active": true,
		"ticks_per_frame": 3,
		"frames": Builder.make_spriteframes_animation("res://YOMI_CustomStageTest/layers/background/"),
		"position": Vector2(0, -300),
	})


	Loader.add_stage(Builder.data)
