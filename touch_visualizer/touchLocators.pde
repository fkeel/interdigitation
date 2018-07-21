

//NAIVE --------------> Chose Highest Strip Value

float naive(float[] stripValues) { //returns the position with the highest value --> no interpolation

  float maxValue = 0;
  float maxIndex = 0;
  float naivePosition;

  for (int i = 0; i < stripValues.length; i++) {

    if (stripValues[i] > maxValue) {
      maxValue = stripValues[i];
      maxIndex = i;
    }
  }

  naivePosition = maxIndex+0.5;
  return naivePosition;
}


//CENTRE OF MASS --------------> Assume all strips are weights, calculate where they would balence.

float centreOfMass(float[] weights) { //takes an array of values, and calculates their centre of mass (see https://www.mathsnetalevel.com/2924)

  //Centre of Mass = weightA * positionA + weightB * positionB + weightC * positionC ... / weightA + weightB + weightC ...

  float weightLocation = 0;
  float weightSum = 0;
  float centreOfMass;

  for (int i = 0; i < weights.length; i++) {

    weightLocation = weightLocation + weights[i]*(i + 0.5); //sum of all weights multiplied by their position
    weightSum = weightSum + weights[i]; //sum of all weights
  }

  centreOfMass = weightLocation / weightSum;
  return centreOfMass;
}


//BLOB CENTRE -------------> Use Blob Tracking to detect touch-points. Use Centre of Blob for Touch Position. Interpolate and adjust threshold for precision.

float blobCentre(float[] stripValues, int interpolations, int threshold) { //returns the position with the highest value --> no interpolation


  float maxValue = 0;
  float maxIndex = 0;
  float naivePosition;

  for (int i = 0; i < stripValues.length; i++) {

    if (stripValues[i] > maxValue) {
      maxValue = stripValues[i];
      maxIndex = i;
    }
  }

  naivePosition = maxIndex+0.5;
  return naivePosition;
}


//CUBIC --------------> Use Cubic Interpolation
float cubic(float[] niceData) {
  // This function aims to retrieve finger position

  int interFactor = 400; // improves error smoothness
  int stripNumber = 7;
  float retrievedPos = -1;
  float[] y = new float[stripNumber*interFactor];




  // interpolate
  for (int s = 0; s < stripNumber; s++) { // sensor strips
    // avoid overflows
    int s0 = (s-1 < 0)? -1 : s-1;
    int s1 = s;
    int s2 = (s+1 >= stripNumber)? s : s+1;
    int s3 = (s+2 >= stripNumber)? s : s+2;

    for (int i = 0; i < interFactor; i++) { // interpolation steps
      y[i+s*interFactor] = CubicInterpolate(s0<0? 0 : niceData[s0], 
        niceData[s1], 
        niceData[s2], 
        niceData[s3], 
        float(i)/interFactor);
    }
  }

  // Find max index
  float maxArray = max(y);

  for (int i = 0; i < y.length; i++) {
    if (maxArray == y[i]) {
      retrievedPos = i;
      break;
    }
  }

  // retrievedPos *= scaling; // normalize to display
  //retrievedPos += zzUnitWidth/2;

  retrievedPos=retrievedPos/interFactor;


  return retrievedPos+0.5;
}

/////////////////////////////////////////////////////////////////
float CubicInterpolate(float y0, float y1, 
  float y2, float y3, float mu) {
  /* @article{bourke1999interpolation,
   title={Interpolation methods},
   author={Bourke, Paul},
   journal={paulbourke.net/miscellaneous/interpolation},
   year={1999} } */

  float a0, a1, a2, a3, mu2;
  mu2 = mu*mu;

  // Breeuwsma approach:
  a0 = -0.5*y0 + 1.5*y1 - 1.5*y2 + 0.5*y3;
  a1 = y0 - 2.5*y1 + 2*y2 - 0.5*y3;
  a2 = -0.5*y0 + 0.5*y2;
  a3 = y1;

  return (a0*mu*mu2 + a1*mu2 + a2*mu + a3);
}



//MICROCHIP ------> Use Method based in Microchip WhitePaper 

float microchip(float[] niceData) {
  // This function aims to retrieve finger position

  float retrievedPos = -1;

  // Find max index
  float maxArray = max(niceData);
  int maxIndex = 0;
  for (int i = 0; i < niceData.length; i++) {
    if (maxArray == niceData[i]) {
      maxIndex = i;
      break;
    }
  }

  // Retrieval method from Microchip TB3064 white paper (p12):
  // microchip.com/stellent/groups/techpub_sg/documents/devicedoc/en550192.pdf
  // Position is calculated as the centroid of 2 adjacent values:

  float prev = (maxIndex==0)?
    0 : niceData[maxIndex-1];

  float next = (maxIndex>=niceData.length-1)?
    0 : niceData[maxIndex+1];

  retrievedPos = maxIndex + 0.5 * (next - prev) / niceData[maxIndex];

  // Offset TODO?
  retrievedPos += 0.5;
 // retrievedPos *= width / stripNumber;



  return (retrievedPos);
}