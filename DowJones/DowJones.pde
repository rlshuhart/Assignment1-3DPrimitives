// Dow Jones 
// https://processing.org/reference/loadTable_.html
// https://processing.org/tutorials/data/
// https://processing.org/tutorials/text/
// http://learningprocessing.com/examples/chp17/example-17-03-scrollingtext

// TODO
// Add on-screen graphic
// print daily value on screen. Maybe as ticker tape?
// Shift to classes
// Move to eclipse


// initial variables, table and arrays
Table Dow;
int currentRowCount = 0;
int row;
String[] Date;
float[] Close;
PImage wall;


// ticker
PFont f;  
float x; // Horizontal location
int index = 0;

// Temporar array of ticker -- need to change to be created from data source
String[] ticker = {
"2017-01-11 ended with a close of 19954.28",
"2017-01-10 ended with a close of 19855.53",
"2017-01-09 ended with a close of 19887.38",
"2017-01-06 ended with a close of 19963.8",
"2017-01-05 ended with a close of 19899.29",
"2017-01-04 ended with a close of 19942.16",
"2017-01-03 ended with a close of 19881.76",
"2016-12-30 ended with a close of 19762.6",
"2016-12-29 ended with a close of 19819.78",
"2016-12-28 ended with a close of 19833.68",
"2016-12-27 ended with a close of 19945.04",
"2016-12-23 ended with a close of 19933.81",
"2016-12-22 ended with a close of 19918.88",
"2016-12-21 ended with a close of 19941.96",
"2016-12-20 ended with a close of 19974.62",
"2016-12-19 ended with a close of 19883.06",
"2016-12-16 ended with a close of 19843.41",
"2016-12-15 ended with a close of 19852.24",
"2016-12-14 ended with a close of 19792.53",
"2016-12-13 ended with a close of 19911.21",
"2016-12-12 ended with a close of 19796.43",
"2016-12-09 ended with a close of 19756.85",
"2016-12-08 ended with a close of 19614.81",
"2016-12-07 ended with a close of 19549.62",
"2016-12-06 ended with a close of 19251.78",
"2016-12-05 ended with a close of 19216.24",
"2016-12-02 ended with a close of 19170.42",
"2016-12-01 ended with a close of 19191.93",
"2016-11-30 ended with a close of 19123.58",
"2016-11-29 ended with a close of 19121.6",
"2016-11-28 ended with a close of 19097.9",
"2016-11-25 ended with a close of 19152.14",
"2016-11-23 ended with a close of 19083.18",
"2016-11-22 ended with a close of 19023.87",
"2016-11-21 ended with a close of 18956.69",
"2016-11-18 ended with a close of 18867.93",
"2016-11-17 ended with a close of 18903.82",
"2016-11-16 ended with a close of 18868.14",
"2016-11-15 ended with a close of 18923.06",
"2016-11-14 ended with a close of 18868.69",
"2016-11-11 ended with a close of 18847.66",
"2016-11-10 ended with a close of 18807.88",
"2016-11-09 ended with a close of 18589.69",
"2016-11-08 ended with a close of 18332.74",
"2016-11-07 ended with a close of 18259.6",
"2016-11-04 ended with a close of 17888.28",
"2016-11-03 ended with a close of 17930.67",
"2016-11-02 ended with a close of 17959.64",
"2016-11-01 ended with a close of 18037.1",
"2016-10-31 ended with a close of 18142.42",
"2016-10-28 ended with a close of 18161.19",
"2016-10-27 ended with a close of 18169.68",
"2016-10-26 ended with a close of 18199.33",
"2016-10-25 ended with a close of 18169.27",
"2016-10-24 ended with a close of 18223.03",
"2016-10-21 ended with a close of 18145.71",
"2016-10-20 ended with a close of 18162.35"
};

void setup() {
  // create 3D canvas 
  size(800,600, P3D);
  // load data from Yahoo
  Dow = loadTable("http://chart.finance.yahoo.com/table.csv?s=^DJI&a=0&b=12&c=2015&d=0&e=12&f=2017&g=d&ignore=.csv", "header"); 
  // initial currentRowCount variable with the number of rows
  currentRowCount = Dow.getRowCount();
  // initial Date and Close arrays with the number of rows
  Date = new String[Dow.getRowCount()];
  Close = new float[Dow.getRowCount()];
  wall = loadImage("wall.jpg");
  
  //ticker
  f = createFont("Arial",16,true); // STEP 2 Create Font
  // Initialize ticker offscreen
  x = width;
  
}

void draw() {
  // create background color
  //background(200);
   image(wall, 0, 0);
  // Draw Text
    fill(0);
    
    // Display headline at x location
    textFont(f, 16);
    textAlign (LEFT);
    // A specific String from the array is displayed according to the value of the "index" variable.
    text(ticker[index], x, height-20); 
    
    // Decrement x
    x = x - 3;
  
    // If x is less than the negative width, then it is off the screen
    // textWidth() is used to calculate the width of the current String.
    float w = textWidth(ticker[index]); 
    if (x < -w) {
      x = width;
      // index is incremented when the current String has left the screen in order to display a new String.
      index = (index + 1) % ticker.length;
    }

  // Sphere stroke, sphere, translation and rotation. 
    stroke(255, 50);
    translate(250,250, 0);
    rotateX(row + 100);
    rotateY(row + 50);
    fill(54,95,152);
    sphereDetail(row / 4);
    sphere(100);
    
    
    // iterate through the rows of the table and move the values to the arrays
    for (int row=1; row < currentRowCount; row++){
       Date[row] = Dow.getString(row, 0);
       Close[row] = Dow.getFloat(row, 6);
   
    }
}

void mousePressed(){
  // Move down a position in the array with each mouse click
  row++;
   println(Date[row] + " ended with a close of "+ Close[row]);
  }