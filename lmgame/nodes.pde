
class Nodes{
  int N;
  float H;
  int w=15;
  ArrayList<Float> posx, posy, velx, vely,hs;
  color cl1,cl3,cl2;
  int [] cls={30,200,310};
  int vmax=100;
  float kposx=0.4,kposy=kposx,kc=10;
  
  Nodes(int in){
   
    N = in; //number of nodes
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
     
     velx.add(random(-vmax,vmax));
     vely.add(random(-vmax,vmax));
     hs.add(random(0,360));
   }
  }
  
  void display(){
    noStroke();
   for( int i = 0; i < N; i ++){
     
    H=hs.get(i);
    for (int k=10;k>0;k--){
      float j=k*0.1;
      
    cl1 = color(H,kc*k/2.0,110-kc*k/5.5,110-kc*k/5.5); stroke(cl1);strokeWeight(w*(1-0.25*j));
    point(posx.get(i)-(velx.get(i)*dt)*kposx*k,posy.get(i)-(vely.get(i)*dt)*kposy*k);

    }
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
