
String[] method = {"NAIVE", "LINEAR", "GAUSSIAN", "CUBIC", "PARABOLIC", "BLAIS_RIOUX", "COM", "MICROCHIP"};

//format: DigitWidth, DigitHeight, TouchSize, Pressure, X, Y, Method, Error

void saveResiduals() {
  float[][] positions; 
  String writeToFile = "";
  for (int i = 0; i < fileNames.length; i++) {      
    for (int m = 0; m < method.length; m++) {   //loop through all methods for low pressure
      positions = textileSensors[i].returnPeaks(method[m], 0);
      for (int z = 0; z < positions[2].length; z++) {
        writeToFile = writeToFile + textileSensors[i].spikeWidth + ", " + textileSensors[i].spikeRatio + ", " + textileSensors[i].pointSize + ", " + 0 + ", ";
        writeToFile = writeToFile + positions[0][z] + ", " + positions[1][z] + ", " + method[m] + ", " + positions[2][z] + "\r\n";
      }
    }  
    for (int m = 0; m < method.length; m++) {  //loop a second time for high pressure
      positions = textileSensors[i].returnPeaks(method[m], 1);
      for (int z = 0; z < positions[2].length; z++) {
        writeToFile = writeToFile + textileSensors[i].spikeWidth + ", " + textileSensors[i].spikeRatio + ", " + textileSensors[i].pointSize + ", " + 1 + ", ";
        writeToFile = writeToFile + positions[0][z] + ", " + positions[1][z] + ", " + method[m] + ", " + positions[2][z] + "\r\n";
      }
    }
    println("saving method");
    appendTextToFile("forAnalysis_2.csv", writeToFile);
    writeToFile = "";
  }
}


//format: DigitWidth, DigitHeight, TouchSize, Pressure, Method, Error

void saveDeviations() {
  float sd;

  float[][] positions; 
  String writeToFile = "";

  for (int i = 0; i < fileNames.length; i++) {      
    for (int m = 0; m < method.length; m++) {   //loop through all methods for low pressure
      positions = textileSensors[i].returnPeaks(method[m], 0); //low pressure

      float[][] translatedPositions = new float[70][11];

      for (int z = 0; z < positions[0].length; z++) {
        translatedPositions[int(positions[0][z]) ][ int(positions[1][z]) ] = positions[2][z];
      }

      for (int z = 0; z < translatedPositions.length; z++) {
        sd = standardDeviation(translatedPositions[z]);
        println(sd);
        writeToFile = writeToFile + textileSensors[i].spikeWidth + ", " + textileSensors[i].spikeRatio + ", " + textileSensors[i].pointSize + ", " + 0 + ", ";
        writeToFile = writeToFile + method[m] + ", " + sd + "\r\n";
      }
    }
    for (int m = 0; m < method.length; m++) {   //loop through all methods for low pressure
      positions = textileSensors[i].returnPeaks(method[m], 1); //high pressure 

      float[][] translatedPositions = new float[70][11];

      for (int z = 0; z < positions[0].length; z++) {
        translatedPositions[int(positions[0][z]) ][ int(positions[1][z]) ] = positions[2][z];
      }

      for (int z = 0; z < translatedPositions.length; z++) {
        sd = standardDeviation(translatedPositions[z]);
        writeToFile = writeToFile + textileSensors[i].spikeWidth + ", " + textileSensors[i].spikeRatio + ", " + textileSensors[i].pointSize + ", " + 1 + ", ";
        writeToFile = writeToFile + method[m] + ", " + sd + "\r\n";
      }
    }
    println("saving method");
    appendTextToFile("forAnalysis_deviations_full.csv", writeToFile);
    writeToFile = "";
  }
}