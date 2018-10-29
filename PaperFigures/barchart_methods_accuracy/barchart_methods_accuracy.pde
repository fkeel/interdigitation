import processing.pdf.*;



String[] names = {"mTOUCH", "LINEAR", "PARABOLIC", "CUBIC", "COM", "BLAIS_RIOUX", "GAUSSIAN", "NAIVE"};

//mean, lower bound, upper bound
float[][] values = {
  {1.919, 1.905, 1.932}, 
  {1.926, 1.912, 1.94}, 
  {2.034, 2.02, 2.048}, 
  {2.273, 2.26, 2.287}, 
  {2.299, 2.285, 2.313}, 
  {2.774, 2.76, 2.787}, 
  {3.246, 3.233, 3.26}, 
  {6.023, 6.009, 6.037}
};

//r,g,b
float[][] colors =
  {
  {22, 200, 30}, //mchip
  {22, 180, 60}, //linear
  {22, 160, 90}, //parabolic
  {22, 140, 120}, //cubic
  {22, 120, 140}, //com
  {22, 90, 160}, //blais
  {22, 60, 180}, //gauss
  {22, 30, 200}, //naive

};


void setup() {

  background(255);
  size(700, 500);
 //// size(700, 500, PDF, "camera_3_barchart_errors.svg");
  drawChart(names, values, colors, 600, 100, 44);
}

void drawChart(String[] names, float[][] values, float[][] colors, int chartWidth, int chartHeight, int scale) {
  fill(120);
  textSize(17);
  text("Interpolation Methods:", width/2-280, height/2-50);
  text("Accuracy", width/2-280, height/2-30);
  pushMatrix();

  int spacing = (chartWidth / names.length)-5;
  translate(0, 00);

  translate(spacing, height-spacing);
  textSize(13);
  //legend
  float scalar = 2;
  for (int i = 0; i < 50; i++) {
    pushMatrix();
    translate(-40, 0);
    if (i%1 == 0) {
      stroke(200, 120);
      strokeWeight(1);
      line(0, i /scalar *-scale, chartWidth, i /scalar*-scale);

      if (i<1) { 
        stroke(120, 250);
    //    line(0, i /scalar*-scale, chartWidth, i /scalar*-scale);
      }
      if (i>0) {
        fill(120, 250);
        text(int((float(i)/scalar/25)*100) +"%", chartWidth+2, i /scalar*-scale);
      }
    } else {
      stroke(120, 120);  
      strokeWeight(0.5);
      line(0, i /scalar*-scale, chartWidth, i /scalar*-scale);
    }
    popMatrix();
  }


  //bars and confidence
  for (int i = 0; i < names.length; i++) {
    noStroke();
    textSize(15);
    fill(colors[i][0], colors[i][1], colors[i][2], 200);
    //main bar
    rect(i*spacing+(spacing*0.1), -values[i][0]*scale, spacing*0.5, values[i][0]*scale);


    //interval
    fill(colors[i][0], colors[i][1], colors[i][2], 100);
    noStroke();
    // rect(i*spacing+spacing*0.2, -values[i][2]*scale, spacing*0.3, values[i][2]*scale-values[i][1]*scale);


    fill(colors[i][0], colors[i][1], colors[i][2], 200);
    stroke(colors[i][0], colors[i][1], colors[i][2], 100);
    //lower bound
    // text(nf(values[i][2]/25*100, 1, 2), spacing*(i-1)+spacing*0.65-1, -values[i][2]*scale+3);
    //lowerBound line
    //  line(spacing*i +2, -values[i][1]*scale, i*spacing+spacing*0.5-1, -values[i][1]*scale);
    //upper bound
    // text(nf(values[i][1]/25*100, 1, 2), spacing*(i-1)+spacing*0.65-1, -values[i][1]*scale+3);
    // line(spacing*i +2, -values[i][2]*scale, i*spacing+spacing*0.5-1, -values[i][2]*scale);
    // rect(i*spacing+spacing*0.1, spacing/4, spacing*0.6, spacing/4);
  }


  for (int i = 0; i < names.length; i++) {
    //mean
    textSize(14);
    fill(120);
    text(nf(values[i][0]/25*100, 2, 2), spacing*i+spacing*0.13-5, -values[i][0]*scale-4);
  }
  textSize(14);
  pushMatrix();
  for (int i = 0; i < names.length; i++) {
    fill(100);

    pushMatrix();
    translate(0, 0);
    rotate(radians(-90));
    translate(3, -15);
    text(names[i], 0, spacing/4 );
    popMatrix();
    translate(spacing, 0);
  }
  popMatrix();

  popMatrix();
}