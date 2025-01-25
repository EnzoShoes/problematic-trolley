shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// setting green color
	vec4 green = vec4 (0.0,1.0,0.0,1.0);
	vec4 red = vec4 (1.0,0.0,0.0,1.0);
		
	vec4 Bad_choice = COLOR + green;
	COLOR = Bad_choice;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
