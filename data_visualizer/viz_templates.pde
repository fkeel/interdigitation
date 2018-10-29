void exampleTemplate() {
  pushMatrix();
  //draw some graphs
  for (int i = 0; i < fileNames.length; i++) {            //loop through all the files and grab the data of the ones we want
    if (textileSensors[i].spikeWidthIs(35)) {             //filter according to spikeWidth
      if (textileSensors[i].spikeRatioIs(100)) {          //filter according to ratio
        if (textileSensors[i].pointSizeIs(1.25)) {        //filter according to point szie
          //  textileSensors[i].drawStripConfidence(0, 3, 1.96, "BLOCKS", 400);


          /*
          // example of drawing all measures of a strip
           for (int strip = 0; strip < 7; strip++) {
           textileSensors[i].drawStripData(1, strip, 1100, 400);
           }
           */

          /*
             // example of drawing all measures of a strip, but one swipe at a time --> they now have different colours
           for (int y = 0; y < 11; y++) {
           stroke(23*y, 180, 255-(23*y));
           fill(23*y, 180, 255-(23*y), 80);
           strokeWeight(1.5);
           textileSensors[i].drawStripAtY(0, y, 3, 1100, 400);
           }
           */

          /*
          //example of drawing the average readings for one strip
           textileSensors[i].drawStripAverage(1, 3, 1100, 400);
           */


          //example of drawing the average and the corresponding 95% CI's
          noStroke();
          textileSensors[i].drawStripConfidence(1, 2, 1.96, "BLOCKS", 1100, 400);
          stroke(200);
          textileSensors[i].drawStripAverage(1, 2, 1100, 400);


          /*
            // textileSensors[i].drawStripDelta(1, 2, 1100, 400);
           textileSensors[i].drawStripDelta(1, 3, 1100, 400);
           // textileSensors[i].drawStripDelta(1, 4, 1100, 300);
           */
        }
      }
    }
  }
  popMatrix();
}


void lowVSHighPressure() {
  text("Strips 2, 3 & 4, No Interdigitation", 0, -6); //name of graph
  pushMatrix();
  rotate(radians(270));
  text("High Pressure", -210, -6);
  text("Low Pressure", -90, -6); //name of graph
  popMatrix();
  drawLegend(500, 100); //alternatively drawAbsLegend(ratio) for normalized data



  // pressure comparison
  for (int i = 0; i < fileNames.length; i++) {            //loop through all the files and grab the data of the ones we want
    if (textileSensors[i].spikeWidthIs(100)) {             //filter according to spikeWidth
      if (textileSensors[i].spikeRatioIs(0)) {          //filter according to ratio
        if (textileSensors[i].pointSizeIs(2.5)) {

          //draw the CIs
          for (int strip = 0; strip < 6; strip++) {
            fill(50*strip, 200, 255-(60*(strip)), 120);
            noStroke();
            textileSensors[i].drawStripConfidence(1, strip, 1.96, "BLOCKS", 500, 100);
          }
          //draw the averages 
          for (int strip = 0; strip < 6; strip++) {
            stroke(50*strip, 200, 255-(60*(strip)));
            strokeWeight(1.5);
            textileSensors[i].drawStripAverage(1, strip, 500, 100);
          }
        }
      }
    }
  }

  translate(0, 124);
  drawLegend(500, 100);
  for (int i = 0; i < fileNames.length; i++) {            //loop through all the files and grab the data of the ones we want
    if (textileSensors[i].spikeWidthIs(100)) {             //filter according to spikeWidth
      if (textileSensors[i].spikeRatioIs(0)) {          //filter according to ratio
        if (textileSensors[i].pointSizeIs(2.5)) {

          //draw the CIs
          for (int strip = 0; strip < 6; strip++) {
            fill(50*strip, 200, 255-(60*(strip)), 120);
            noStroke();
            textileSensors[i].drawStripConfidence(0, strip, 1.96, "BLOCKS", 500, 100);
          }
          //draw the averages 
          for (int strip = 0; strip < 6; strip++) {
            stroke(50*strip, 200, 255-(60*(strip)));
            strokeWeight(1.5);
            textileSensors[i].drawStripAverage(0, strip, 500, 100);
          }
        }
      }
    }
  }
}

