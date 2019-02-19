// Flow Field Following

// Daniel Shiffman <http://www.shiffman.net>

// The Nature of Code, Spring 2009



class FlowField {



  // A flow field is a two dimensional array of PVectors

  PVector[][] field;

  int cols, rows; // Columns and Rows

  int resolution; // How large is each "cell" of the flow field



  FlowField(int r) {

    resolution = r;

    // Determine the number of columns and rows based on sketch's width and height

    cols = width/resolution;

    rows = height/resolution;

    field = new PVector[cols][rows];

    init();

  }



  void init() {

    // Reseed noise so we get a new flow field every time

    noiseSeed((int)random(10000));

    float xoff = 0;

    for (int i = 0; i < cols; i++) {

      float yoff = 0;
      
      for (int j = 0; j < rows; j++) {

        // Use perlin noise to get an angle between 0 and 2 PI
        
        float theta =  atan2((j-rows/2),(i-cols/2)); //atan((10-j)/(i-20)); // map(noise(xoff,yoff),0,1,0,TWO_PI);
        float radius = pow(sqrt(sq(j-rows/2) + sq(i-cols/2)),-0.5) ;

        // Polar to cartesian coordinate transformation to get x and y components of the vector

        field[i][j] =  new PVector(radius *- sin(theta), radius * cos(theta)); //new PVector(cos(j/(2)),sin(i/(2))); new PVector(-sin(theta),cos(theta));

        yoff += 0.1;

      }

      xoff += 0.1;

    }

  }

  

  

  // changes flowfield over time

//  void time(float ch) {

//        float xoff = 0+ch;

//    for (int i = 0; i < cols; i++) {

//      float yoff = 0+ch;

//      for (int j = 0; j < rows; j++) {

//        // Use perlin noise to get an angle between 0 and 2 PI

//        float theta = map(noise(xoff,yoff),0,1,0,TWO_PI);

//        // Polar to cartesian coordinate transformation to get x and y components of the vector

//        field[i][j] = new PVector(cos(theta),sin(theta));

//        yoff += 0.1;

//      }

//      xoff += 0.1;

//    }

//  }



  // Draw every vector

  void display() {

    for (int i = 0; i < cols; i++) {

      for (int j = 0; j < rows; j++) {

        drawVector(field[i][j],i*resolution,j*resolution,resolution-2);

      }

    }



  }



  // Renders a vector object 'v' as an arrow and a location 'x,y'

  void drawVector(PVector v, float x, float y, float scayl) {

    pushMatrix();

    float arrowsize = 4;

    // Translate to location to render vector

    translate(x,y);

    stroke(100);

    // Call vector heading function to get direction (note that pointing up is a heading of 0) and rotate

    rotate(v.heading2D());

    // Calculate length of vector & scale it to be bigger or smaller if necessary

    float len = v.mag()*scayl;

    // Draw three lines to make an arrow (draw pointing up since we've rotate to the proper direction)

    line(0,0,len,0);

    line(len,0,len-arrowsize,+arrowsize/2);

    line(len,0,len-arrowsize,-arrowsize/2);

    popMatrix();

  }



  PVector lookup(PVector lookup) {

    int i = (int) constrain(lookup.x/resolution,0,cols-1);

    int j = (int) constrain(lookup.y/resolution,0,rows-1);

    return field[i][j].get();

  }





}
