varying lowp vec4 outputColor;

varying lowp vec2 outputTexCoord;
uniform sampler2D texture;

void main(void) {
  gl_FragColor = outputColor * texture2D(texture, outputTexCoord);
}