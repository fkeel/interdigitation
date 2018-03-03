
class Sensor {
  //characteristics
  int spikeWidth;
  int spikeRatio;
  float pointSize;
  // maybe we should have HIGH/LOW pressure conditions here

  int xOffset; //to move the graphs around so they fit

  //data
  String[] classes;
  float[][] data; //data
  float[][] dataHighPressure;
  float[][] dataLowPressure;


  Sensor(String filename) { //constructor

    //e.g.: "SW100-RATIO0-P125.csv" //parse for other values

    String[] proporties = splitTokens(filename, "- .");


    proporties[0] = proporties[0].replace('S', '0');
    proporties[0] = proporties[0].replace('W', '0');
    proporties[1] = proporties[1].replace('R', '0');
    proporties[1] = proporties[1].replace('A', '0');
    proporties[1] = proporties[1].replace('T', '0');
    proporties[1] = proporties[1].replace('I', '0');
    proporties[1] = proporties[1].replace('O', '0');
    proporties[2] = proporties[2].replace('P', '0');

    spikeWidth = int(proporties[0]);
    spikeRatio = int(proporties[1]);
    pointSize = int(proporties[2])/100f;

    println("spikeWidth: " +spikeWidth + ", spikeRation: " + spikeRatio + ", pointSize: " + pointSize);


    //Parse csv to populate arrays
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


  //////////////////////////////////////////////
  //////////////////methods
  //////////////////////////////////////////////


  ///////// PLOT ALL THE DATA///////////////////

  void drawData(String targetClassB, String pressure) {
    println("OK, I'm trying to draw");

    //find y-axis variable
    int targetIndexB = 99;
    for (int i = 0; i < classes.length; i++) 
    { 
      if (classes[i].equals(targetClassB)) {
        targetIndexB = i;
      }
    }
    if (targetIndexB ==99) {
      println("ERROR, UNKNOWN Sensor");
    }

    //decide which sub-set to plot
    float[][] plotThisData = dataLowPressure;
    if (pressure.equals("HIGH") == true) {
      plotThisData = dataHighPressure;
    } 

    // draw all the lines 
    int repetitionCounter = 0; //disconenct individual trials (this is only updated when new trial starts);
    strokeWeight(2);
    stroke(100, 0, 200, 60);
    fill(255);
    for (int i = 0; i < plotThisData.length-1; i++) {
      // print("ok, trying to draw a line. ... ");
      if (plotThisData[i][6] != 0 && plotThisData[i][6]%70 == 0) {
        println();
        println("OK, moving to next set");
        repetitionCounter++;
        i++;
      }

      line(plotThisData[i][6]*15, plotThisData[i][targetIndexB]*0.4, plotThisData[i+1][6]*15, plotThisData[i+1][targetIndexB]*0.4);

      println("plotting this circle: " + plotThisData[i][6]*15 + " / " + plotThisData[i][targetIndexB]*0.4 + "\t" + "@index: " + plotThisData[i][6]);
      ellipse(plotThisData[i][6]*15, plotThisData[i][targetIndexB]*0.4, 5, 5);
    }
  }



  ///////////// PLOT MEAN //////////////////

  void drawMean(String targetClassB, String pressure) {

    int targetIndexB = 99;
    //  println(targetClassA);
    for (int i = 0; i < classes.length; i++) 
    { 
      if (classes[i].equals(targetClassB)) {

        targetIndexB = i;
      }
    }
    if (targetIndexB ==99) {
      println("ERROR, UNKNOWN ClassB");
    }

    //decide which sub-set to plot
    float[][] plotThisData = dataLowPressure;
    if (pressure.equals("HIGH") == true) {
      plotThisData = dataHighPressure;
    } 

    //createAverageArray
    float[][] targetValues = new float[71][11]; 
    //initialize the avgValue array
    for (int i = 0; i < targetValues.length; i++) 
    { 
      for (int y = 0; y < targetValues[i].length; y++) 
      { 
        targetValues[i][y] = 0;
      }
    }

    //populateAverageArray
    int repititionCounter = 0;
    for (int i = 0; i < plotThisData.length; i++) 
    { 
      targetValues[int(data[i][6])][repititionCounter] = plotThisData[i][targetIndexB];

      if (data[i][6] != 0 && data[i][6]%70 == 0) { 
        repititionCounter++;
      }
    }

    //println for debug
    for (int i = 0; i < targetValues.length; i++) 
    { 
      //  println(targetValues[i]);
    }


    float[] avgValue = new float[71]; 
    for (int i = 0; i < avgValue.length; i++) 
    { 
      avgValue[i] = mean(targetValues[i]);
    }



    //plotMean
    strokeWeight(2);
    stroke(200, 0, 20, 240);
    fill(255);
    for (int i = 0; i < avgValue.length-1; i++) { //loop through all records

      line(i*15, avgValue[i]*0.4, (i+1)*15, avgValue[i+1]*0.4);
      strokeWeight(2);
      //  ellipse(i*15, avgValue[i]*0.4, 5, 5);
      //   println(i + "drew point " + data[i][targetIndexA]*scaler + "/" + data[i][targetIndexB]*scaler);
    }
  }




  ////////////////////////////PLOT 95%CI /////////////////////////////////

  void drawConfidence(String targetClassB, String pressure) {


    int targetIndexB = 99;
    for (int i = 0; i < classes.length; i++) 
    { 
      if (classes[i].equals(targetClassB)) {

        targetIndexB = i;
      }
    }
    if (targetIndexB ==99) {
      println("ERROR, UNKNOWN ClassB");
    }




    //decide which sub-set to plot
    float[][] plotThisData = dataLowPressure;
    if (pressure.equals("HIGH") == true) {
      plotThisData = dataHighPressure;
    } 

    //createAverageArray
    float[][] targetValues = new float[71][11]; 
    //initialize the avgValue array
    for (int i = 0; i < targetValues.length; i++) 
    { 
      for (int y = 0; y < targetValues[i].length; y++) 
      { 
        targetValues[i][y] = 0;
      }
    }

    //populateAverageArray
    int repititionCounter = 0;
    for (int i = 0; i < plotThisData.length; i++) 
    { 
      targetValues[int(data[i][6])][repititionCounter] = plotThisData[i][targetIndexB];

      if (data[i][6] != 0 && data[i][6]%70 == 0) { 
        repititionCounter++;
      }
    }


    //Calculate AVG
    float[] avgValue = new float[71]; 
    for (int i = 0; i < avgValue.length; i++) 
    { 
      avgValue[i] = mean(targetValues[i]);
    }
    //Calculate SDs
    float[] SDs = new float[71]; 
    for (int i = 0; i < avgValue.length; i++) 
    { 
      SDs[i] = standardDeviation(targetValues[i]);
    }
    //smoothSD

    SDs = simpleSmooth(SDs);




    //plot 95%CI bars
    noStroke();
    fill(200, 0, 20, 80);
    for (int i = 0; i < avgValue.length-1; i++) { //loop through all records

      quad(i*15, avgValue[i]*0.4+1.86*SDs[i], i*15, avgValue[i]*0.4-1.86*SDs[i], 
        (i+1)*15, avgValue[i+1]*0.4-1.86*SDs[i+1], (i+1)*15, avgValue[i+1]*0.4+1.86*SDs[i+1]);

      //  ellipse(i*15, avgValue[i]*0.4, 5, 5);
      //   println(i + "drew point " + data[i][targetIndexA]*scaler + "/" + data[i][targetIndexB]*scaler);
    }
  }
}



/*
    float[] SDs = new float[71]; 
 for (int i = 0; i < avgValue.length; i++) 
 { 
 SDs[i] = standardDeviation(targetValues[i]);
 }
 
 
 SDs = simpleSmooth(SDs);
 
 */