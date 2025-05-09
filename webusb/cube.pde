float ax = 0, ay = 0, az = 0;
float targetAx = 0, targetAy = 0, targetAz = 0;

void setup() {
  size(640, 360, P3D);
  noStroke();
}

void draw() {
  background(0);
  lights();
  translate(width/2, height/2, -100);

  // Suavizado del movimiento
  ax = lerp(ax, targetAx, 0.1);
  ay = lerp(ay, targetAy, 0.1);
  az = lerp(az, targetAz, 0.1);

  rotateX(ax);
  rotateY(ay);
  rotateZ(az);

  drawColoredBox(150);
}

void updateAccel(float x, float y, float z) {
  // Rango muy amplio: ±120° en X/Y, ±90° en Z
  targetAx = constrain(x, radians(-120), radians(120));
  targetAy = constrain(y, radians(-120), radians(120));
  targetAz = constrain(z, radians(-90), radians(90));
}

// Dibuja un cubo con caras de distinto color
void drawColoredBox(float s) {
  float hs = s / 2;

  beginShape(QUADS);

  // Cara frontal (roja)
  fill(255, 0, 0);
  vertex(-hs, -hs,  hs);
  vertex( hs, -hs,  hs);
  vertex( hs,  hs,  hs);
  vertex(-hs,  hs,  hs);

  // Cara trasera (verde)
  fill(0, 255, 0);
  vertex( hs, -hs, -hs);
  vertex(-hs, -hs, -hs);
  vertex(-hs,  hs, -hs);
  vertex( hs,  hs, -hs);

  // Cara derecha (azul)
  fill(0, 0, 255);
  vertex( hs, -hs,  hs);
  vertex( hs, -hs, -hs);
  vertex( hs,  hs, -hs);
  vertex( hs,  hs,  hs);

  // Cara izquierda (amarillo)
  fill(255, 255, 0);
  vertex(-hs, -hs, -hs);
  vertex(-hs, -hs,  hs);
  vertex(-hs,  hs,  hs);
  vertex(-hs,  hs, -hs);

  // Cara superior (cian)
  fill(0, 255, 255);
  vertex(-hs, -hs, -hs);
  vertex( hs, -hs, -hs);
  vertex( hs, -hs,  hs);
  vertex(-hs, -hs,  hs);

  // Cara inferior (magenta)
  fill(255, 0, 255);
  vertex(-hs,  hs,  hs);
  vertex( hs,  hs,  hs);
  vertex( hs,  hs, -hs);
  vertex(-hs,  hs, -hs);

  endShape();
}