void digitWidthComparisons() {

  text("Strips 1 - 6, Digit Width Comparison", 0, -6); //name of graph
  pushMatrix();
  rotate(radians(270));
  text("35%", -60, -6); //name of graph
  popMatrix();

  drawLegend(500, 100); //alternatively drawAbsLegend(ratio) for normalized data

  // pressure comparison
  for (int i = 0; i < fileNames.length; i++) {            //loop through all the files and grab the data of the ones we want
    if (textileSensors[i].spikeWidthIs(35)) {             //filter according to spikeWidth
      if (textileSensors[i].spikeRatioIs(100)) {          //filter according to ratio
        if (textileSensors[i].pointSizeIs(3.75)) {

          //draw the CIs
          for (int strip = 0; strip < 7; strip++) {
            fill(50*strip, 200, 255-(60*(strip)), 120);
            noStroke();
            textileSensors[i].drawStripConfidence(1, strip, 1.96, "BLOCKS", 500, 100);
          }
          //draw the averages 
          for (int strip = 0; strip < 7; strip++) {
            stroke(50*strip, 200, 255-(60*(strip)));
            strokeWeight(1.5);
            textileSensors[i].drawStripAverage(1, strip, 500, 100);
          }
        }
      }
    }
  }

  translate (0, 120);

  drawLegend(500, 100);

  pushMatrix();
  rotate(radians(270));

  text("55%", -60, -6); //name of graph
  popMatrix();
  //alternatively drawAbsLegend(ratio) for normalized data

  // pressure comparison
  for (int i = 0; i < fileNames.length; i++) {            //loop through all the files and grab the data of the ones we want
    if (textileSensors[i].spikeWidthIs(55)) {             //filter according to spikeWidth
      if (textileSensors[i].spikeRatioIs(100)) {          //filter according to ratio
        if (textileSensors[i].pointSizeIs(3.75)) {

          //draw the CIs
          for (int strip = 0; strip < 7; strip++) {
            fill(50*strip, 200, 255-(60*(strip)), 120);
            noStroke();
            textileSensors[i].drawStripConfidence(1, strip, 1.96, "BLOCKS", 500, 100);
          }
          //draw the averages 
          for (int strip = 0; strip < 7; strip++) {
            stroke(50*strip, 200, 255-(60*(strip)));
            strokeWeight(1.5);
            textileSensors[i].drawStripAverage(1, strip, 500, 100);
          }
        }
      }
    }
  }

  translate (0, 120);
  drawLegend(500, 100); //alternatively drawAbsLegend(ratio) for normalized data
  pushMatrix();
  rotate(radians(270));

  text("75%", -60, -6); //name of graph
  popMatrix();


  // pressure comparison
  for (int i = 0; i < fileNames.length; i++) {            //loop through all the files and grab the data of the ones we want
    if (textileSensors[i].spikeWidthIs(75)) {             //filter according to spikeWidth
      if (textileSensors[i].spikeRatioIs(100)) {          //filter according to ratio
        if (textileSensors[i].pointSizeIs(3.75)) {

          //draw the CIs
          for (int strip = 0; strip < 7; strip++) {
            fill(50*strip, 200, 255-(60*(strip)), 120);
            noStroke();
            textileSensors[i].drawStripConfidence(1, strip, 1.96, "BLOCKS", 500, 100);
          }
          //draw the averages 
          for (int strip = 0; strip < 7; strip++) {
            stroke(50*strip, 200, 255-(60*(strip)));
            strokeWeight(1.5);
            textileSensors[i].drawStripAverage(1, strip, 500, 100);
          }
        }
      }
    }
  }

  translate (0, 120);
  drawLegend(500, 100); //alternatively drawAbsLegend(ratio) for normalized data
  pushMatrix();
  rotate(radians(270));

  text("95%", -60, -6); //name of graph
  popMatrix();


  // pressure comparison
  for (int i = 0; i < fileNames.length; i++) {            //loop through all the files and grab the data of the ones we want
    if (textileSensors[i].spikeWidthIs(95)) {             //filter according to spikeWidth
      if (textileSensors[i].spikeRatioIs(100)) {          //filter according to ratio
        if (textileSensors[i].pointSizeIs(3.75)) {

          //draw the CIs
          for (int strip = 0; strip < 7; strip++) {
            fill(50*strip, 200, 255-(60*(strip)), 120);
            noStroke();
            textileSensors[i].drawStripConfidence(1, strip, 1.96, "BLOCKS", 500, 100);
          }
          //draw the averages 
          for (int strip = 0; strip < 7; strip++) {
            stroke(50*strip, 200, 255-(60*(strip)));
            strokeWeight(1.5);
            textileSensors[i].drawStripAverage(1, strip, 500, 100);
          }
        }
      }
    }
  }
}
void touchSizes() {
   int graphWidth = 750;
  int graphHeight = 40;
  int spacing = 60;

  text("Strips 1 - 5, No Interdigitation", 0, -6); //name of graph

  pushMatrix();
  rotate(radians(270));
  text("Small  ", -45, -6); //name of graph
  popMatrix();
  drawLegend(graphWidth, graphHeight); //alternatively drawAbsLegend(ratio) for normalized data

  for (int i = 0; i < fileNames.length; i++) {            //loop through all the files and grab the data of the ones we want
    if (textileSensors[i].spikeWidthIs(100)) {             //filter according to spikeWidth
      if (textileSensors[i].spikeRatioIs(00)) {          //filter according to ratio
        if (textileSensors[i].pointSizeIs(1.25)) {
          for (int strip = 0; strip < 5; strip++) {
            fill(50*strip, 200, 255-(60*(strip)), 120);
            stroke(50*strip, 200, 255-(60*(strip)));
            strokeWeight(1.5);
            textileSensors[i].drawStripDelta(1, strip, graphWidth, graphHeight);
          }
        }
      }
    }
  }

  translate(0, spacing);

  drawLegend(graphWidth,graphHeight);
  pushMatrix();
  rotate(radians(270));
  text("Medium  ", -45, -6);
  popMatrix();

  for (int i = 0; i < fileNames.length; i++) {            //loop through all the files and grab the data of the ones we want
    if (textileSensors[i].spikeWidthIs(100)) {             //filter according to spikeWidth
      if (textileSensors[i].spikeRatioIs(00)) {          //filter according to ratio
        if (textileSensors[i].pointSizeIs(2.5)) {
          for (int strip = 0; strip < 5; strip++) {
            fill(50*strip, 200, 255-(60*(strip)), 120);
            stroke(50*strip, 200, 255-(60*(strip)));
            strokeWeight(1.5);
            textileSensors[i].drawStripDelta(1, strip, graphWidth, graphHeight);
          }
        }
      }
    }
  }

  translate(0, spacing);

  drawLegend(graphWidth, graphHeight);
  pushMatrix();
  rotate(radians(270));
  text("Large  ", -45, -6);
  popMatrix();

  for (int i = 0; i < fileNames.length; i++) {            //loop through all the files and grab the data of the ones we want
    if (textileSensors[i].spikeWidthIs(100)) {             //filter according to spikeWidth
      if (textileSensors[i].spikeRatioIs(00)) {          //filter according to ratio
        if (textileSensors[i].pointSizeIs(3.75)) {

          for (int strip = 0; strip < 5; strip++) {
            fill(50*strip, 200, 255-(60*(strip)), 120);
            stroke(50*strip, 200, 255-(60*(strip)));
            strokeWeight(1.5);
            textileSensors[i].drawStripDelta(1, strip, graphWidth, graphHeight);
          }
        }
      }
    }
  }
}

