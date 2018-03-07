


///////////// PLOT INFORMATION GAINED//////////////////

void drawBaseline(String targetClassB, String pressure) {

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

  //get the deltas
  float[][] deltas = new float[targetValues.length][targetValues[1].length]; 
  for (int i = 0; i < deltas.length; i++) 
  { 
    for (int y = 1; y < deltas[i].length; y++) 
    { 
      deltas[i][y] = abs(targetValues[i][y-1]-targetValues[i][y]);
      // deltas[i][y] = targetValues[i][y];
    }
  }

  //get the average deltas
  float[] avgValue = new float[71]; 
  for (int i = 0; i < avgValue.length; i++) 
  { 
    avgValue[i] = mean(deltas[i]);
    // avgValue[i] = mean(targetValues[i]);
  }

  //get the SDs of the deltas
  float[] SDs = new float[71]; 
  for (int i = 0; i < avgValue.length; i++) 
  { 
    SDs[i] = standardDeviation(deltas[i]);
    // SDs[i] = standardDeviation(targetValues[i]);
  }


  //smoothSD
  SDs = simpleSmooth(SDs);
  avgValue = simpleSmooth(avgValue);

  //plotMean
  pushMatrix();
  translate(0, 400);
  strokeWeight(0);
  stroke(0, 100, 20, 240);
  fill(255);

  for (int i = 0; i < SDs.length-1; i++) { //loop through all records

    stroke(0, 100, 20, 240);
    line(i*15, -(SDs[i])*1.645, (i+1)*15, -(SDs[i+1])*1.645); //drawMax of 95%CI (one sided!)
    fill(200, 200, 0, 80);
    noStroke();
    quad(i*15, -SDs[i]*1.645, i*15, 0, 
      (i+1)*15, 0, (i+1)*15, -SDs[i+1]*1.645);//drawMax of 95%CI (one sided!)
    strokeWeight(0);
    //  ellipse(i*15, avgValue[i]*0.4, 5, 5);
    //   println(i + "drew point " + data[i][targetIndexA]*scaler + "/" + data[i][targetIndexB]*scaler);
  }
  popMatrix();
}



//closing curly bracket is for object, SO_0,1,2,3 etc
}