
//draws the legend, needs a second version for the deltas

void drawLegend(float scale) {
  for (int i = 0; i < 6; i++) {
    strokeWeight(1);
    stroke(180);
    fill(255);
    line(-15, i*200*scale, 71*15, i*200*scale);
    ellipse(-15, i*200*scale, 5, 5);
    fill(120);
    text(1000 - int(i*200), -10, i*200*scale-4);
  }
  
    for (int i = 1; i < 15; i++) {
    strokeWeight(1);
    stroke(180);
    fill(255);
    line(i*75, 0, i*75, 1000*scale+15);
    ellipse(i*75, 1000*scale+15, 5, 5);
    fill(120);
    text(int(i*10)+"mm", i*75+5, 1000*scale+15);
  }
  
}

void drawAbsLegend(float scale) {
  for (int i = 0; i < 6; i++) {
    strokeWeight(1);
    stroke(180);
    fill(255);
    line(-15, i*200*scale, 71*15, i*200*scale);
    ellipse(-15, i*200*scale, 5, 5);
    fill(120);
    text(String.format("%.1f",1 - (i*0.2)), -10, i*200*scale-4);
  }
  
    for (int i = 1; i < 15; i++) {
    strokeWeight(1);
    stroke(180);
    fill(255);
    line(i*75, 0, i*75, 1000*scale+15);
    ellipse(i*75, 1000*scale+15, 5, 5);
    fill(120);
    text(int(i*10)+"mm", i*75+5, 1000*scale+15);
  }
  
}