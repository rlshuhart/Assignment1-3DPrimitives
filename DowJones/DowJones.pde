// Dow Jones 
// https://processing.org/reference/loadTable_.html
// https://processing.org/tutorials/data/
// https://processing.org/tutorials/text/
// http://learningprocessing.com/examples/chp17/example-17-03-scrollingtext

// TODO
// fix balloon
// Shift to classes
// Move to eclipse


// initial variables, table and arrays
Table Dow;
int currentRowCount = 0;
int row;
String[] Date;
float[] Close;
float[] priceChange;
float[] pctChange;
PImage wall;
float size;

float minClose;
float maxClose;

float[] reverseClose; // Shortcut so I don't have to adjust code for reversing the close price order

// ticker
PFont f;  
float x; // Horizontal location
int index = 0;
String[] ticker;

void setup() {
  // create 3D canvas 
  size(800,600, P3D);
  wall = loadImage("wall.jpg");
  frameRate(8);
  
  // load data from Yahoo
  //Dow = loadTable("http://chart.finance.yahoo.com/table.csv?s=^DJI&a=0&b=01&c=2016&d=0&e=12&f=2017&g=d&ignore=.csv", "header");
  Dow = loadTable("./data/table.csv", "header"); // Ryan's work around of proxy  
  // initial currentRowCount variable with the number of rows
  currentRowCount = Dow.getRowCount();
  // initial Date and Close arrays with the number of rows
  Date = new String[Dow.getRowCount()];
  Close = new float[Dow.getRowCount()];
  ticker = new String[Dow.getRowCount()];

 // Reverse order of close so it will go from past to present
  Close = reverse(Close);

  
  // iterate through the rows of the table and move the values to the arrays
  for (int row=0; row < currentRowCount; row++){
     Date[row] = Dow.getString(row, 0);
     Close[row] = Dow.getFloat(row, 6);
     ticker[row] = Date[row] + " ended with a close of "+ Close[row];
     //println(ticker[row]);
  }
  
  // Find close change
  priceChange = new float[Close.length];
  pctChange = new float[Close.length];
  
  for (int i = 1; i < Close.length; i++){
      priceChange[i] = (Close[i-1] - Close[i]);
      pctChange[i] = (Close[i-1] - Close[i])/Close[i] * 100;
      println(Close[i-1] + " change from " + Close[i] + " equals " + nfc(pctChange[i],2) + "%");
  }
  
  // Reverse order of ticker so it scroll past to present
  ticker = reverse(ticker);
  priceChange = reverse(priceChange);
  pctChange = reverse(pctChange);
  reverseClose = reverse(Close);
  
  //ticker
  f = createFont("Arial Bold",22,true); // STEP 2 Create Font
  // Initialize ticker offscreen
  x = width;
  
  // Get min and max to scale price between 0 to 1
  minClose = min(Close);
  maxClose = 20000;  //20,000 is the fixed max for now
}

void draw() {
  // create background color
  //background(200);
   image(wall, 0, 0);
  // Draw Text
    fill(0);
    
    // Display headline at x location
    textFont(f);
    textAlign (LEFT);
    // A specific String from the array is displayed according to the value of the "index" variable.
    if (index==0){
    text(ticker[index], x, height-20);     
    } else {
      if (priceChange[index-1] < 0){
        fill(255,0,0);
      } else {
        fill(0,255,0);
      }
      text(ticker[index] + " " + nfc(priceChange[index-1], 2) + " (" + nfc(pctChange[index-1],2) + "%)", x, height-20);     
    }
    
    
    // Decrement x
    x = x - 5;
  
    // If x is less than the negative width, then it is off the screen
    // textWidth() is used to calculate the width of the current String.
    float w = textWidth(ticker[index]); 
    if (x < -w) {
      x = width;
      // index is incremented when the current String has left the screen in order to display a new String.
      index = (index + 1) % ticker.length;
    }

  // Sphere stroke, sphere, translation and rotation. 
  // control sphere, or balloon, size by the close value
    stroke(255, 50);
    //translate(250,row + 200, row + 10);
    translate(250,250);
    //rotateX(row + 100);
    //rotateY(row + 50);
    fill(54,95,152);
    //sphereDetail(row / 4);
    //sphere(Close[row]/150);
    println(reverseClose[row] + " row: " + row);
    sphere(((reverseClose[row]-minClose)/(maxClose-minClose))*100);
 // Balloon String 
    //noFill();
    //fill(0,0,0);
    //stroke(0, 0, 0);
    //bezier(250, 250, 10, 10, 50, 50, 10, 20);
    stroke(0);    
    line(0, 0, 0, ((reverseClose[row]-minClose)/(maxClose-minClose))*500);
    
    row = (row % (reverseClose.length - 1)) + 1; // keeps looping through the data
    
}


//void keyPressed(){
//  // Move down a position in the array with each key click
//  // 
//  if (row < ticker.length - 1){
//    row++;
//  }
//  else {
//    row = 0;
//  }
//   //println(Date[row] + " ended with a close of "+ Close[row]);
//  }