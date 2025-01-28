shader_type canvas_item;
uniform float darken = 3;
void fragment() {
	float addrgb = COLOR.r + COLOR.g + COLOR.b -darken;
	COLOR.rgb = vec3((addrgb/3.0));
}
