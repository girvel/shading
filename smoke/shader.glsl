const int SCALE = 4;

vec2 right = vec2(SCALE / love_ScreenSize.x, 0.);
vec2 down = vec2(0., SCALE / love_ScreenSize.y);
vec2 left = -right;
vec2 up = -down;

vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords)
{
    return vec4((
        + Texel(tex, texture_coords + up)
        + Texel(tex, texture_coords + left)
        + Texel(tex, texture_coords + right)
        + 3 * Texel(tex, texture_coords + down)
    ).rgb / 6, 1.);
}
