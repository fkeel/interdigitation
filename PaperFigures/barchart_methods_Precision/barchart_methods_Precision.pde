import processing.pdf.*;



String[] names = {"GAUSS.", "mTOUCH", "COM", "PARABOLIC", "LINEAR", "CUBIC", "BLAIS_RIOUX", "NAIVE"};

//mean, lower bound, upper bound
float[][] values = {

  {0.962, 0.924, 1}, 
  {1.026, 0.988, 1.064}, 
  {1.066, 1.028, 1.104}, 
  {1.078, 1.04, 1.116}, 
  {1.160, 1.122, 1.198}, 
  {1.214, 1.176, 1.252}, 
  {1.359, 1.321, 1.397}, 
  {1.624, 1.586, 1.662}, 

};

//r,g,b
float[][] colors =
  {
  {22, 60, 180}, //gauss,
  {22, 200, 30}, //mchip
  {22, 120, 140}, //com
  {22, 160, 90}, //parabolic
  {22, 180, 60}, //linear
  {22, 140, 120}, //cubic
  {22, 90, 160}, //blais
  {22, 30, 200}, //naive 

};


void setup() {

  background(255);
  size(700, 500);
 // size(700, 500, PDF, "camera_2_barchart_deviations.svg");
  drawChart(names, values, colors, 600, 100, 330);
}

void drawChart(String[] names, float[][] values, float[][] colors, int chartWidth, int chartHeight, int scale) {
  fill(120);
  textSize(17);
  text("Interpolation Methods:", width/2-280, height/2-50);
  text("Precision", width/2-280, height/2-30);
  pushMatrix();

  int spacing = (chartWidth / names.length)-5;
  translate(0, 300);

  translate(spacing, height-spacing);
  textSize(13);



  //legend
  float scalar = 8;
  for (int i = 0; i < 50; i++) {
    pushMatrix();
    translate(-40, 0);
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
        text((float(i)/scalar/25)*100 +"%", chartWidth+2, i /scalar*-scale);
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
    textSize(13);
    fill(colors[i][0], colors[i][1], colors[i][2], 200);
    //main bar
    rect(i*spacing+(spacing*0.1), -values[i][0]*scale, spacing*0.5, values[i][0]*scale);


    //interval
    fill(colors[i][0], colors[i][1], colors[i][2], 100);
    noStroke();
    rect(i*spacing+spacing*0.2, -values[i][2]*scale, spacing*0.3, values[i][2]*scale-values[i][1]*scale);
    fill(colors[i][0], colors[i][1], colors[i][2], 200);

    //labels
    stroke(colors[i][0], colors[i][1], colors[i][2], 100);
    //lower bound
    text(nf(values[i][2]/25*100, 1, 2), spacing*(i-1)+spacing*0.65-1, -values[i][2]*scale+3);
    //lowerBound line
    line(spacing*i +2, -values[i][1]*scale, i*spacing+spacing*0.5-1, -values[i][1]*scale);
    //upper bound
    text(nf(values[i][1]/25*100, 1, 2), spacing*(i-1)+spacing*0.65-1, -values[i][1]*scale+3);
    line(spacing*i +2, -values[i][2]*scale, i*spacing+spacing*0.5-1, -values[i][2]*scale);
    // rect(i*spacing+spacing*0.1, spacing/4, spacing*0.6, spacing/4);
    println(colors[i][2]);
  }


  for (int i = 0; i < names.length; i++) {
    //mean
    textSize(13);
    fill(255);
    text(nf(values[i][0]/25*100, 1, 2), spacing*i+spacing*0.175, -values[i][0]*scale+12);
  }
  textSize(14);
  pushMatrix();
  for (int i = 0; i < names.length; i++) {
    fill(100);

    pushMatrix();
    translate(0, -260);
    rotate(radians(-90));
    translate(-20, -15);
    text(names[i], 0, spacing/4 );
    popMatrix();
    translate(spacing, 0);
  }
  popMatrix();

  popMatrix();
}