void comparisonDigitLengths() {
  int graphWidth = 750;
  int graphHeight = 40;
  int spacing = 60;
  text("Strips 1 - 6, Comparison of Digit Lengths", 0, -6); //name of graph

  pushMatrix();
  rotate(radians(270));
  text("None  ", -35, -6); //name of graph
  popMatrix();
  drawLegend(graphWidth, graphHeight); //alternatively drawAbsLegend(ratio) for normalized data

  for (int i = 0; i < fileNames.length; i++) {            //loop through all the files and grab the data of the ones we want
    if (textileSensors[i].spikeWidthIs(100)) {             //filter according to spikeWidth
      if (textileSensors[i].spikeRatioIs(00)) {          //filter according to ratio
        if (textileSensors[i].pointSizeIs(3.75)) {
          for (int strip = 0; strip < 5; strip++) {
            fill(50*strip, 200, 255-(60*(strip)), 120);
            stroke(50*strip, 200, 255-(60*(strip)));
            strokeWeight(1.5);
            textileSensors[i].drawStripDelta(1, strip, graphWidth, graphHeight);
          }
        }
      }
    }
  }

  translate(0, spacing);

  drawLegend(graphWidth, graphHeight);
  pushMatrix();
  rotate(radians(270));
  text("55%  ", -35, -6);
  popMatrix();

  for (int i = 0; i < fileNames.length; i++) {            //loop through all the files and grab the data of the ones we want
    if (textileSensors[i].spikeWidthIs(35)) {             //filter according to spikeWidth
      if (textileSensors[i].spikeRatioIs(55)) {          //filter according to ratio
        if (textileSensors[i].pointSizeIs(3.75)) {
          for (int strip = 0; strip < 6; strip++) {
            fill(50*strip, 200, 255-(60*(strip)), 120);
            stroke(50*strip, 200, 255-(60*(strip)));
            strokeWeight(1.5);
            textileSensors[i].drawStripDelta(1, strip, graphWidth, graphHeight);
          }
        }
      }
    }
  }

  translate(0, spacing);

  drawLegend(graphWidth, graphHeight);
  pushMatrix();
  rotate(radians(270));
  text("70%  ", -35, -6);
  popMatrix();

  for (int i = 0; i < fileNames.length; i++) {            //loop through all the files and grab the data of the ones we want
    if (textileSensors[i].spikeWidthIs(35)) {             //filter according to spikeWidth
      if (textileSensors[i].spikeRatioIs(70)) {          //filter according to ratio
        if (textileSensors[i].pointSizeIs(3.75)) {

          for (int strip = 0; strip < 6; strip++) {
            fill(50*strip, 200, 255-(60*(strip)), 120);
            stroke(50*strip, 200, 255-(60*(strip)));
            strokeWeight(1.5);
            textileSensors[i].drawStripDelta(1, strip, graphWidth, graphHeight);
          }
        }
      }
    }
  }

  translate(0, spacing);

  drawLegend(graphWidth, graphHeight);
  pushMatrix();
  rotate(radians(270));
  text("85%  ", -35, -6);
  popMatrix();

  for (int i = 0; i < fileNames.length; i++) {            //loop through all the files and grab the data of the ones we want
    if (textileSensors[i].spikeWidthIs(35)) {             //filter according to spikeWidth
      if (textileSensors[i].spikeRatioIs(85)) {          //filter according to ratio
        if (textileSensors[i].pointSizeIs(3.75)) {

          for (int strip = 0; strip < 6; strip++) {
            fill(50*strip, 200, 255-(60*(strip)), 120);
            stroke(50*strip, 200, 255-(60*(strip)));
            strokeWeight(1.5);
            textileSensors[i].drawStripDelta(1, strip, graphWidth,graphHeight);
          }
        }
      }
    }
  }

  translate(0, spacing);

  drawLegend(graphWidth, graphHeight);
  pushMatrix();
  rotate(radians(270));
  text("100%  ", -40, -6);
  popMatrix();

  for (int i = 0; i < fileNames.length; i++) {            //loop through all the files and grab the data of the ones we want
    if (textileSensors[i].spikeWidthIs(35)) {             //filter according to spikeWidth
      if (textileSensors[i].spikeRatioIs(100)) {          //filter according to ratio
        if (textileSensors[i].pointSizeIs(3.75)) {

          for (int strip = 0; strip < 6; strip++) {
            fill(50*strip, 200, 255-(60*(strip)), 120);
            stroke(50*strip, 200, 255-(60*(strip)));
            strokeWeight(1.5);
            textileSensors[i].drawStripDelta(1, strip, graphWidth, graphHeight);
          }
        }
      }
    }
  }
}





