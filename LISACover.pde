/*  Import
 _________________________________________________________________ */

import pbox2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import geomerative.*;

/*  Arrays Generated by Shape Extractor
 _________________________________________________________________ */

float[][] top = {
{0.17567584,0.30974442},
{0.13989526,0.30617058},
{0.107138745,0.2954489},
{0.07740621,0.27757952},
{0.053573534,0.25547042},
{0.034041684,0.22598554},
{0.023469456,0.19379666},
{0.02077305,0.16093518},
{0.024196444,0.12580772},
{0.033969894,0.09284442},
{0.050919324,0.0625468},
{0.07386157,0.037227552},
{0.101645544,0.017625168},
{0.13435034,0.004861433},
{0.16925056,0.0},
{0.20187989,0.0019468216},
{0.23416558,0.011273116},
{0.26397222,0.029029366},
{0.28778672,0.052463833},
{0.3073101,0.081308275},
{0.32069334,0.1142542},
{0.32682112,0.1485561},
{0.32672086,0.18035452},
{0.31960088,0.21443969},
{0.3040507,0.2457961},
{0.2825805,0.2706962},
{0.2540926,0.29124442},
{0.22122766,0.3042055},
{0.18725617,0.3094217},
{0.17567584,0.30974442},
};

float[][] bottom = {
{0.14721991,0.42989165},
{0.18254222,0.43366918},
{0.21517597,0.44440326},
{0.24527727,0.46122363},
{0.2729959,0.48329622},
{0.295736,0.50747937},
{0.31414863,0.5358687},
{0.3280704,0.5685186},
{0.33691204,0.6023195},
{0.3416652,0.63633054},
{0.34324595,0.671517},
{0.34198546,0.70369714},
{0.33707246,0.7387444},
{0.32845446,0.77193916},
{0.31551173,0.8046022},
{0.29853487,0.8352481},
{0.27847996,0.8627244},
{0.2547202,0.8883483},
{0.23001617,0.9103556},
{0.20246497,0.9311462},
{0.1731511,0.94967055},
{0.1420746,0.9659287},
{0.10923539,0.97992045},
{0.076174594,0.9911833},
{0.043112125,1.0},
{0.011875163,0.9950333},
{0.0,0.9652188},
{0.017267251,0.9397532},
{0.049118515,0.92521983},
{0.078993596,0.9079198},
{0.10689258,0.88785344},
{0.1318402,0.86592853},
{0.15413459,0.83937323},
{0.17034872,0.80787027},
{0.1779491,0.7751993},
{0.17789277,0.7420794},
{0.16833954,0.70758396},
{0.14938398,0.68005204},
{0.120862044,0.65814734},
{0.0890201,0.6439263},
{0.05872938,0.63376725},
{0.030638281,0.6133191},
{0.014926338,0.58309793},
{0.011299023,0.5500086},
{0.016766435,0.5157299},
{0.032402713,0.48472783},
{0.055426653,0.4607556},
{0.084378995,0.44277772},
{0.11871012,0.43225834},
{0.14721991,0.42989165},
};

/*  Properties
 _________________________________________________________________ */

Grid grid;
PGraphics canvas;
int canvas_width = 5100;
int canvas_height = 6600;

int symbolType;
float symbolSize;
float spawnRatio;

boolean fall = true;
boolean updatePhysics = true;
boolean showGuides = true;

PGraphics test;
float testScale = 0.12;

float ratioWidth = 1;
float ratioHeight = 1;
float ratio = 1;

PBox2D box2d;
CircleBoundary tri;
ArrayList<Boundary> boundaries;
ArrayList<Symbol> symbols;

RFont font;

float boundarySize;

HSBColor bgColor = new HSBColor(0, 0, 255);
HSBColor symbolColor = new HSBColor(0, 0, 10);

/*  Setup
 _________________________________________________________________ */

