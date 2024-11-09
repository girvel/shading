uniform vec4 palette[46];

vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords)
{
    vec4 it = Texel(tex, texture_coords);
    float min_distance = 1;
    vec4 closest_color;
    for (int i = 0; i < 46; i++) {
        vec4 current_color = palette[i];
        float distance = (
            pow(current_color.r - it.r, 2) +
            pow(current_color.g - it.g, 2) +
            pow(current_color.b - it.b, 2)
        );

        if (distance < min_distance) {
            min_distance = distance;
            closest_color = current_color;
        }
    }
    return closest_color;
}
