shader_type canvas_item;

uniform float saturation: hint_range(1.0, 5.0, 0.1);
uniform float brightness: hint_range(0.0, 1.0, 0.1);
mat4 saturationMatrix(float s) {
	vec3 luminance = vec3(0.3086,0.6094,0.0820);
	float sr = (1.0 - s) * luminance.r;
	float sg = (1.0 - s) * luminance.g;
	float sb = (1.0 - s) * luminance.b;
	return mat4 (
		vec4(sr+s, sr, sr, 0.0),
		vec4(sg, sg+s, sg, 0.0),
		vec4(sb, sb, sb+s, 0.0),
		vec4(0.0,0.0,0.0,1.0)
	);
}
mat4 brightnessMatrix(float b){
	return mat4 (
		vec4 (1.0,0.0,0.0,0.0),
		vec4 (0.0,1.0,0.0,0.0),
		vec4 (0.0,0.0,1.0,0.0),
		vec4 (b,b,b, 1.0)
	);
}


void fragment() {
	mat4 SaturationMatrix = saturationMatrix(saturation);
	mat4 BrightnessMatrix = brightnessMatrix(brightness);
	mat4 Matrix = SaturationMatrix * BrightnessMatrix;
	vec4 color = texture(TEXTURE, UV);
	COLOR =  Matrix * color;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
