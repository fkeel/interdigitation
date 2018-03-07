


///////////// PLOT INFORMATION GAINED//////////////////

void drawDeltaSum(String pressure) {



  //decide which sub-set to plot
  float[][] plotThisData = dataLowPressure; //[trial #][headers]
  if (pressure.equals("HIGH") == true) {
    plotThisData = dataHighPressure;
  } 



  //createTargetArray (reshape)
  float[][][] targetValues = new float[7][71][11]; //  [Strip][x-axis][y-axis]
  //initialize the avgValue array
  for (int i = 0; i < targetValues.length; i++) 
  { 
    for (int y = 0; y < targetValues[i].length; y++) 
    { 
      for (int j = 0; j < targetValues[i][y].length; j++) 
      { 
        targetValues[i][y][j] = 0;
      }
    }
  }

  //populateAverageArray
  int repititionCounter = 0;
  for (int i = 0; i < targetValues.length; i++) //7
  { 
    for (int y = 0; y < plotThisData.length; y++) //71
    { 

      targetValues[i][int(data[y][6])][repititionCounter] = plotThisData[y][i+9]; // <------------------fix!

      if (plotThisData[i][6] != 0 && plotThisData[i][6]%70 == 0) { 
        repititionCounter++;
      }
    }
  }

  //get the deltas
  float[][][] deltas = new float[targetValues.length][targetValues[1].length][targetValues[1][1].length];  // [Strip][x-axis][y-axis]

  for (int i = 0; i < targetValues.length; i++) 
  { //println("per stripe");
    for (int y = 1; y < targetValues[i].length; y++) 
    {// println("per position");
      for (int j = 0; j < targetValues[i][y].length; j++) 
      {// print("per repitition.. ");
        deltas[i][y][j] = abs(targetValues[i][y-1][j]-targetValues[i][y][j]); // <------------------fix!
        // deltas[i][y] = targetValues[i][y];
        // println(" ... assigned");
      }
     // deltas[i][y] = simpleSmooth(deltas[i][y]);
    }
  }

  //plotMean
  pushMatrix();
  translate(0, 400);
  strokeWeight(1);
  stroke(150, 100, 20, 140);
  fill(255);

  for (int y = 1; y < deltas[6].length-1; y++) //-1, because deltas
  { 
    //per X position [71]
    float summedDelta = 0;
    float nextSummedDelta = 0;

    for (int i = 0; i < deltas.length; i++) 
    {  
      //per strip [7]



      for (int j = 0; j < deltas[i][y].length; j++)  
      {
        //per repeated measure [11]

        summedDelta = summedDelta + deltas[i][y][j];
        nextSummedDelta = nextSummedDelta + deltas[i][y+1][j];
      }
    }
    stroke(0, 100, 20, 240);
    //    println("stroke drawn: " + -summedDelta + " / " + -nextSummedDelta);
    line(y*15, -summedDelta, (y+1)*15, -nextSummedDelta); //drawMax of 95%CI (one sided!)
  }

  popMatrix();
}

//closing curly bracket is for object, SO_0,1,2,3 etc
}