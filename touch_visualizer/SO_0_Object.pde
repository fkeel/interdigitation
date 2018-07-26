
class Sensor {

  //characteristics
  int spikeWidth; //The width of the spike (high number ==> blunt spike ==> not many spikes fit, low number ==> pointy spike ==> lots of spikes fit)
  int spikeRatio; //0% ==> the strip has zero spike to it, 100% ==> the strip is all spike
  float pointSize; //the size of the touch point as a unit of center to centre of strips. (1 reaches from center of strip one to centre of strip two, 
  //2 reaches from centre of strip one, completely coveres strip two and reachs centre of strip three)
  // Pressure 0 ==> low pressure, 1 ==> high pressure

  int pressureLevels;
  int xPositions;
  int yPositions;
  int stripNumber;

  //data
  float[][][][] data;               //data - [pressure(2)][strip(7)][x(71)][y(11)]
  //  For example, the third strip at the coordinate (20/5) for high pressure will be at data[1][20][5][2]



  Sensor(String filename) { //constructor

    pressureLevels = 2;
    xPositions = 70;
    yPositions = 11;
    stripNumber = 7;

    String[] proporties = parseFileName(filename); //replace the letters in filename, and split it

    spikeWidth = int(proporties[0]); //assign data properties
    spikeRatio = int(proporties[1]);
    pointSize = int(proporties[2])/100f;

    println("spikeWidth: " +spikeWidth + ", spikeRatio: " + spikeRatio + ", pointSize: " + pointSize); //for debug

    data = parseFile(filename); //parse files as described above
  }


  //////////////////////////////////
  /////////quarying methods/////////
  //////////////////////////////////


  boolean spikeWidthIs(int targetSW) {
    if (targetSW == spikeWidth) {
      return true;
    } else {
      return false;
    }
  }

  boolean spikeRatioIs(int targetSR) {
    if (targetSR == spikeRatio) {
      return true;
    } else {
      return false;
    }
  }

  boolean pointSizeIs(float targetPS) {
    if (targetPS == pointSize) {
      return true;
    } else {
      return false;
    }
  }

  //////////////////////////////////
  ///////////return peaks//////////
  //////////////////////////////////

  float[][] returnPeaks(String type, int pressure) { // return all peaks for centreOfmass
    //this array needs to be in columns -- X, Y, Error, R

    // [pressure(2)][strip(7)][x(71)][y(11)]

    float[] weights = new float[stripNumber];
    float[][] positions = new float[3][xPositions*yPositions];
    int index = 0; //keep track of where we store things
    float touchPosition = 0;
    float maxTouchPosition= 0;
    float minTouchPosition= 0;
    float intercept = 0;
    float slope = 0;
    float r;

    for (int y = 0; y < yPositions; y++) { //for each swipe
      for (int x = 0; x < xPositions; x++) { //at each position
      
        for (int strip = 0; strip < stripNumber; strip++) { //get all the strip values, create an array to pass on to touch locators
          weights[strip] = data[pressure][strip][x][y];
        }

        if (type.equals("NAIVE")) {
          touchPosition = naive(weights);
        } else if (type.equals("LINEAR")) {
          touchPosition = linear(weights);
        } else if (type.equals("GAUSSIAN")) {
          touchPosition = gaussian(weights);
        } else if (type.equals("CUBIC")) {
          touchPosition = cubic(weights);
        } else if (type.equals("PARABOLIC")) {
          touchPosition = parabolic(weights);
        } else if (type.equals("BLAIS_RIOUX")) {
          touchPosition = blaisRioux(weights);
        } else if (type.equals("COM")) {
          touchPosition = centreOfMass(weights);
        } else if (type.equals("MICROCHIP")) {
          touchPosition = microchip(weights);
        } else {
          println("ERROR: UNKNOWN TOUCH LOCATOR");
        }

        positions[0][index] = x;//store the 'fingerpositions' here
        positions[1][index] = y; //------------> This assumes the files are ordered. They currently are. But it could lead to a bug later.
        positions[2][index] = touchPosition; //store the COM peaks here

        index = index + 1;
      }
    }

    for (int z = 0; z < positions[1].length; z++) { //remap to correct range
      if (positions[0][z] == 0) {
        minTouchPosition = minTouchPosition + positions[2][z];
      }

      if (positions[0][z] == 69) {
        maxTouchPosition = maxTouchPosition + positions[2][z];
      }
    }
    minTouchPosition = minTouchPosition / yPositions;
    maxTouchPosition = maxTouchPosition / yPositions;

    for (int z = 0; z < positions[2].length; z++) { //remap to correct range
      positions[2][z] = map(positions[2][z], minTouchPosition, maxTouchPosition, 0, 69);
    }

    intercept = intercept(positions[0], positions[2]);  //get intercept to centre the measures around 0
    slope = 1 - slope(positions[0], positions[2]);  //get the slope (using 1-slope as I'm only interested how far its different

    r = correlation(positions[0], positions[2]); //currently not used. just there in case its needed


    // use intercept and slope to align measured positions
    for (int z = 0; z < positions[2].length; z++) { //subtract intended position to get error
      positions[2][z] = positions[2][z] - positions[0][z]-intercept+positions[2][z]*slope;
    }

    //   println(slope);
    return positions;
  }




