#version 140

in vec2 v_tex_coords;

out vec3 color;

uniform ivec2 dims;
uniform isampler2D y_plane;
uniform isampler2D cb_plane;
uniform isampler2D cr_plane;
uniform vec2 y_plane_scale;
uniform vec2 cb_plane_scale;
uniform vec2 cr_plane_scale;

void main() {
  vec2 tex_coords = v_tex_coords * dims;
  ivec2 y_tex_coords = ivec2(tex_coords * y_plane_scale * y_plane_scale);
  ivec2 cb_tex_coords = ivec2(tex_coords * cb_plane_scale * cb_plane_scale);
  ivec2 cr_tex_coords = ivec2(tex_coords * cr_plane_scale * cr_plane_scale);

  float y = float(texelFetch(y_plane, y_tex_coords, 0).r) + 128;
  float cb = float(texelFetch(cb_plane, cb_tex_coords, 0).r);
  float cr = float(texelFetch(cr_plane, cr_tex_coords, 0).r);

  float r = y + 1.402 * cr;
  float g = y - 0.34414 * cb - 0.71414 * cr;
  float b = y + 1.772 * cb;

  color = vec3(r / 255, g / 255, b / 255);
}
