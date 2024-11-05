vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords)
{
    // TODO! move out
    vec2 right = vec2(1 / love_ScreenSize.x, 0.);
    vec2 down = vec2(0., 1 / love_ScreenSize.y);
    vec2 left = -right;
    vec2 up = -down;

    vec4 pixel = Texel(tex, texture_coords);
    
    vec4 up_pixel = Texel(tex, texture_coords + up);
    vec4 left_pixel = Texel(tex, texture_coords + left);
    vec4 right_pixel = Texel(tex, texture_coords + right);
    vec4 down_pixel = Texel(tex, texture_coords + down);

    return pixel + (
        - 6 * pixel
        + up_pixel
        + left_pixel 
        + right_pixel
        + 3 * down_pixel
    ) / 6;
}
