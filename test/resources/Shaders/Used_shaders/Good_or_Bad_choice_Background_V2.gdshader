shader_type canvas_item;

uniform float margin: hint_range(0.0, 3.0, 0.01);
uniform float colorintensity: hint_range(0.0, 1.0, 0.01);
uniform bool Good_Choice;
uniform bool Frenzy;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {

	
	float colorintensity_tapered = (abs(UV.x/margin - 0.5/margin) + abs(UV.y/margin - 0.5/margin)) * colorintensity;

	vec4 reversed_green = vec4 (colorintensity_tapered,0.0,colorintensity_tapered,0.0);
	vec4 reversed_red = vec4 (0.0,colorintensity_tapered,colorintensity_tapered,0.0);
	
	vec2 where_there_is_color = vec2(margin);
	
	// the border of the screen : is UV.xy is 0-0.20 or 0.80-1.0

	//if (UV.x < margin || UV.x > (1.0 - margin) || UV.y > (1.0 - margin) || (UV.y < margin)) {
		if (Good_Choice || Frenzy == false)
		{
			COLOR = COLOR - reversed_green;
		}
		else if (Good_Choice == false || Frenzy == false)
		{
			COLOR = COLOR - reversed_red;
		}
	//}
}	

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
