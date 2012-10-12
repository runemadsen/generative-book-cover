class CircleBoundary 
{  
  float x;
  float y;
  float r;
  
  Body b;
  ArrayList<Vec2> surface;
  ChainShape chain;
  Vec2[] vertices;
  
  /* Constructor
  ____________________________________________________________________ */
  
  CircleBoundary(float x_,float y_) 
  {
    x = x_;
    y = y_;
    r =  canvas.width * 0.5;
    
    surface = new ArrayList<Vec2>();
    chain = new ChainShape();
    
    makeTriangle();
    
    chain.createChain(vertices,vertices.length);

    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.position.set(0.0f,0.0f);
    //bd.position.set(box2d.coordPixelsToWorld(x,y));
    Body body = box2d.createBody(bd);
    body.createFixture(chain,1); 
  }
  
  /* Make circle
  ____________________________________________________________________ */
  
  void makeCircle()
  {
    float fullAngle = 270;
    float startAngle = -45;
    
    int numPoints = 30;
    float pointDegree = fullAngle / numPoints;
    for(int i = 0; i < numPoints; i++)
    {
      float xPos = cos(radians(i * pointDegree + startAngle)) * r;
      float yPos = sin(radians(i * pointDegree + startAngle)) * r;
      surface.add(new Vec2(x + xPos, y + yPos)); 
    }

    vertices = new Vec2[surface.size()];
    for (int i = 0; i < vertices.length; i++) {
      Vec2 edge = box2d.coordPixelsToWorld(surface.get(i));
      vertices[i] = edge;
    }
  }
  
  /* Make triangle
  ____________________________________________________________________ */
  
  void makeTriangle()
  {
    float pointDegree = 360 / 3;
    
    float xPos;
    float yPos;
    
    // top point
    xPos = cos(radians(270 * 0.95)) * (r * 0.9);
    yPos = sin(radians(270 * 0.95)) * (r * 0.9);
    surface.add(new Vec2(x + xPos, y + yPos)); 
    
    // right
    xPos = cos(radians(150)) * r;
    yPos = sin(radians(150)) * r;
    surface.add(new Vec2(x + xPos, y + yPos));
    
    // left
    xPos = cos(radians(30)) * r;
    yPos = sin(radians(30)) * r;
    surface.add(new Vec2(x + xPos, y + yPos));
    
    xPos = cos(radians(270 * 1.05)) * (r * 0.9);
    yPos = sin(radians(270 * 1.05)) * (r * 0.9);
    surface.add(new Vec2(x + xPos, y + yPos)); 


    vertices = new Vec2[surface.size()];
    for (int i = 0; i < vertices.length; i++) {
      Vec2 edge = box2d.coordPixelsToWorld(surface.get(i));
      vertices[i] = edge;
    }
  }
  
  /* Make Rectangle
  ____________________________________________________________________ */
  
  void makeRectangle()
  {
    for(int i = 0; i < 4; i++)
    {
      float xPos = cos(radians(i * 90 - 45)) * r;
      float yPos = sin(radians(i * 90 - 45)) * r;
      surface.add(new Vec2(x + xPos, y + yPos)); 
    }

    vertices = new Vec2[surface.size()];
    for (int i = 0; i < vertices.length; i++) {
      Vec2 edge = box2d.coordPixelsToWorld(surface.get(i));
      vertices[i] = edge;
    }
  }
  
  /* Display
  ____________________________________________________________________ */
  
  void display(PGraphics c, float scaly)
  {
    c.strokeWeight(2);
    c.stroke(0);
    c.noFill();
    c.beginShape();
    for (Vec2 v: surface) {
      c.vertex(v.x * scaly,v.y * scaly);
    }
    c.endShape();
  }
}


