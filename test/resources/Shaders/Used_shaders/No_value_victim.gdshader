shader_type canvas_item;
uniform float darken: hint_range(0.0, 2.0, 0.1);
void fragment() {
	float addrgb = COLOR.r + COLOR.g + COLOR.b -darken;
	COLOR.rgb = vec3((addrgb/3.0)); 
}
