shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform float Stripe_Size : hint_range(0.0, 10.0, 0.1);
uniform float Displacement : hint_range(-0.5, 0.5, 0.05);
//uniform float Aberation_Intensity : hint_range(0.0, 1.0, 0.1);
uniform vec4 Aberation_Color1 : source_color;
uniform vec4 Aberation_Color2 : source_color;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 transparant = vec4(0.0,0.0,0.0,0.0);
	// These are the variables used later
	vec4 displaced_image_right = texture(TEXTURE, (UV-vec2(Displacement,0.0)));
	vec4 displaced_image_left = texture(TEXTURE, (UV-vec2(-Displacement,0.0)));
	
	// now into the chromatic aberation (now exported)
	//vec4 blue = vec4 (0.0,0.0,Aberation_Intensity,1.0);
	//vec4 red = vec4 (Aberation_Intensity,0.0,0.0,1.0);
	
	// Isolate stripes of texture. The argument of the condition is the expression that defines that
	// the stripes are going to be affected. When the conditions are met, the next line displaces those
	// fragments. 
	if (int(UV.y*Stripe_Size)%2 == 0) {
		COLOR = displaced_image_right + Aberation_Color1;
	}
	else {
		COLOR = displaced_image_left + Aberation_Color2;
	}
	
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
