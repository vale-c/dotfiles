// Subtle CRT shader — scanlines + slight curvature, preserves terminal theme colors
// Based on: https://www.shadertoy.com/view/WsVSzV (CC BY NC SA 3.0)

float warp = 0.15; // subtle CRT curvature (lower = less distortion)
float scan = 0.35; // scanline darkness (lower = more subtle)

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec2 uv = fragCoord / iResolution.xy;
    vec2 dc = abs(0.5 - uv);
    dc *= dc;

    // apply subtle barrel distortion
    uv.x -= 0.5; uv.x *= 1.0 + (dc.y * (0.3 * warp)); uv.x += 0.5;
    uv.y -= 0.5; uv.y *= 1.0 + (dc.x * (0.4 * warp)); uv.y += 0.5;

    // black outside the warped boundaries
    if (uv.y > 1.0 || uv.x < 0.0 || uv.x > 1.0 || uv.y < 0.0)
    {
        fragColor = vec4(0.0, 0.0, 0.0, 1.0);
    }
    else
    {
        // scanline effect — darken alternating lines slightly
        float apply = abs(sin(fragCoord.y) * 0.5 * scan);

        // sample the terminal texture — no color tint, preserves theme
        vec3 color = texture(iChannel0, uv).rgb;
        fragColor = vec4(color * (1.0 - apply), 1.0);
    }
}
