shader_type canvas_item;
render_mode blend_mix;

uniform vec4 bg_color : source_color;
uniform vec4 fg_color : source_color;
uniform vec4 border_color : source_color;
uniform float texture_size;
uniform vec2 direction;
uniform float speed;
uniform sampler2D scroll_texture : filter_nearest, repeat_enable;

bool colors_match(vec3 a, vec3 b) {
	return distance(a,b)<1.0 ;
}

void fragment() {

	vec2 uv = SCREEN_UV / SCREEN_PIXEL_SIZE;


	//return;
	uv -= (direction * TIME * speed);
	//COLOR.rg = uv/100.0;

	//if (false) {

	vec4 v = texture(scroll_texture, uv/texture_size);

	vec4 color = mix(bg_color, fg_color, v.r);

	if (colors_match(COLOR.rgb,vec3(1,0,0))) {
		COLOR.rgb = color.rgb;
	} else if (colors_match(COLOR.rgb,vec3(0,1,0))) {
		COLOR = border_color;
	} else if (colors_match(COLOR.rgb,vec3(0,0,1))) {
		COLOR.rgb *= 0.0;
	} else {
		COLOR = vec4(0,1,0,1);
	}
//}
}
