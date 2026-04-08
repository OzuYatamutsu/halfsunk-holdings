shader_type canvas_item;

uniform float progress: hint_range(0.0, 1.0) = 0.5;
uniform vec2 center = vec2(0.5);
const float radius = 1.0;

void fragment() {
    float aspect_ratio = -1.0;
    vec2 ar_uv = vec2(aspect_ratio * UV.x, UV.y);
    vec2 ar_center = vec2(aspect_ratio * center.x, center.y);
    vec2 mask = ar_uv - ar_center;

    float dist = length(mask);

    COLOR = texture(TEXTURE, UV);
    COLOR.a *= 1.0 - step((1.0 - progress) * radius, dist);
}