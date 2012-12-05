varying lowp vec2 outputTexCoord;
uniform sampler2D texture;

void main(void) {
  gl_FragColor = texture2D(texture, outputTexCoord);
}