void vizTestTemplate(float ratio) {

  fill(120);
  translate( 0, 20);
  text("Digit Width: 35%,  Touch Size: 375%", 750, -4); //name of graph
  // drawLegend(ratio); //alternatively drawAbsLegend(ratio) for normalized data

  pushMatrix();
  //draw some graphs
  for (int i = 0; i < fileNames.length; i++) {            //loop through all the files and grab the data of the ones we want
    if (textileSensors[i].spikeWidthIs(35)) {             //filter according to spikeWidth
      if (textileSensors[i].spikeRatioIs(55)) {          //filter according to ratio
        if (textileSensors[i].pointSizeIs(3.75)) {        //filter according to point szie
          for (int x = 0; x < 7; x++) {
            if (x<6) {
              stroke(52*x, 180, 255-(52*x));
              fill(52*x, 180, 255-(52*x), 80);
              strokeWeight(1);
              //   textileSensors[i].drawStripConfidence(1, x, 1.98, "BLOCKS", ratio);


              //  noStroke();
              stroke(52*x, 180, 255-(52*x));
              strokeWeight(0.5);
              //     textileSensors[i].drawStripData(1, x, ratio);// update to add x dimension
              strokeWeight(2);
              fill(52*x, 180, 255-(52*x), 80);
              stroke(52*x, 180, 255-(52*x));
              //   textileSensors[i].drawStripDelta(1, x, ratio);
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
  //drawLegend(ratio); //draw the legend (only correct units for measures, needs to be fixed to work with deltas


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
              // textileSensors[i].drawStripConfidence(1, x, 1.98, "BLOCKS", ratio);


              //  noStroke();
              stroke(52*x, 180, 255-(52*x));
              strokeWeight(0.5);
              //  textileSensors[i].drawStripData(1, x, ratio);
              strokeWeight(2);
              stroke(52*x, 180, 255-(52*x));
              //       textileSensors[i].drawStripAverage(1, x, ratio);
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
  //drawLegend(ratio); //draw the legend (only correct units for measures, needs to be fixed to work with deltas

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
              //    textileSensors[i].drawStripConfidence(1, x, 1.98, "BLOCKS", ratio);


              //  noStroke();
              stroke(52*x, 180, 255-(52*x));
              strokeWeight(0.5);
              //  textileSensors[i].drawStripData(1, x, ratio);
              strokeWeight(2);
              stroke(52*x, 180, 255-(52*x));
              //    textileSensors[i].drawStripAverage(1, x, ratio);
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
  //drawLegend(ratio); //draw the legend (only correct units for measures, needs to be fixed to work with deltas
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
              //    textileSensors[i].drawStripConfidence(1, x, 1.98, "BLOCKS", ratio);


              //  noStroke();
              stroke(52*x, 180, 255-(52*x));
              strokeWeight(0.5);
              //     textileSensors[i].drawStripData(1, x, ratio);
              strokeWeight(2);
              stroke(52*x, 180, 255-(52*x));
              //   textileSensors[i].drawStripAverage(1, x, ratio);
              fill(52*x, 180, 255-(52*x), 80);
              stroke(52*x, 180, 255-(52*x));
              //    textileSensors[i].drawStripDelta(1, x, ratio);
            }
          }
        }
      }
    }
  }
  popMatrix();
}