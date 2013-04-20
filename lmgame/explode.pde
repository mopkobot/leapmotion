class explode{
 float k=5;
ArrayList<Float> px, py, vx, vy,ax,ay;
int maxT;
int g=0;
float x,y;
int H,n;
int A=100;
int c=color(100,0,100);
float kav=0.01;
//float kxyNoise=0.003;
float vRandom=0.3;
int t;
int BMax=60;
int maxWeight=45;
explode(float ix,float iy,int imaxT,int iH,int in){  //初始化后直接运行
    x=ix;y=iy;maxT=imaxT;H=iH;n=in;

    px = new  ArrayList<Float>();py = new ArrayList<Float>();
    vx = new ArrayList<Float>();vy = new ArrayList<Float>();
    ax = new ArrayList<Float>();ay = new ArrayList<Float>();
}

void display(){


for(int i =0;i<n;i++){
float rv=random(-1,1)*k;float phi=i/(float)n*2*PI;float vx0=rv*cos(phi);float vy0=rv*sin(phi);//初始速度
vx.add(vx0);vy.add(vy0);
ax.add(-kav*vx0);ay.add(-kav*vy0);
px.add(x);py.add(y);
}

while(t<maxT){ t++;
for(int i =0;i<n-1;i++){
px.set(i,px.get(i)+ vx.get(i));py.set(i,py.get(i)+ vy.get(i));
vx.set(i,vx.get(i)-random(-1,1)*vRandom+ax.get(i));vy.set(i,vy.get(i)-random(-1,1)*vRandom+ay.get(i));
ax.set(i,-vx.get(i)*kav);ay.set(i,-vy.get(i)*kav);

c=color(H,t/2.0,100-t/2.0,BMax-t/4.0);
if(g==1){
c=color(H,t/10.0,100-t/2.0,BMax-t/4.0);
}
strokeWeight(maxWeight*(1-t*0.011));
stroke(c);
point(px.get(i),py.get(i));

}

}
}


}


  
 



  