  //////////////////////////////////
  ///////visualizing methods////////
  //////////////////////////////////


  void drawStripData(int pressure, int strip, float scale) { // <-- ToDo: Add a Type Parameter

    for (int i = 0; i <xPositions-1; i++) {
      //do this at all x positions
      for (int y = 0; y <yPositions; y++) {
        //do this at all y positions
        line(i*15, data[pressure][strip][i][y]*scale, (i+1)*15, data[pressure][strip][i+1][y]*scale); //<-- needs to be uncommented for showing only the dots. 
        // fill(255);
        ellipse(i*15, data[pressure][strip][i][y]*scale, 3, 3);
        if (i == xPositions-2) {
          ellipse(70*15, data[pressure][strip][70][y]*scale, 3, 3); //last dot
        }
      }
      //do this at all x positions
    }
  }

  void drawStripAtY(int pressure, int y, int strip, float scale) { // <-- ToDo: Add a Type Parameter
    //draws curves one by one
    for (int i = 0; i <xPositions-1; i++) {

      line(i*15, data[pressure][strip][i][y]*scale, (i+1)*15, data[pressure][strip][i+1][y]*scale); //<-- needs to be uncommented for showing only the dots. 
      fill(255);
      ellipse(i*15, data[pressure][strip][i][y]*scale, 3, 3);
      if (i == xPositions-2) {
        ellipse(70*15, data[pressure][strip][70][y]*scale, 3, 3); //last dot
      }
      //do this at all x positions
    }
  }




  ///rotate the representation
  void drawStripX(int pressure, float blockSize) { // <-- ToDo: Add a Type Parameter
    // [pressure(2)][strip(7)][x(71)][y(11)]
    stroke(200);
    strokeWeight(0.05);

    for (int i = 0; i < xPositions-1; i++) { //do this for every X

      for (int strip = 0; strip < stripNumber; strip++) { //loop through each strip

        float[] fillColor = new float[11];

        for (int y = 0; y < yPositions; y++) { //loop through each repetition

          fillColor[y] = data[pressure][strip][i][y];
        }

        fill(255-mean(fillColor)*255);
        rect(blockSize*2.5*strip, blockSize*i*0.2, blockSize*2.5, blockSize*0.2);
      }
    }
  }

  void drawCentreOfGravity(int pressure, float blockSize) { // <-- ToDo: Add a Type Parameter
    // [pressure(2)][strip(7)][x(71)][y(11)]
    stroke(120);
    strokeWeight(0.1);
    float[] weights = new float[7];

    for (int i = 0; i < xPositions-1; i++) { //do this for every X

      for (int strip = 0; strip < stripNumber; strip++) { //loop through each strip

        float[] fillColor = new float[11];

        for (int y = 0; y < yPositions; y++) { //loop through each repetition

          fillColor[y] = data[pressure][strip][i][y];
        }


        weights[strip] = mean(fillColor);

        if (weights[strip] < 20) {
          // weights[strip] = 0;
        }

        // rect(blockSize*2.5*strip, blockSize*i*0.2, blockSize*2.5, blockSize*0.2);
        // println("assigned strip number: " + strip + ", " + weights[strip]);
      }

      float touchPosition;
      touchPosition = (weights[0] * 0.5 + weights[1] * 1.5 + weights[2] * 2.5 + weights[3] * 3.5 + weights[4] * 4.5 + weights[5] * 5.5 + weights[6] * 6.5 ) 
        / (weights[0]  + weights[1]  + weights[2]  + weights[3]  + weights[4]  + weights[5] + weights[6]  );
      //result is on scale from 0.5 to 6.5 needs to remap from 0 to 7
      // touchPosition = map(touchPosition, 0.5, 6.5, 0, 7);

      // println("index: " + i + ", position: " + touchPosition);

      noStroke();
      ellipse(touchPosition*blockSize*2.5, blockSize*i*0.2+(blockSize*0.2/2), 3, 3);
      stroke(120);
      strokeWeight(0.1);
      // println(touchPosition);
    }
  }


