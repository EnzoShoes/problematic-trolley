shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	float addrgb = COLOR.r + COLOR.g + COLOR.b;
	COLOR.rgb = vec3((addrgb/3.0));
	 
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
