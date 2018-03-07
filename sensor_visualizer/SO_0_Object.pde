
class Sensor {
  //characteristics
  int spikeWidth; //The width of the spike (high number ==> blunt spike ==> not many spikes fit, low number ==> pointy spike ==> lots of spikes fit)
  int spikeRatio; //0% ==> the strip has zero spike to it, 100% ==> the strip is all spike
  float pointSize; //the size of the touch point as a unit of center to centre of strips. (1 reaches from center of strip one to centre of strip two, 
  //2 reaches from centre of strip one, completely coveres strip two and reachs centre of strip three)
  // maybe we should have HIGH/LOW pressure conditions here

  //data
  String[] classes;             //header
  float[][] data;               //data
  float[][] dataHighPressure;
  float[][] dataLowPressure;


  Sensor(String filename) { //constructor
  
    ////////////////////////////////////
    //parse filename for relevant data//
    ////////////////////////////////////
    
    //example filename "SW100-RATIO0-P125.csv" 

    String[] proporties = splitTokens(filename, "- .");

    proporties[0] = proporties[0].replace('S', '0'); //replace all letters with zero, to make conversion from String to numericals easier
    proporties[0] = proporties[0].replace('W', '0');
    proporties[1] = proporties[1].replace('R', '0');
    proporties[1] = proporties[1].replace('A', '0');
    proporties[1] = proporties[1].replace('T', '0');
    proporties[1] = proporties[1].replace('I', '0');
    proporties[1] = proporties[1].replace('O', '0');
    proporties[2] = proporties[2].replace('P', '0');

    spikeWidth = int(proporties[0]); //assign data properties
    spikeRatio = int(proporties[1]);
    pointSize = int(proporties[2])/100f;

    println("spikeWidth: " +spikeWidth + ", spikeRation: " + spikeRatio + ", pointSize: " + pointSize); //for debug
    
    

    ////////////////////////////////
    //Parse csv to populate arrays//
    ////////////////////////////////
    String[] lines = loadStrings(filename);
    classes = split(lines[1], ','); // should probably be zero, if formatted correctly //should be assigned manually, its buggy
    data = new float[lines.length-2][classes.length]; //-2 because first two lines in files are trash
    println("Parse Files - OK");

    //assign class labels
    for (int i = 0; i < classes.length; i++) {
      classes[i] = trim(classes[i]);
    }
    println("Class Labels - OK");

    //assign data
    for (int i = 0; i < lines.length; i++) {
      String[] placeHolder = split(lines[i], ','); //create an array of all items in a line (it starts with 2, because 0 is trash and 1 is classes)
      if (i>1) {
        for (int y = 0; y < placeHolder.length; y++) {
          data[i-2][y] = float(trim(placeHolder[y])); //trim white spaces, convert to int (the date will be useless)
        }
      }
    }
    println("Assign Data - OK");

    //prepare arrays;
    dataHighPressure = new float[data.length/2][data[6].length];
    dataLowPressure = new float[data.length/2][data[6].length];
    println("array declaration - OK");


    //split by pressure strength
    for (int i = 0; i < data.length; i++) {
      if (i < (data.length/2)) {
        dataLowPressure[i] = data[i];
      } else {
        dataHighPressure[i-data.length/2] = data[i];
      }
    }
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

// object doesn't end here, so no curley brackets. other methods all have their own tab, to find them faster