  void drawNaiveCentre(int pressure, float blockSize) { // <-- ToDo: Add a Type Parameter
    // [pressure(2)][strip(7)][x(71)][y(11)]
    stroke(120);
    strokeWeight(0.1);
    float[] weights = new float[7];
    for (int i = 0; i < xPositions-1; i++) { //do this for every X
      for (int strip = 0; strip < stripNumber; strip++) { //loop through each strip
        float[] fillColor = new float[11];
        for (int y = 0; y < yPositions; y++) { //loop through each repetition
          fillColor[y] = data[pressure][strip][i][y];
        }
        //  fill(mean(fillColor)/contrast);
        weights[strip] = mean(fillColor);
      }

      float touchPosition;
      touchPosition = naive(weights);

      noStroke();
      ellipse(touchPosition*blockSize*2.5, blockSize*i*0.2+(blockSize*0.2/2), 3, 3);
      stroke(120);
      strokeWeight(0.1);

      //  println("index: " + i + ", position: " + touchPosition);
    }
  }

  void drawMicrochip(int pressure, float blockSize) { // <-- ToDo: Add a Type Parameter
    // [pressure(2)][strip(7)][x(71)][y(11)]
    stroke(120);
    strokeWeight(0.1);
    float[] weights = new float[7];
    for (int i = 0; i < xPositions-1; i++) { //do this for every X
      for (int strip = 0; strip < stripNumber; strip++) { //loop through each strip
        float[] fillColor = new float[11];
        for (int y = 0; y < yPositions; y++) { //loop through each repetition
          fillColor[y] = data[pressure][strip][i][y];
        }

        weights[strip] =  mean(fillColor);
      }

      float touchPosition;
      touchPosition = microchip(weights);

      noStroke();
      ellipse(touchPosition*blockSize*2.5, blockSize*i*0.2+(blockSize*0.2/2), 3, 3);
      stroke(120);
      strokeWeight(0.1);

      //  println("index: " + i + ", position: " + touchPosition);
    }
  }

  void drawCubic(int pressure, float blockSize) { // <-- ToDo: Add a Type Parameter
    // [pressure(2)][strip(7)][x(71)][y(11)]
    stroke(120);
    strokeWeight(0.1);
    float[] weights = new float[7];
    for (int i = 0; i < xPositions-1; i++) { //do this for every X
      for (int strip = 0; strip < stripNumber; strip++) { //loop through each strip
        float[] fillColor = new float[11];
        for (int y = 0; y < yPositions; y++) { //loop through each repetition
          fillColor[y] = data[pressure][strip][i][y];
        }

        weights[strip] =  mean(fillColor);
      }

      float touchPosition;
      touchPosition = cubic(weights);

      noStroke();
      ellipse(touchPosition*blockSize*2.5, blockSize*i*0.2+(blockSize*0.2/2), 3, 3);
      stroke(120);
      strokeWeight(0.1);
      println("index: " + i + ", position: " + touchPosition);
    }
  }


