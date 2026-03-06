float x = 100, y = 100;
float xs = 4, ys = 3;
float r = 20;

float d = -15;
float dx=20, dy=20;
float speed = 4;
boolean trails = false;

float px = 350, py = 175;
float step = 6;
float pr = 20;

float hx, hy;      // helper position
float ease = 0.10; // easing factor (0.0 to 1.0)

int state = 0; // 0=start, 1=play, 2=end
int startTime;
int duration = 20; // seconds

float score=0;

void setup() {
  size(700, 350);
  hx = px; // start helper at player position
  hy = py;
}

void draw() {
  background(270);
  // START screen
  if (state == 0) {
    textAlign(CENTER, CENTER);
    textSize(24);
    fill(0);
    text("Press ENTER to Start", width/2, height/2);
  }
    
    if (state == 1) {
    int elapsed = (millis() - startTime) / 1000; // convert ms to seconds
    int left = duration - elapsed;

    textAlign(LEFT, TOP);
    textSize(18);
    fill(0);
    text("Time Left: " + left, 20, 20);

    if (left <= 0) {
      state = 2; // go to END screen
    }
  }
  
  // END screen
  if (state == 2) {
    textAlign(CENTER, CENTER);
    textSize(24);
    fill(0);
    text("Time Over! Press R to Reset", width/2, height/2);
  }

    
  float b = dist(x,y,dx,dy);
  if (b < (x + dx)) {
    score++;
  }
  fill(0);
  text("Score: " + score, 10, 20);
  if (!trails) {
    background(255); // normal clear
  } else {
    // fade layer: keeps trails but slowly fades them
    noStroke();
    fill(255, 35);          // white with transparency (alpha)
    rect(0, 0, width, height);
  }

  fill(50, 130, 240);
  ellipse(x, height/2, 30, 30);

  x += speed;

  if (x > width + 15) {
    x = -15;
  }
  // move
  x += xs;
  y += ys;

  // bounce with radius logic
  if (x > width - r || x < r) xs *= -1;
  if (y > height - r || y < r) ys *= -1;

  fill(255, 120, 80);
  ellipse(x, y, r*2, r*2);

  fill(0);
  textSize(16);
  text("Press + to speed up | - to slow down", 20, 25);
  
  if (keyPressed) {
    if (keyCode == RIGHT) px += step;
    if (keyCode == LEFT)  px -= step;
    if (keyCode == DOWN)  py += step;
    if (keyCode == UP)    py -= step;
  }
  // keep player inside the screen
  px = constrain(px, pr, width - pr);
  py = constrain(py, pr, height - pr);
  
  // draw player
  fill(60, 120, 200);
  ellipse(px, py, pr*2, pr*2);
  
  // easing follow (helper moves part of the distance each frame)
  hx = hx + (px - hx) * ease;
  hy = hy + (py - hy) * ease;
  
  // draw helper
  fill(80, 200, 120);
  ellipse(hx, hy, 16, 16);
}


void keyPressed() {
  
  if (key == '+') { xs *= 1.2; ys *= 2; }
  if (key == '-') { xs *= 0.8; ys *= 0.5; }
  if (key == 't' || key == 'T') {
    trails = !trails; // switch true<->false
  }
  // press ENTER to start playing
  if (state == 0 && keyCode == ENTER) {
    state = 1;
    startTime = millis(); // remember the start time
  }
  // press R to reset back to start screen
  if (state == 2 && (key == 'r' || key == 'R')) {
    state = 0;
  }
}
