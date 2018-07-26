
//plotWIdth == size of plot, yScale == scale at which errors are shown

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
void plotResidualsSummary(float[][] positions, int plotWidth, int yScale) {
  float spacing = plotWidth / 68;
  float absAverage;
  // 0 - 69, 0 - 11
  float[][] translatedPositions = new float[70][11];

  for (int z = 0; z < positions[0].length; z++) {
    translatedPositions[ int(positions[0][z]) ][ int(positions[1][z]) ] = positions[2][z];
  }

  for (int z = 0; z < translatedPositions.length; z++) {
    print(z + " mean: ");
    print(mean(translatedPositions[z]));
    print(z + " mean: ");

      print(standardDeviation(translatedPositions[z]));
    translate(0, 10);
  }

  absAverage = meanAbs(positions[2]);
  text(absAverage, positions[0][1]*spacing+5, -20);
}