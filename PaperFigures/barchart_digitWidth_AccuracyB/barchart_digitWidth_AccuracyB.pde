import processing.pdf.*;



String[] names = {"none", "95 %", "75 %", "55 %", "35 %"};

//mean, lower bound, upper bound (deviation
float[][] values = {
  {2.814, 2.793, 2.834}, 
  {2.965, 2.955, 2.975}, 
  {2.848, 2.838, 2.859}, 
  {2.750, 2.74, 2.761}, 
  {2.683, 2.673, 2.693}, 
};

//r,g,b
float[][] colors =
  {
  {122, 30, 100}, 
  {22, 60, 180}, 
  {22, 90, 160}, 
  {22, 120, 140}, 
  {22, 140, 120}, 
  {22, 160, 90}, 
  {22, 180, 60}, 
  {22, 200, 30}
};


void setup() {

  background(255);
 // size(700, 500, PDF, "camera_digitWidth_errors.svg");
  size(700, 500);
  drawChart(names, values, colors, 500, 150, 550);
}

void drawChart(String[] names, float[][] values, float[][] colors, int chartWidth, int chartHeight, int scale) {
  pushMatrix();

  float spacing = chartWidth / names.length;

  translate(spacing, height);
  translate(0, 1350);

  //legend
  float scalar = 16;
  for (int i = 0; i < 50; i++) {
    if (i%1 == 0) {
      stroke(200, 120);
      strokeWeight(1);
      line(0, i /scalar *-scale, chartWidth, i /scalar*-scale);

      if (i<1) { 
        stroke(120, 250);
        line(0, i /scalar*-scale, chartWidth, i /scalar*-scale);
      }
      if (i>0) {
        fill(120, 250);
        textSize(15);
        text((float(i)/scalar/25)*100 +"%", chartWidth+2, i /scalar*-scale);
      }
    } else {
      stroke(120, 120);
      strokeWeight(0.5);
      line(0, i /scalar*-scale, chartWidth, i /scalar*-scale);
    }
  }
  fill(255);
  noStroke();
  rect(0.5*spacing+spacing*0.1, -chartHeight*2*scale, spacing*0.4, chartHeight*2*scale+5);
  //bars
  for (int i = 0; i < names.length; i++) {
    noStroke();
    fill(colors[i][0], colors[i][1], colors[i][2], 200);
    rect(i*spacing+(spacing*0.1), -values[i][0]*scale, spacing*0.45, values[i][0]*scale);

    textSize(15);
    //mean
    fill(255);
   text(nf(values[i][0]/25*100, 1, 2), spacing*i+spacing*0.1+1, -2.6*scale+3);

    stroke(colors[i][0], colors[i][1], colors[i][2], 100);
  //  line(i*spacing+(spacing*0.1), -values[i][0]*scale, i*spacing+(spacing*0.6), -values[i][0]*scale);

    //interval
    fill(colors[i][0], colors[i][1], colors[i][2], 100);
    noStroke();
    rect(i*spacing+spacing*0.2, -values[i][2]*scale, spacing*0.25, values[i][2]*scale-values[i][1]*scale);


    fill(colors[i][0], colors[i][1], colors[i][2], 200);
    stroke(colors[i][0], colors[i][1], colors[i][2], 100);
    //upper bound
    text(nf(values[i][2]/25*100, 2, 2), spacing*(i-1)+spacing*0.65-5, -values[i][2]*scale);
    line(spacing*i +2, -values[i][1]*scale, i*spacing+spacing*0.45-1, -values[i][1]*scale);
    //lower bound
    text(nf(values[i][1]/25*100, 2, 2), spacing*(i-1)+spacing*0.65-5, -values[i][1]*scale+8);
    line(spacing*i +2, -values[i][2]*scale, i*spacing+spacing*0.45-1, -values[i][2]*scale);
    // rect(i*spacing+spacing*0.1, spacing/4, spacing*0.6, spacing/4);
  }


  popMatrix();

  //labels
  translate(spacing, height-40);
  textSize(17);
  for (int i = -1; i < names.length; i++) {
    fill(100);

    pushMatrix();
    rotate(radians(-90));

    if (i>=0) {
      translate(0, -23);
      text(names[i], 0, spacing/4 );
    } else {
      text("Digit Width: Accuracy", 20, -spacing/2-10 );
    }
    popMatrix();
    if (i>=0) {
      translate(spacing, 0); //spacing between labels
    }
  }
}