  //this should be changed to use the functions in 'touchLocators'
  void drawCentreOfGravityPerTrial(int pressure, int trial, float blockSize) { // <-- ToDo: Add a Type Parameter
    // [pressure(2)][strip(7)][x(71)][y(11)]

    strokeWeight(0.1);
    float[] weights = new float[7];
    float[] nextWeights = new float[7];

    for (int i = 0; i < xPositions-1; i++) { //do this for every X
      for (int strip = 0; strip < stripNumber; strip++) { //loop through each strip

        float fillColor; //store the sensor value
        float nextFillColor;
        fillColor = data[pressure][strip][i][trial]; 
        nextFillColor = data[pressure][strip][i+1][trial];

        weights[strip] = fillColor; //invert sensor values
        nextWeights[strip] = nextFillColor;

        // rect(blockSize*2.5*strip, blockSize*i*0.2, blockSize*2.5, blockSize*0.2);
        // println("assigned strip number: " + strip + ", " + weights[strip]);
      }

      float touchPosition;
      float nextTouchPosition;

      touchPosition = centreOfMass(weights);
      nextTouchPosition = centreOfMass(nextWeights);

      //result is on scale from 0.5 to 6.5 needs to remap from 0 to 7
      // touchPosition = map(touchPosition, 0.5, 6.5, 0, 7);
      // fill(0, 255, 0 );
      strokeWeight(1);
      //ellipse(touchPosition*blockSize*2.5, blockSize*i*0.2+(blockSize*0.2/2), 2.5, 2.5);
      line(touchPosition*blockSize*2.5, blockSize*i*0.2, nextTouchPosition*blockSize*2.5, blockSize*(i+1)*0.2);

      println(touchPosition);
    }
  }



  void tester() { //this does nothing of importance
    println(data[1][3][3]);
  }

  void drawStripAverage(int pressure, int strip, float scale) {
    float average;
    float nextAverage;
    for (int i = 0; i <xPositions-1; i++) {
      //do this at all x positions
      average = mean(data[pressure][strip][i]);
      nextAverage = mean(data[pressure][strip][i+1]);
      line(i*15, average*scale, (i+1)*15, nextAverage*scale);
    }
  }


  void drawStripConfidence(int pressure, int strip, float interval, String type, float scale) {

    //get the average & SD
    float average;
    float deviation;
    float nextAverage;
    float nextDeviation;


    for (int i = 0; i <xPositions; i++) {

      average = mean(data[pressure][strip][i]);
      deviation = standardDeviation(data[pressure][strip][i]);

      noStroke();
      if (type.equals("CURVE")) { //visualize as continuous area
        if (i < xPositions -1) {
          nextAverage = mean(data[pressure][strip][i+1]);
          nextDeviation = standardDeviation(data[pressure][strip][i+1]);
          quad(i*15, average*scale+(deviation*interval)*scale, 
            (i+1)*15, nextAverage*scale+(nextDeviation*interval)*scale, 
            (i+1)*15, nextAverage*scale-(nextDeviation*interval)*scale, 
            i*15, average*scale-(deviation*interval)*scale);
        }
      } else if (type.equals("BLOCKS")) { //display as discrete blocks
        quad(i*15-7, average*scale+(deviation*interval)*scale, 
          i*15+7, average*scale+(deviation*interval*scale), 
          i*15+7, average*scale-(deviation*interval*scale), 
          i*15-7, average*scale-(deviation*interval)*scale);
      } else {
        println("Error, unknown VIZ type for CI");
      }
    }
  }

  void drawStripDelta(int pressure, int strip, float scale) { // 
    pushMatrix();
    translate(15, 1000*scale);

    float average;
    float nextAverage;
    float delta;
    float nextDelta;
    float sd;
    float nextSd;
    float max = 0;


    for (int i = 0; i <xPositions-2; i++) { //find maximum for normalization
      average = mean(data[pressure][strip][i]);
      nextAverage = mean(data[pressure][strip][i+1]);
      delta = abs(average-nextAverage);
      if (delta > max) {
        max = delta;
      }
    }

    for (int i = 0; i <xPositions-2; i++) { //draw maximum

      average = mean(data[pressure][strip][i]);
      nextAverage = mean(data[pressure][strip][i+1]);
      delta = -abs(average-nextAverage);
      average = mean(data[pressure][strip][i+1]);
      nextAverage = mean(data[pressure][strip][i+2]);
      nextDelta = -abs(average-nextAverage);

      line(i*15, (delta/max)*1000*scale, (i+1)*15, (nextDelta/max)*1000*scale);

      //  sd = -standardDeviation(data[pressure][strip][i]);       //display relative to SD? probably not...
      //  nextSd = -standardDeviation(data[pressure][strip][i+1]);
      //  line(i*15, sd*2, (i+1)*15, nextSd*2);
    }

    for (int i = 0; i <xPositions-2; i++) { //draw area (this should work in a single loop, but I want the color formatting to be outside, so maybe not...

      average = mean(data[pressure][strip][i]);
      nextAverage = mean(data[pressure][strip][i+1]);
      delta = -abs(average-nextAverage);
      average = mean(data[pressure][strip][i+1]);
      nextAverage = mean(data[pressure][strip][i+2]);
      nextDelta = -abs(average-nextAverage);

      noStroke();

      quad(i*15, (delta/max)*1000*scale, (i+1)*15, (nextDelta/max)*1000*scale, (i+1)*15, 0, i*15, 0);
    }
    popMatrix();
  }


