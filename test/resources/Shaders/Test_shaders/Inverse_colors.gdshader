shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 colors = texture(TEXTURE, UV);
	vec4 inversed_colors = vec4(1.0 - colors.rgb, colors.a) ;
	COLOR = inversed_colors;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
