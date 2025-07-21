@tool
extends AnimatedSprite2D

@export var palettes: Array[PackedColorArray]
@export var current_palette: int = 0:
	set(v):
		current_palette = v
		update_palette()

func _ready() -> void:
	material = material.duplicate()

func choose_random_palette():
	current_palette = randi_range(0,palettes.size()-1)

func update_palette():
	material.set_shader_parameter("output_palette_array",palettes[current_palette])

func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		if current_palette>=palettes.size() || current_palette<0:
			return
		var mat: ShaderMaterial = self.material
		if mat.get_shader_parameter("output_palette_array") != palettes[current_palette]:
			mat.set_shader_parameter("output_palette_array",palettes[current_palette])
