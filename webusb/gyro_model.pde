// Reemplazo del cubo por un avión con WebSerial y giroscopio integrando
// Este sketch está pensado para integrarse con el Web Serial (via JS)
// usando updateGyro(x, y, z) desde la página web

float gx = 0, gy = 0, gz = 0;
float angleX = 0, angleY = 0, angleZ = 0;
float lastTime = 0;
float offsetX = 0, offsetY = 0, offsetZ = 0;
boolean calibrated = false;

void setup() {
  size(800, 600, P3D);
  noStroke();
  lastTime = millis();
}

void draw() {
  background(10);
  lights();
  ambientLight(60, 60, 60);
  directionalLight(255, 255, 255, -0.5, 0.5, -1);

  float now = millis();
  float dt = (now - lastTime) / 1000.0;
  lastTime = now;

  float deadZone = radians(0.5);
  float dx = abs(gx) < deadZone ? 0 : gx;
  float dy = abs(gy) < deadZone ? 0 : gy;
  float dz = abs(gz) < deadZone ? 0 : gz;

  angleX += dx * dt;
  angleY += dy * dt;
  angleZ += dz * dt;

  translate(width / 2, height / 2, -200);
  rotateX(angleX);
  rotateY(angleY);
  rotateZ(angleZ);

  drawAvion();
}

void updateGyro(float x, float y, float z) {
  if (!calibrated) {
    offsetX = x;
    offsetY = y;
    offsetZ = z;
    calibrated = true;
  }

  gx = x - offsetX;
  gy = y - offsetY;
  gz = z - offsetZ;
}

void drawAvion() {
  pushMatrix();
  noStroke();

  // Fuselaje (naranja)
  fill(173, 79, 0);
  pushMatrix();
  translate(0, 0, -30);
  box(20, 20, 150);
  popMatrix();

  // Alas (blancas)
  fill(255);
  pushMatrix();
  translate(0, 0, 0);
  drawTriWing();
  popMatrix();

  // Aleta trasera
  fill(255);
  pushMatrix();
  translate(0, -15, 40);
  box(5, 25, 3);
  popMatrix();

  popMatrix();
}

void drawTriWing() {
  beginShape();
  vertex(0, 0, 0);
  vertex(-80, 0, -50);
  vertex(0, 0, -90);
  vertex(80, 0, -50);
  endShape(CLOSE);
}