void setup()
{ 
  size(1300, 850);
  background(30);
  
  RG.init(this);
  font = new RFont("Colfax-Medium.ttf", 335, RFont.LEFT);

  symbolType = floor(random(3));
  symbolSize = round(random(50, 200));
  spawnRatio = (1.1 - (symbolSize / 200)) * 0.8;

  canvas = createGraphics(canvas_width, canvas_height);
  test = createGraphics(round(canvas_width * testScale), round(canvas_height * testScale));
  
  grid = new Grid(12, 350);

  box2d = new PBox2D(this);
  box2d.createWorld();
  box2d.setGravity(0, -40);

  symbols = new ArrayList<Symbol>();
  boundaries = new ArrayList<Boundary>();

  boundarySize = canvas.height * 0.4;
  boundaries.add(new Boundary((canvas.width/2) - (boundarySize * 0.18), (canvas.height/2) - (boundarySize * 0.65), bottom, boundarySize));
  boundaries.add(new Boundary((canvas.width/2) - (boundarySize * 0.18), (canvas.height/2) - (boundarySize * 0.65), top, boundarySize));
  
  tri = new CircleBoundary(canvas.width/2, canvas.height/2);
}

/*  Draw
 _________________________________________________________________ */

void draw()
{
  background(30);

  if (updatePhysics)
  {
    box2d.step();
    if(random(1) < spawnRatio && fall) 
    {
      Symbol s = new Symbol(canvas.width/2, 0, symbolSize, symbolType);
      symbols.add(s);
    }
  }

  drawCanvas(test, testScale);

  // Delete symbols that go off screen
  for (int i = symbols.size()-1; i >= 0; i--) 
  {
    Symbol s = symbols.get(i);
    if (s.done(canvas)) {
      symbols.remove(i);
    }
  }
  
  image(test, 0, 0);
}

/*  Draw canvas
 _________________________________________________________________ */

void drawCanvas(PGraphics c, float scaly)
{
  c.beginDraw();
  c.colorMode(HSB, 360, 100, 100);
  if(c == test) c.smooth();
  c.background(bgColor.h, bgColor.s, bgColor.b);
  
  // draw title
  font.draw("LIBER AMICORUM", c);
  
  // Display all the symbols
  for (Symbol s: symbols) 
  {
    s.display(c, scaly);
  }
  
  if(c == test && showGuides)
  {
    tri.display(c, testScale);
    
    for (Boundary boundary: boundaries) 
    {
      boundary.display(c, scaly);
    }
    
    grid.display(c, scaly);
  }

  c.endDraw();
}

/*  Keypressed
 _________________________________________________________________ */

void keyPressed()
{ 
  // save image on s
  if (key == 's')
  {  
    drawCanvas(canvas, 1.0);
    saveCanvas();
  }

  // toggle fall on f
  if (key == 'f')
  {
    fall = !fall;
  }
  
  // toggle grid on g
  if (key == 'g')
  {
    showGuides = !showGuides;
  }

  // toggle loop on p
  if (key == 'p')
  {
    updatePhysics = !updatePhysics;
  }

  // change to random color on c
  if (key == 'c')
  {
    ColorPicker picker = new ColorPicker();

    boolean colorBackground = boolean(round(random(1)));

    HSBColor theColor = picker.getRandom();
    HSBColor theBrightness = new HSBColor(0, 0, theColor.b > 70 ? 0 : 100);

    int maxAlpha = round(random(150, 255));

    if (colorBackground)
    {
      bgColor = theColor;
      symbolColor = theBrightness;
    }
    else
    {
      bgColor = theBrightness;
      symbolColor = theColor;
    }

    draw();
  }
}

/*  Save big canvas
 _________________________________________________________________ */

void saveCanvas()
{
  println("Saving Image");
  canvas.save("render/image_" + year() + "_" + month()+ "_" + day() + "_" + hour() + "_" + minute() + "_" + second() + ".png");
  println("Saved Image");
}
