// Dow Jones 
// https://processing.org/reference/loadTable_.html
// https://processing.org/tutorials/data/
// https://processing.org/tutorials/text/

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
PFont f;                           // STEP 1 Declare PFont variable

void setup() {
  // create 3D canvas 
  size(500,500, P3D);
  // load data from Yahoo
  Dow = loadTable("http://chart.finance.yahoo.com/table.csv?s=^DJI&a=0&b=12&c=2015&d=0&e=12&f=2017&g=d&ignore=.csv", "header"); 
  // initial currentRowCount variable with the number of rows
  currentRowCount = Dow.getRowCount();
  // initial Date and Close arrays with the number of rows
  Date = new String[Dow.getRowCount()];
  Close = new float[Dow.getRowCount()];
  
  f = createFont("Arial",16,true); // STEP 2 Create Font
  
}

void draw() {
  // create background color, stroke, sphere, translation and rotation. 
  background(200);
  stroke(255, 50);
  translate(350,250, 0);
  rotateX(row);
  rotateY(row + 100);
  fill(54,95,152);
  sphere(100);
  
  // iterate through the rows of the table and move the values to the arrays
  for (int row=1; row < currentRowCount; row++){
     Date[row] = Dow.getString(row, 0);
     Close[row] = Dow.getFloat(row, 6);
     
  //Draw Text
  textFont(f,16);                  // STEP 3 Specify font to be used
  fill(0);                         // STEP 4 Specify font color 
  text("Hello Strings!",10,100);   // STEP 5 Display Text
    
  }

}

void mousePressed(){
  // Move down a position in the array with each mouse click
  row++;
   println(Date[row] + " ended with a close of "+ Close[row]);
  }