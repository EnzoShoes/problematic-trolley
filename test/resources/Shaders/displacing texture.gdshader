shader_type canvas_item;
uniform float margin = 2.0;
void vertex() {
	// Giving more Vertex space to work with. 
	// It will grow the texture, so i'll have to scale the texture down
	vec2 vertex_scale = (vec2(margin) * VERTEX);
	
	// a vector that contains the dimention of the texture
	vec2 pixel_texture = vec2(1)/TEXTURE_PIXEL_SIZE;
	// half it so that it centers the picture
	vec2 half_of_pixtel_texture = pixel_texture/vec2(2);
	// reposition it to match the later UV scaling. 
	vec2 vertex_reposition = vec2(margin-1.0) * half_of_pixtel_texture;
	vec2 end_vertex = vertex_scale + vertex_reposition;
	VERTEX = end_vertex;
}

void fragment() {
	// Variables for displacing the texture
	vec2 direction = vec2 (0, 0);
	vec2 displacement = UV + direction;
	
	//SCaling the texture back to it's original size
	vec2 scale_vector = vec2(margin);
	vec2 scaled = UV * scale_vector;
	//Output
	COLOR = texture(TEXTURE, scaled);
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
