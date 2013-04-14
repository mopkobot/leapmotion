class explode{
  
  public float rate=30;
  int s;
  float x;
  float y;
  float dx=0;
  float dy=0;
  int tmp=0;
  float maxT=3;
float n=0;
float kvn=30;
PVector v;
float dr;float kdr;
float R=0;
float phi;
float phiSmall=0,phiBig;


//int[] H={200,30,310};
int H=200;
float kxyNoise=0.003;
public float tGlobal=0;

explode(float ix,float iy,int iH){
//v=new PVector(0,10,0);
H=iH;


}

void display(){ noStroke();
float ki=PI/2/maxT/rate;
  s =second();
  if (s-second()!=0){tmp+=1;}
  if(tmp<maxT){
    R=cos(tGlobal*ki);
    tGlobal+=1;
    phi=80*noise(tGlobal*kxyNoise,tGlobal);
    dx=R*cos(phi);dy=R*sin(phi);
    
      float r=10;
  int c1=color(H,90,100,3);fill(c1);
  ellipse(x+dx,y+dy,10*r,10*r);
   int c2=color(H,80,100,20);fill(c2);
  ellipse(x+dx,y+dy,5*r,5*r);
   int c3=color(H,10,100,100);fill(c3);
  ellipse(x+dx,y+dy,2*r,2*r);
  }
  else{noLoop();}
  
  
 



  


}
}



