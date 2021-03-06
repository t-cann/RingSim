/**<h1>RingSim</h1> extends Chris Arridge work in python.
 * Through the implementation of simple boid like rules, a ring system is created.
 *<ul><li>Rule 1 - Damps out radial motion to artificially simulate collisions</li>
 *<li>Rule 2 - Applies acceleration to particles so they only orbit at keplerian speed.</li>
 *<li>Rule 3 - Artificially creates ring gaps based on given clearing properties </li>
 *<li>Rule 4- Random gaussian noise to simulate collisions</li>
 *<li>Rule 5- Creates a Shepherd Moon that forms a ring gap through orbital resonance.</li></ul>
 * @author Thomas Cann
 * @author Sim Hinson
 * @version 1.0
 */

float time = 0 ;
float h_stepsize = 0.1;
float n_orboids = 10000;

//Dynamic Scaling of Time Step
//float startTime, endTime;
float FPS =30;

// A boolean to track whether we are recording are not
boolean recording = false;

ArrayList<Orboid> orboids;


/** Sets the application size [pixels].
 *  Intialises an arraylist called orboids.
 *  Intialises n_orboids number of orboid objects. 
 *  Adds all Orboid objects orboids arraylist.
 */
void setup () {
  frameRate(FPS+30);
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
  

  if (mousePressed) {
    orboids.add(new Orboid(mouseX, mouseY));
  } 

  record_update();
  //delay(100);
  
  fill(0);
  rect(0,height-20,width,20);
  fill(255);
  text("Framerate: " + int(frameRate),10,height-6);

  if( frameRate <FPS){
   orboids.remove(orboids.size()-1);
   //h_stepsize *= 1.01;
  }
  
  println("Time: "+time+ " Stepsize: " + h_stepsize + " Number: " + orboids.size()  );
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
  circle(0, 0, 300);
  circle(0, 0, 600);
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
