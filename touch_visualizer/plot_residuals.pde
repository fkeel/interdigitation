
//plotWIdth == size of plot, yScale == scale at which errors are shown

String[] method_reducedSet = {"dummy", "LINEAR", "GAUSSIAN", "CUBIC", "PARABOLIC", "BLAIS_RIOUX", "COM", "MICROCHIP"};
//plot all lines
void plotResiduals(float[][] positions, int plotWidth, int yScale) {
  float spacing = plotWidth / 68;
  float absAverage;

  // stroke(100, 120);
  line(positions[0][1]*spacing, 0, positions[0][69]*spacing, 0); //centreLine

  for (int z = 0; z < positions[0].length-1; z++) {
    if (positions[0][z] < 69) {

      //   stroke(60);
      line(positions[0][z]*spacing, positions[2][z]*spacing*yScale, positions[0][z+1]*spacing, positions[2][z+1]*spacing*yScale);
    }
  }

  absAverage = meanAbs(positions[2]);
  text(absAverage, positions[0][1]*spacing+5, -20);
}





//plot position mean + 95CI
float plotResidualsSummary(float[][] positions, int plotWidth, float yScale) {
  float spacing = plotWidth / 68;
  float absAverage;


  // 0 - 69, 0 - 11
  float[][] translatedPositions = new float[70][11];

  for (int z = 0; z < positions[0].length; z++) {
    translatedPositions[ int(positions[0][z]) ][ int(positions[1][z]) ] = positions[2][z];
  }



  for (int z = 3; z < translatedPositions.length-20; z++) { //change number of measurs to plot here (z==starting position, length -- ending position

    ellipse(z*spacing, mean(translatedPositions[z])*spacing*yScale, 2, 2);
    if (z<translatedPositions.length-7) {
      line(z*spacing, mean(translatedPositions[z])*spacing*yScale, (z+1)*spacing, mean(translatedPositions[z+1])*spacing*yScale);
    }
    // line(z*spacing, mean(translatedPositions[z])*spacing*yScale+confidenceInterval(translatedPositions[z], 1.96)*spacing*yScale, (z)*spacing, mean(translatedPositions[z])*spacing*yScale-confidenceInterval(translatedPositions[z], 1.96)*spacing*yScale);
  }

  for (int z = 3; z < translatedPositions.length-19; z++) { //change number of measurs to plot here (z==starting position, length -- ending position
    noStroke();
    rect(z*spacing-spacing*0.4, mean(translatedPositions[z])*spacing*yScale - confidenceInterval(translatedPositions[z], 1.96)*spacing*yScale, spacing*0.8, 2*confidenceInterval(translatedPositions[z], 1.96)*spacing*yScale);
  }

  fill(120, 120);
  absAverage = meanAbs(positions[2]);
  stroke(200, 120);
  strokeWeight(0.5);
  line(positions[0][1]*spacing, 0, positions[0][63]*spacing, 0); //centreLine
  return absAverage;
  // text(absAverage, positions[0][1]*spacing+5, -20);
}







//plot position mean + 95CI for all methods (change index of m to include naive)
void plotAllMethods(int sensor) {
  fill(100);
  text("Digit Width: " + textileSensors[sensor].spikeWidth + "% Digit Length: " + textileSensors[sensor].spikeRatio + "% Touch Size: " + int(textileSensors[sensor].pointSize/2.5*100) +"%", -35, -65);
  fill(130);
  text("(Percentage refers to Mean of Absolute Errors for Strong and Gentle pressure)", -35, -50);
  pushMatrix();
  for (int m = 1; m < method_reducedSet.length; m++) {
    float[][] positions = textileSensors[sensor].returnPeaks(method_reducedSet[m], 1); 

    fill(28*m, 190, 255-(32*m), 80);
    stroke( 28*m, 190, 255-(32*m));
    strokeWeight(2);
    float error = plotResidualsSummary(positions, 600, 1);

   // fill(28*m, 190, 255-(32*m));
   fill(130);
    if (method_reducedSet[m].equals("MICROCHIP")) { //correctName
      text("mTOUCH", -34, -27);//correctName
    }//correctName 
    else {

    text(method_reducedSet[m], -34, -27);
    }
    fill(28*m, 190, 255-(32*m));
   // text("Mean of abs(Error)", -34, -28);
    text("Strong: ", -34, -13);
    text(nf((error/25*100), 1, 2) + "%", -34, 0);


  // text("Mean of abs(Error)", -34, -28);
    text("Strong: ", -34, -13);
    text(nf((error/25*100), 1, 2) + "%", -34, 0);

    //double, cause it looks nicer

    translate(0, 100);
    fill(255);
  }

  popMatrix();
  pushMatrix();
  for (int m = 1; m < method_reducedSet.length; m++) {
    float[][] positions = textileSensors[sensor].returnPeaks(method_reducedSet[m], 0);
    fill(31*m, 220, 255-(29*m), 80);
    stroke( 31*m, 220, 255-(29*m));
    strokeWeight(2);


    float error = plotResidualsSummary(positions, 600, 1);

    fill(31*m, 220, 255-(29*m));
    text("Gentle: ", -34, 15); 
    text(nf((error/25*100), 1, 2) + "%", -34, 27); //double, cause it looks nicer
    text("Gentle: ", -34, 15); 
    text(nf((error/25*100), 1, 2) + "%", -34, 27); //double, cause it looks nicer

    translate(0, 100);
    fill(255);
  }
  popMatrix();
}