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

    strokeWeight(12);
    stroke(255,120);
    fill(255);
    for (int i = 0; i < avgValue.length-1; i++) { //loop through all records

      line(i*15, avgValue[i]*0.4, (i+1)*15, avgValue[i+1]*0.4);
  
      // ellipse(i*15, avgValue[i]*0.4, 5, 5);
      //   println(i + "drew point " + data[i][targetIndexA]*scaler + "/" + data[i][targetIndexB]*scaler);
    }
    
     strokeWeight(8);
    stroke(255,220);
    fill(255);
    for (int i = 0; i < avgValue.length-1; i++) { //loop through all records

      line(i*15, avgValue[i]*0.4, (i+1)*15, avgValue[i+1]*0.4);
  
      // ellipse(i*15, avgValue[i]*0.4, 5, 5);
      //   println(i + "drew point " + data[i][targetIndexA]*scaler + "/" + data[i][targetIndexB]*scaler);
    }

    //plotMean
    strokeWeight(3);
    stroke(200, 0, 20, 240);
    fill(255);
    for (int i = 0; i < avgValue.length-1; i++) { //loop through all records

      line(i*15, avgValue[i]*0.4, (i+1)*15, avgValue[i+1]*0.4);
   
      // ellipse(i*15, avgValue[i]*0.4, 5, 5);
      //   println(i + "drew point " + data[i][targetIndexA]*scaler + "/" + data[i][targetIndexB]*scaler);
    }
  }