/**Class RingSystemProcessing 
 * A gravitational simulation in a Cartesian coordinate system.
 *
 * @author Thomas Cann
 * @author Sam Hinson
 * @version 2.0
 */

// Basic parameters

float h_stepsize;

//Dynamic Timestep variables
 float simToRealTimeRatio = -3600.0/1.0;   // 3600.0/1.0 --> 1hour/second
final float maxTimeStep = 20* simToRealTimeRatio / 30;
float totalSimTime =0.0;                       // Tracks length of time simulation has be running

Boolean Running = true;
Boolean Display = true;
Boolean Add = false;
Boolean clear = false;
Boolean debug = false;
Boolean specific = false;
Boolean file = true;

//Initialising Objects
RingSystem Saturn;


void setup() {
  size (1900, 1000, P2D);
  //fullScreen(P2D, 2);

  frameRate(120);
  smooth(); //noSmooth();
  randomSeed(3);
  Saturn = new RingSystem();
  background(0);
}

void draw() {

  // calculate simulation time step for this frame
  //if (simToRealTimeRatio/frameRate < maxTimeStep) {
  h_stepsize= simToRealTimeRatio/frameRate;
  //} else {
  //  h_stepsize= maxTimeStep;
  //  println("At Maximum Time Step");
  //}

  //*************Update and Render Frame******************

  //Updates properties of all objects.

  if (Running) {
    update();
  }
  //Display all of the objects to screen.
  if (Display) {
    display();
  }
  fps();
  //******************************************************

  totalSimTime +=h_stepsize;
}


void update() {
  Saturn.update();
}

void display() {
  background(0);
  Saturn.display();
}

//Display FrameRate and Time data to bar along bottom of screen
void fps() {
  surface.setTitle("Framerate: " + int(frameRate) + "     Time Elapsed[Seconds]: " + int(millis()/1000.0) + "     Simulation Time Elapsed[hours]: " + int(totalSimTime/3600.0)); //Set the frame title to the frame rate
}



void keyPressed() {
  if (key ==' ') {
    if (Running) {
      Running =false;
    } else {
      Running = true;
    }
  } else if (key =='h') {
    if (Display) {
      Display =false;
    } else {
      Display = true;
    }
  } else if (key =='a') {
    Add = !Add;
    println("Add: " + Add);
  } else if (key=='c') {
    clear= !clear;
    println("Clear: " + clear);
  } else if (key =='d') {
    debug = !debug;
    println("Debug: " + debug);
  }
  else if (key =='s') {
    specific = !specific;
    println("Specific : " + specific );
  }  else if (key =='f') {
    file = !file;
    println("File : " + file );
  } else if(key=='t'){
     simToRealTimeRatio *=-1;
  }
  
  
}
