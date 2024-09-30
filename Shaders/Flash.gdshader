shader_type canvas_item;

uniform float opacity = 1.0;
uniform float r = 1.0;
uniform float g = 1.0;
uniform float b = 1.0;
uniform float mix_color = 0.0;

uniform vec4 flash_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float flash_modifier : hint_range(0.0, 1.0, 0.1) = 0.0;

void fragment() {
    vec4 texture_color = texture(TEXTURE, UV);
    vec3 mixed_color = mix(texture_color.rgb, vec3(r, g, b), mix_color);
    mixed_color = mix(mixed_color, flash_color.rgb, flash_modifier);
    COLOR = vec4(mixed_color, texture_color.a * opacity);
}