  /*********************THIS NEEDS THINKING***********************/

  void drawStripQuality(int pressure, int strip, float scale) { 
    pushMatrix();
    translate(0, 1000*scale);

    float average;
    float nextAverage;
    float delta;
    float nextDelta;
    float sd;
    float nextSd;


    for (int i = 0; i <xPositions-2; i++) {
      stroke(0, 125, 0);
      strokeWeight(2);
      average = mean(data[pressure][strip][i]);
      nextAverage = mean(data[pressure][strip][i+1]);
      delta = -abs(average-nextAverage);
      average = mean(data[pressure][strip][i+1]);
      nextAverage = mean(data[pressure][strip][i+2]);
      nextDelta = -abs(average-nextAverage);
      // line(i*15, delta, (i+1)*15, nextDelta);
      stroke(255, 125, 0);
      sd = -standardDeviation(data[pressure][strip][i]);
      nextSd = -standardDeviation(data[pressure][strip][i+1]);
      //  line(i*15, sd, (i+1)*15, nextSd);
      noStroke();
      if (abs(delta)>abs(sd*1.645)) {
        //   if (abs(delta)>abs(sd*1.96)) {
        quad(i*15, 0, i*15, -1000*scale, (i)*15+8, -1000*scale, (i)*15+8, 0);
        println(delta);
      }
    }

    for (int i = xPositions-1; i > 1; i--) {
      stroke(0, 125, 0);
      strokeWeight(2);
      average = mean(data[pressure][strip][i]);
      nextAverage = mean(data[pressure][strip][i-1]);
      delta = -abs(average-nextAverage);
      average = mean(data[pressure][strip][i-1]);
      nextAverage = mean(data[pressure][strip][i-2]);
      nextDelta = -abs(average-nextAverage);
      // line(i*15, delta, (i+1)*15, nextDelta);
      stroke(255, 125, 0);
      sd = -standardDeviation(data[pressure][strip][i]);
      nextSd = -standardDeviation(data[pressure][strip][i-1]);
      //  line(i*15, sd, (i+1)*15, nextSd);
      noStroke();
      if (abs(delta)>abs(sd*1.645)) {
        //   if (abs(delta)>abs(sd*1.96)) {
        quad(i*15, 0, i*15, -1000*scale, (i)*15-7, -1000*scale, (i)*15-7, 0);
        println(delta);
      }
    }




    popMatrix();
  }

  //////////////////////////////////
  ///////Calculation methods////////
  //////////////////////////////////









  //maybe these should not be used









  //don't use, remove these eventually










  //mean
  float[] getStripAverages(int pressure, int strip) {
    float[] averages = new float [xPositions];
    for (int i = 0; i <xPositions; i++) {
      //do this at all x positions
      for (int y = 0; y <yPositions; y++) {
        //do this at all y positions
        //   averages[i] = averages[i] + data[pressure][i][y][strip];
      }
      averages[i] = averages[i]/yPositions;
      //do this at all x positions
    }
    return averages;
  }

  //standard deviation
  float[] getStandardDeviations(int pressure, int strip) {
    float[] averages = getStripAverages(pressure, strip);
    float[] totals = new float[averages.length];  
    float[] variances = new float[averages.length];  
    float[] sds = new float[averages.length];  

    for (int i = 0; i <xPositions; i++) {
      //do this at all x positions
      for (int y = 0; y <yPositions; y++) {
        //do this at all y positions
        //     totals[i] = totals[i] + sq(data[pressure][i][y][strip]-averages[i]);
      }
    }

    for (int i = 0; i <xPositions; i++) {
      variances[i] = totals[i] / yPositions;
      sds[i] = sqrt(variances[i]);
    }
    return sds;
  }
}