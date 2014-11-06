import ddf.minim.analysis.*;
import ddf.minim.*;
import ddf.minim.signals.*;
 
Minim minim;
AudioInput in;
AudioPlayer player1;

float gain = 500;
float[] myBuffer;
int timer;
int perc;

void setup()
{
  size(3000, 1600, P3D);
 
  minim = new Minim(this);
  in = minim.getLineIn(Minim.MONO,2048);

  myBuffer = new float[in.bufferSize()];
   
  player1 = minim.loadFile("tires.mp3", 1024);

  timer = 0;
  perc = 0;
}
 
void draw()
{

  int concentration = 1000;  // Try 1 -> 10000 
//spotLight(51, 102, 126, 50, 50, 400, 0, 0, -1, PI/16, concentration); 
//spotLight(51, 102, 126, width/2, height/2, 4000, 0, 0, -1, PI/16, concentration); 
       
  timer++;
  int zPos = -5000+timer*160;

  background(0);
  stroke(255);
  // draw the output waveforms, so there's something to look at
  // first grab a stationary copy
  for (int i = 0; i < in.bufferSize(); ++i) {
    myBuffer[i] = in.left.get(i);
  }
  
  for(int i = 0; i < in.bufferSize() - 1; i++)
  {
    float x1 = map(i, 0, myBuffer.length, 0, width);
    float x2 = map(i+1, 0, myBuffer.length, 0, width);
    camera(width/2.0 - myBuffer[i]*gain, height/2.0 + myBuffer[i]*gain, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0);
    if(myBuffer[i]*gain > 100){
          player1.play(0);  

    } 
  }
  
  fill(255, 70);
  noStroke();
  //sidelines
  translate(0, height, 0); 
  box(width, 1, 10000);
  translate(0, -height, 0); 
  
  fill(208, 192, 6);
  noStroke();
  //sidelines
  translate(0, height, 0); 
  box(90, 1, 10000);
  translate(0, -height, 0); 
  translate(width, height, 0); 
  box(90, 1, 10000);
  translate(-width, -height, 0); 
  //central line
  translate(width/2, height, zPos); 
  if(zPos < -3000){
    perc = round((zPos+5000)/2000*100);
    fill(208, 192, 6, perc);
  }else{
    fill(208, 192, 6);
  }
  box(120, 1, 2000);
  translate(-width/2, -height, -zPos); 
  if(zPos > 1000){
    timer = 0;
  }
   
   println(zPos);
}
 
void stop()
{
  // always close Minim audio classes when you finish with them
  in.close();
  minim.stop();
  super.stop();
}

