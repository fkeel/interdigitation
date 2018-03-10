

void vizTestTemplate(float ratio) {

  fill(120);
  translate( 0, 20);
  text("Digit Width: 35%,  Touch Size: 375%", 750, -4); //name of graph
  drawLegend(ratio); //alternatively drawAbsLegend(ratio) for normalized data

  pushMatrix();
  //draw some graphs
  for (int i = 0; i < fileNames.length; i++) {            //loop through all the files and grab the data of the ones we want
    if (textileSensors[i].spikeWidthIs(35)) {             //filter according to spikeWidth
      if (textileSensors[i].spikeRatioIs(100)) {          //filter according to ratio
        if (textileSensors[i].pointSizeIs(3.75)) {        //filter according to point szie
          for (int x = 0; x < 7; x++) {
            if (x<6) {
              stroke(52*x, 180, 255-(52*x));
              fill(52*x, 180, 255-(52*x), 80);
              strokeWeight(1);
              textileSensors[i].drawStripConfidence(1, x, 1.98, "BLOCKS", ratio);


              //  noStroke();
              stroke(52*x, 180, 255-(52*x));
              strokeWeight(0.5);
              textileSensors[i].drawStripData(1, x, ratio);
              strokeWeight(2);
              fill(52*x, 180, 255-(52*x), 80);
              stroke(52*x, 180, 255-(52*x));
              textileSensors[i].drawStripDelta(1, x, ratio);
            }
          }
        }
      }
    }
  }
  popMatrix();

  translate(0, 1000*ratio+50);
  fill(120);
  text("Digit Width: 55%,  Touch Size: 375%", 750, -4); //name of graph
  drawLegend(ratio); //draw the legend (only correct units for measures, needs to be fixed to work with deltas


  pushMatrix();
  //draw some graphs
  for (int i = 0; i < fileNames.length; i++) {            //loop through all the files and grab the data of the ones we want
    if (textileSensors[i].spikeWidthIs(55)) {             //filter according to spikeWidth
      if (textileSensors[i].spikeRatioIs(100)) {          //filter according to ratio
        if (textileSensors[i].pointSizeIs(3.75)) {        //filter according to point szie
          for (int x = 0; x < 7; x++) {
            if (x<6) {
              stroke(52*x, 180, 255-(52*x));
              fill(52*x, 180, 255-(52*x), 80);
              strokeWeight(1);
              textileSensors[i].drawStripConfidence(1, x, 1.98, "BLOCKS", ratio);


              //  noStroke();
              stroke(52*x, 180, 255-(52*x));
              strokeWeight(0.5);
              textileSensors[i].drawStripData(1, x, ratio);
              strokeWeight(2);
              stroke(52*x, 180, 255-(52*x));
              textileSensors[i].drawStripAverage(1, x, ratio);
            }
          }
        }
      }
    }
  }
  popMatrix();

  translate( 0, 1000*ratio+50);
  fill(120);
  text("Digit Width: 75%,  Touch Size: 375%", 750, -4); //name of graph
  drawLegend(ratio); //draw the legend (only correct units for measures, needs to be fixed to work with deltas

  pushMatrix();
  //draw some graphs
  for (int i = 0; i < fileNames.length; i++) {            //loop through all the files and grab the data of the ones we want
    if (textileSensors[i].spikeWidthIs(75)) {             //filter according to spikeWidth
      if (textileSensors[i].spikeRatioIs(100)) {          //filter according to ratio
        if (textileSensors[i].pointSizeIs(3.75)) {        //filter according to point szie
          for (int x = 0; x < 7; x++) {
            if (x<6) {
              stroke(52*x, 180, 255-(52*x));
              fill(52*x, 180, 255-(52*x), 80);
              strokeWeight(1);
              textileSensors[i].drawStripConfidence(1, x, 1.98, "BLOCKS", ratio);


              //  noStroke();
              stroke(52*x, 180, 255-(52*x));
              strokeWeight(0.5);
              textileSensors[i].drawStripData(1, x, ratio);
              strokeWeight(2);
              stroke(52*x, 180, 255-(52*x));
              textileSensors[i].drawStripAverage(1, x, ratio);
            }
          }
        }
      }
    }
  }
  popMatrix();

  translate( 0, 1000*ratio+50);
  fill(120);
  text("Digit Width: 95%,  Touch Size: 375%", 750, -4); //name of graph
  drawLegend(ratio); //draw the legend (only correct units for measures, needs to be fixed to work with deltas
  pushMatrix();

  //draw some graphs
  for (int i = 0; i < fileNames.length; i++) {            //loop through all the files and grab the data of the ones we want
    if (textileSensors[i].spikeWidthIs(95)) {             //filter according to spikeWidth
      if (textileSensors[i].spikeRatioIs(100)) {          //filter according to ratio
        if (textileSensors[i].pointSizeIs(3.75)) {        //filter according to point szie
          for (int x = 0; x < 7; x++) {
            if (x<6) {
              stroke(52*x, 180, 255-(52*x));
              fill(52*x, 180, 255-(52*x), 80);
              strokeWeight(1);
              textileSensors[i].drawStripConfidence(1, x, 1.98, "BLOCKS", ratio);


              //  noStroke();
              stroke(52*x, 180, 255-(52*x));
              strokeWeight(0.5);
              textileSensors[i].drawStripData(1, x, ratio);
              strokeWeight(2);
              stroke(52*x, 180, 255-(52*x));
              textileSensors[i].drawStripAverage(1, x, ratio);
              fill(52*x, 180, 255-(52*x), 80);
              stroke(52*x, 180, 255-(52*x));
              textileSensors[i].drawStripDelta(1, x, ratio);
            }
          }
        }
      }
    }
  }
  popMatrix();
}