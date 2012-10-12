class Symbol 
{
  Body body;
  float w;
  float h;
  float x;
  float y;
  int type; // 0 = rectangle, 1 = triangle, 2 = ellipse
  Vec2[] vertices;
  
  /* Constructor
  ____________________________________________________________________ */

  Symbol(float _x, float _y, float s, int _type) 
  {
    w = s;
    h = s;
    x = _x;
    y = _y;
    type = int(random(3));//_type;
    
    //type = 0;
    
    if(type == 0)       makeRectangle();
    else if(type == 1)  makeTriangle();
    else if(type == 2)  makeEllipse();
    
    makeBody(new Vec2(x, y), w, h);
  }
  
  void makeRectangle()
  {
    vertices = new Vec2[4]; 
    vertices[0] = box2d.vectorPixelsToWorld(new Vec2(-(w/2), -(h/2)));
    vertices[1] = box2d.vectorPixelsToWorld(new Vec2((w/2), -(h/2)));
    vertices[2] = box2d.vectorPixelsToWorld(new Vec2((w/2), (h/2)));
    vertices[3] = box2d.vectorPixelsToWorld(new Vec2(-(w/2), (h/2)));
  }
  
  void makeTriangle()
  {
    vertices = new Vec2[3]; 
    vertices[0] = box2d.vectorPixelsToWorld(new Vec2(cos(radians(0)) * (w/2), sin(radians(0)) * (w/2)));
    vertices[1] = box2d.vectorPixelsToWorld(new Vec2(cos(radians(120)) * (w/2), sin(radians(120)) * (w/2)));
    vertices[2] = box2d.vectorPixelsToWorld(new Vec2(cos(radians(240)) * (w/2), sin(radians(240)) * (w/2)));
  }
  
  void makeEllipse()
  {
    int numPoints = 8;
    float pointDegree = 360 / numPoints;
    vertices = new Vec2[numPoints];
   
    for(int i = 0; i < numPoints; i++)
    {
      vertices[i] = box2d.vectorPixelsToWorld(new Vec2(cos(radians(pointDegree * (numPoints - i))) * (w/2), sin(radians(pointDegree * (numPoints - i))) * (w/2)));
    } 
  }
  
  /* Display
  ____________________________________________________________________ */

  void display(PGraphics c, float scaly)
  {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    
    float a = body.getAngle();
    
    c.pushMatrix();
    c.translate(pos.x * scaly, pos.y * scaly);
    c.rotate(-a);
    c.fill(symbolColor.h, symbolColor.s, symbolColor.b);
    c.noStroke();
    
    if(type == 0)       displayRectangle(c, scaly);
    else if(type == 1)  displayTriangle(c, scaly);
    else if(type == 2)  displayEllipse(c, scaly);
    
    c.popMatrix();
  }
  
  void displayRectangle(PGraphics c, float scaly)
  {
    c.rectMode(CENTER);
    c.rect(0, 0, w * scaly, h * scaly);
  }
  
  void displayTriangle(PGraphics c, float scaly)
  {
    c.triangle(cos(radians(0)) * ((w/2) * scaly), sin(radians(0)) * ((w/2) * scaly), cos(radians(120)) * ((w/2) * scaly), sin(radians(120)) * ((w/2) * scaly), cos(radians(240)) * ((w/2) * scaly), sin(radians(240)) * ((w/2) * scaly));
  }
  
  void displayEllipse(PGraphics c, float scaly)
  {
    c.ellipse(0, 0, w * scaly, h * scaly);
  }

  /* Remove dead ones
  ____________________________________________________________________ */
  
  boolean done(PGraphics c) 
  {
    Vec2 pos = box2d.getBodyPixelCoord(body);

    if (pos.y > c.height)
    {
      killBody();
      return true;
    }
    
    return false;
  }
  
  void killBody() 
  {
    box2d.destroyBody(body);
  }

  /* Make body
  ____________________________________________________________________ */
  
  void makeBody(Vec2 center, float w_, float h_) 
  {
    // Define a polygon (this is what we use for a rectangle)
    PolygonShape sd = new PolygonShape();
    //float box2dW = box2d.scalarPixelsToWorld(w_/2);
    //float box2dH = box2d.scalarPixelsToWorld(h_/2);
    //sd.setAsBox(box2dW, box2dH);
    sd.set(vertices, vertices.length);

    // Define a fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    // Parameters that affect physics
    fd.density = 1;
    fd.friction = 0.5;
    fd.restitution = 0.5;

    // Define the body and make it from the shape
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(center));

    body = box2d.createBody(bd);
    body.createFixture(fd);

    // Give it some initial random velocity
    body.setLinearVelocity(new Vec2(random(-5, 5), random(2, 5)));
    body.setAngularVelocity(random(-5, 5));
  }
}

