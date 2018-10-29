
//draws the legend, needs a second version for the deltas

void drawLegend(int xScale, int yScale) {
  int yLines = 4;
  int xLines = 7;

  xScale = xScale / 71 ; //maybe don't hardcode this...
  int xInterval = xScale * 10;
  yScale = yScale / yLines ;

  //draw horizontal lines
  for (int i = 0; i < yLines+1; i++) {
    strokeWeight(1);
    stroke(220);
    if (i%2!=1) {
      fill(120);
  //    text(String.format("%.1f", 1 - (i *.25)), -10, i*yScale-4);
      stroke(180);
    }
    line(0, i*yScale, 70*xScale, i*yScale);
    fill(255);
    ellipse(0, i*yScale, 5, 5);
    ellipse(xScale*70, i*yScale, 5, 5);
  }

  //draw vertical lines
  for (int i = 0; i < xLines+1; i++) {
    strokeWeight(1);
    stroke(220);
    //   fill(255);
    // ellipse(i*xInterval, yScale*5, 5, 5);
    fill(120);
    if (i%2!=0) {
      stroke(180);
      text(int(i*10)+"mm", i*xInterval-5, yScale*yLines+13);
    }
    line(i*xInterval, 0, i*xInterval, yScale*yLines);
  }
}




void drawAbsLegend(float yScale) {
  for (int i = 0; i < 6; i++) {
    strokeWeight(1);
    stroke(180);
    fill(255);
    line(-15, i*200*yScale, 71*15, i*200*yScale);
    ellipse(-15, i*200*yScale, 5, 5);
    fill(120);
    text(String.format("%.1f", 1 - (i*0.2)), -10, i*200*yScale-4);
  }

  for (int i = 1; i < 15; i++) {
    strokeWeight(1);
    stroke(180);
    fill(255);
    line(i*75, 0, i*75, 1000*yScale+15);
    ellipse(i*75, 1000*yScale+15, 5, 5);
    fill(120);
    text(int(i*10)+"mm", i*75+5, 1000*yScale+15);
  }
}