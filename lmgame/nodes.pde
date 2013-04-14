
class Nodes{
  int N;
  float H;
  int w;
  ArrayList<Float> posx, posy, velx, vely,hs;
  color cl1,cl3,cl2;
  int [] cls={30,200,310};
  int vmax=60;
  
  Nodes(int in){
   
    N = in; //number of nodes
    w = 80; //width of circles in each node
   posx = new  ArrayList<Float>();
    posy = new ArrayList<Float>();
    velx = new ArrayList<Float>();
    vely = new ArrayList<Float>();
    hs = new ArrayList<Float>();
  
  }  
  
  void start(){
   
   for( int i = 0; i < N; i++){
     posx.add (random(width));
     posy.add(random(height));
     velx.add(random(-30,30));
     vely.add(random(-30,30));
     hs.add(random(0,360));
   }
  }
  
  void display(){
    noStroke();
   for( int i = 0; i < N; i ++){
     
    H=hs.get(i);
    int ddy=(int)(vely.get(i)*dt);
    int ddx=(int)(velx.get(i)*dt);
    cl1 = color(H,60,50,5);  
    cl2=color(H,50,80,30);
    cl3=color(H,10,100,100);
    fill(cl1);
    ellipse(posx.get(i),posy.get(i),w,w);
    fill(cl2);
    ellipse(posx.get(i)+ddx*2,posy.get(i)+ddy*2,w/2,w/2);
    fill(cl3);
    ellipse(posx.get(i)+ddx*3,posy.get(i)+ddy*3,w/10,w/10);
   } 
  }
      
  void bounds(){
   for( int i = 0; i < N; i ++){
    if( posx.get(i) <=0 || posx.get(i) >= width){
      velx.set(i, -velx.get(i));      
    }
    if(posy.get(i) <= 0 || posy.get(i) >= height){
      vely.set(i,-vely.get(i)) ;
    }     
   } 
  }
  
  void mmove(float dt){
   // print(dt+"======");
   for( int i = 0; i < N; i++){
    posx.set(i,posx.get(i)+ velx.get(i)*dt);
    posy.set(i,posy.get(i)+ vely.get(i)*dt);
   } 
  }  
  
  void remove(int i){
    N-=1;
    posx.remove(i);
    posy.remove(i);
    velx.remove(i);
    vely.remove(i);
  }
};
