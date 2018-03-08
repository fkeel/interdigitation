
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
  int[][][][] data;               //data - [pressure(2)][x(71)][y(11)][strip(7)]
  //  For example, the third strip at the coordinate (20/5) for high pressure will be at data[1][20][5][2]



  Sensor(String filename) { //constructor

    pressureLevels = 2;
    xPositions = 71;
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
  ///////visualizing methods////////
  //////////////////////////////////


  void drawStripData(int pressure, int strip) {

    for (int i = 0; i <xPositions-1; i++) {
      //do this at all x positions
      for (int y = 0; y <yPositions; y++) {
        //do this at all y positions
        line(i*15, data[pressure][i][y][strip]*0.4, (i+1)*15, data[pressure][i+1][y][strip]*0.4);
      }
      //do this at all x positions
    }
  }

  void drawStripAverage(int pressure, int strip) {

    //get the average
    float[] averages = getStripAverages(pressure, strip);

    for (int i = 0; i <xPositions-1; i++) {
      //do this at all x positions
      line(i*15, averages[i]*0.4, (i+1)*15, averages[i+1]*0.4);
    }
  }

  void drawStripConfidence(int pressure, int strip, float interval) {

    //get the average
    float[] averages = getStripAverages(pressure, strip);
    float[] deviations = getStandardDeviations(pressure, strip);
    // deviations = simpleSmooth(deviations);

    for (int i = 0; i <xPositions; i++) {
      //do this at all x positions
    //  line(i*15, averages[i]*0.4+(deviations[i]*interval), (i+1)*15, averages[i+1]*0.4+(deviations[i+1]*interval));
     // line(i*15, averages[i]*0.4-(deviations[i]*interval), (i+1)*15, averages[i+1]*0.4-(deviations[i+1]*interval));
      /*
      noStroke();
      quad(i*15, averages[i]*0.4+(deviations[i]*interval), 
          (i+1)*15, averages[i+1]*0.4+(deviations[i+1]*interval), 
          (i+1)*15, averages[i+1]*0.4-(deviations[i+1]*interval), 
          i*15, averages[i]*0.4-(deviations[i]*interval));
          */
         
      noStroke();
      quad(i*15-8, averages[i]*0.4+(deviations[i]*interval), 
          i*15+7, averages[i]*0.4+(deviations[i]*interval), 
          i*15+7, averages[i]*0.4-(deviations[i]*interval), 
          i*15-8, averages[i]*0.4-(deviations[i]*interval));
          
         
          line(i*15-3, averages[i]*0.4+(deviations[i]*interval), i*15+3, averages[i]*0.4+(deviations[i]*interval));
          line(i*15-3, averages[i]*0.4-(deviations[i]*interval), i*15+3, averages[i]*0.4-(deviations[i]*interval));
          line(i*15, averages[i]*0.4+(deviations[i]*interval), i*15, averages[i]*0.4-(deviations[i]*interval));
    }
  }


  //////////////////////////////////
  ///////Calculation methods////////
  //////////////////////////////////

  //mean
  float[] getStripAverages(int pressure, int strip) {
    float[] averages = new float [xPositions];
    for (int i = 0; i <xPositions; i++) {
      //do this at all x positions
      for (int y = 0; y <yPositions; y++) {
        //do this at all y positions
        averages[i] = averages[i] + data[pressure][i][y][strip];
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
        totals[i] = totals[i] + sq(data[pressure][i][y][strip]-averages[i]);
      }
    }

    for (int i = 0; i <xPositions; i++) {
      variances[i] = totals[i] / yPositions;
      sds[i] = sqrt(variances[i]);
    }
    return sds;
  }
}