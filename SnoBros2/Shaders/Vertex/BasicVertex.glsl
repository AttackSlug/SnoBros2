attribute vec2 position;

uniform   mat4 modelViewProjection;

attribute vec2 inputTexCoord;
varying   vec2 outputTexCoord;

attribute vec4 inputColor;
varying   vec4 outputColor;

void main(void) {
  outputColor = inputColor;
  gl_Position = modelViewProjection * vec4(position, 0, 1);
  outputTexCoord = inputTexCoord;
}