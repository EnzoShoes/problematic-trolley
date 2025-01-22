shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform float Stripe_Size : hint_range(0.0, 10.0, 0.1);
uniform float Displacement : hint_range(-0.5, 0.5, 0.1);

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 transparant = vec4(0.0,0.0,0.0,0.0);
	// Isolate stripes of texture. The argument of the condition is the expression that defines that
	// the stripes are going to be affected. When the conditions are met, the next line displaces those
	// fragments. 
	if (int(UV.y*Stripe_Size)%2 == 0) {
		COLOR = texture(TEXTURE, (UV-vec2(Displacement,0.0)));
	}
	
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
