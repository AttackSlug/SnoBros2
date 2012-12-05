attribute vec2 position;
attribute vec4 inputColor;

uniform   mat4 modelViewProjection;

varying   vec4 outputColor;

void main(void) {
  outputColor = inputColor;
  gl_Position = modelViewProjection * position;
}