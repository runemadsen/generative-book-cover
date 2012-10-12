class Grid
{
  int cols;
  float pageMargin;
  Column[] columns;
  
  Grid(int _cols, float _pageMargin)
  {
    cols = _cols;
    pageMargin = _pageMargin;
    
    // cache the width of the column. Remember to cast as float, otherwise the columns will not line up
    float colWidth = ((float)canvas.width - (2*pageMargin)) / cols;
    
    // make column objects
    columns = new Column[cols];
    
    for(int i = 0; i < cols; i++)
    {
      columns[i] = new Column();
      columns[i].x = pageMargin + (i*colWidth);
      columns[i].y = pageMargin;
      columns[i].w = colWidth;
      columns[i].h = canvas.height - (2*pageMargin);
    }
  }

  void display(PGraphics c, float scaly)
  {
    // draw big bounding box
    c.strokeWeight(10 * scaly);
    c.noFill();
    c.stroke(0, 100, 100);
    //c.rect(pageMargin, pageMargin, (c.width - (2*pageMargin)), (c.height - (2*pageMargin)));
    c.rectMode(CORNER);
    c.rect(pageMargin * scaly, pageMargin * scaly, (canvas.width - (2*pageMargin)) * scaly, (canvas.height - (2*pageMargin)) * scaly);
    
    // draw each column
    for(int i = 0; i < cols; i++)
    {
      c.rect(columns[i].x * scaly, columns[i].y * scaly, columns[i].w * scaly, columns[i].h * scaly);
    }
  }
}
