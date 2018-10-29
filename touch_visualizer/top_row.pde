

void firstRow(String method) {
  
  text(method, 0, -40);

  for (int i = 0; i < fileNames.length; i++) {            //loop through all the files and grab the data of the ones we want
    if (textileSensors[i].spikeWidthIs(35) && textileSensors[i].spikeRatioIs(100)) {

      if (textileSensors[i].pointSizeIs(1.25)) {             
        float[][] positions  = textileSensors[i].returnPeaks(method, 0);

        plotResiduals(positions, 300, 1);
        positions  = textileSensors[i].returnPeaks(method, 1);
        pushMatrix();
        translate(280,0);
        plotResiduals(positions, 300, 1);
        popMatrix();
      }


      if (textileSensors[i].pointSizeIs(2.5)) {             
        float[][] positions  = textileSensors[i].returnPeaks(method, 0);

        plotResiduals(positions, 300, 1);
        positions  = textileSensors[i].returnPeaks(method, 1);
        pushMatrix();
        translate(280,0);
        plotResiduals(positions, 300, 1);
        popMatrix();
      }

      if (textileSensors[i].pointSizeIs(3.75)) {             
        float[][] positions  = textileSensors[i].returnPeaks(method, 0);

        plotResiduals(positions, 300, 1);
        positions  = textileSensors[i].returnPeaks(method, 1);
        pushMatrix();
        translate(280,0);
        plotResiduals(positions, 300, 1);
        popMatrix();
      }
      translate(0, 70);
    }
  }

  
}