/** RingSim extends Chris Arridge work in python.
 * @author Thomas Cann 
 * @version 1.0
 */

float time = 0 ;
float h_stepsize = 0.1;
float n_orboids = 10000;

// A boolean to track whether we are recording are not
boolean recording = false;

ArrayList<Orboid> orboids;


/** Sets the application size [pixels].
 *  Intialises an arraylist called orboids.
 *  Intialises n_orboids number of orboid objects. 
 *  Adds all Orboid objects orboids arraylist.
 */
void setup () {
  size (900, 900);

  orboids = new ArrayList<Orboid>();

  for (int i = 0; i < n_orboids; i++) {
    orboids.add(new Orboid());
  }
} 

/** 
 *  Sets background colour.
 *  Calls and runs update method.
 *  When mouse is clicked, an orboid is created at that position.
 *  Calls and runs record_update method.
 */
void draw () {

  background(0); 

  update();

  time+= h_stepsize;
  println(time+ " ");

  if (mousePressed) {
    orboids.add(new Orboid(mouseX, mouseY));
  } 

  record_update();
  //delay(100);
}

/**
 *  If 'r' key is pressed, start or stop recording.
 */
void keyPressed() {

  if (key == 'r' || key == 'R') {
    recording = !recording;
  }
}

/**
 *  Every draw cycle update the position of all the orboids
 */
void update() {
  push();
  translate(width/2, height/2);
  for (Orboid x : orboids) {
    // Zero acceleration to start
    x.update();
  }


  theta_moon += vtheta_moon*h_stepsize;

  stroke(255);
  line(0, 0, 400 * cos(theta_moon), 400*sin(theta_moon));
  noFill();
  circle(0, 0, 150);
  circle(0, 0, 300);
  pop();
}

/**
 *  If recoding output frames and show recording with text and red circle.
 */
void record_update() {
  push();
  // If we are recording call saveFrame!
  // The number signs (#) indicate to Processing to 
  // number the files automatically
  if (recording) {
    saveFrame("output/frames####.png");
  }

  // Let's draw some stuff to tell us what is happening
  // It's important to note that none of this will show up in the
  // rendered files b/c it is drawn *after* saveFrame()
  textAlign(CENTER);
  fill(255);
  if (!recording) {
    text("Press r to start recording.", width/2, height-24);
  } else {
    text("Press r to stop recording.", width/2, height-24);
  }

  // A red dot for when we are recording
  stroke(255);
  if (recording) {
    fill(255, 0, 0);
  } else { 
    noFill();
  }
  ellipse(width/2, height-48, 16, 16);
  pop();
}
