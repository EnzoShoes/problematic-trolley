shader_type canvas_item;

uniform vec3 new_color:source_color;
uniform vec3 old_color:source_color;

void fragment() {
	// Replaces one color with an other
	if (COLOR.rgb == old_color)
	{
		COLOR.rgb = new_color;	
	}
}