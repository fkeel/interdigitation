
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
    fill(250, 200, 100, 80);
    for (int i = 0; i < avgValue.length-1; i++) { //loop through all records

      quad(i*15, avgValue[i]*0.4+1.86*SDs[i], i*15, avgValue[i]*0.4-1.86*SDs[i], 
        (i+1)*15, avgValue[i+1]*0.4-1.86*SDs[i+1], (i+1)*15, avgValue[i+1]*0.4+1.86*SDs[i+1]);

      //  ellipse(i*15, avgValue[i]*0.4, 5, 5);
      //   println(i + "drew point " + data[i][targetIndexA]*scaler + "/" + data[i][targetIndexB]*scaler);
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