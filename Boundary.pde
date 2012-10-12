class Boundary 
{  
  float x;
  float y;
  float s;
  
  Body b;
  ArrayList<Vec2> surface;
  ChainShape chain;
  Vec2[] vertices;
  
  /* Constructor
  ____________________________________________________________________ */
  
  Boundary(float x_,float y_, float[][] points, float s_) 
  {
    x = x_;
    y = y_;
    s =  s_;
    
    surface = new ArrayList<Vec2>();
    chain = new ChainShape();
    
    for(int i = 0; i < points.length; i++)
    {
      surface.add(new Vec2(x + (points[i][0] * s), y + (points[i][1] * s))); 
    }

    vertices = new Vec2[surface.size()];
    for (int i = 0; i < vertices.length; i++) {
      Vec2 edge = box2d.coordPixelsToWorld(surface.get(i));
      vertices[i] = edge;
    }
    
    chain.createChain(vertices,vertices.length);

    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.position.set(0.0f,0.0f);
    //bd.position.set(box2d.coordPixelsToWorld(x,y));
    Body body = box2d.createBody(bd);
    body.createFixture(chain, 1); 
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
