class ColorPicker
{
  int lowH = 0;
  int lowS = 0;
  int lowB = 10;
  
  int highH = 360;
  int highS = 100;
  int highB = 100;
  
  ColorPicker()
  {
    
  }
  
  HSBColor getRandom()
  {
    return new HSBColor(random(lowH, highH), random(lowS, highS), random(lowB, highB));
  }
}
