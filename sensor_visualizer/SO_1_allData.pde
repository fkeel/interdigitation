
  //////////////////////////////////////////////
  //////////////////visalizing methods
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

    //setting colors
    strokeWeight(2);
    stroke(200, 0, 100, 100); // <---- adjust opacity
    fill(255);

    //decide which sub-set to plot
    float[][] plotThisData = dataLowPressure;
    if (pressure.equals("HIGH") == true) {
      plotThisData = dataHighPressure;
      stroke(100, 0, 200, 100); // <---- adjust opacity
    } 
    stroke(100, 0, 200, 100); 
    // draw all the lines 
    int repetitionCounter = 0; //disconenct individual trials (this is only updated when new trial starts);

    for (int i = 0; i < plotThisData.length-1; i++) {
      stroke(0+(22*repetitionCounter), 0, 250-(22*repetitionCounter), 100); 
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



 