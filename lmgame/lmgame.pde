PImage img; 
import ddf.minim.*;Minim minim;
AudioPlayer player;boolean played=false;
AudioPlayer player1;boolean played1=false;

import oscP5.*;import netP5.*;OscP5 oscP5;
int totalTime=60;
int myBroadcastPort = 12000;String myConnectPattern = "/server/connect";String myDisconnectPattern = "/server/disconnect";
 NetAddress myRemoteLocation = new NetAddress("192.168.1.141",12000);OscMessage myMessage;
public PFont f;  String[] text1={"想~~~~~中~~~~~~奖","摸~~~~~~一~~~~~~摸","摸~~~~~~完~~~~~~了","抓~~~~~~一~~~~~~把","快~~~~~~摸~~~~~~啊","........","摸~~~~~~~~~~~~啊","摸~~~~~~~~~~~~！！"};int textI=0; final int mod=90;int nn;
 boolean bolK=true;

int score=0;
int tmp=0;
int type = 3;float px = 0;float py = 0;float pz = 0;int state;

public float rate=30;

Boolean hand=true;//需要改成false！抓取的动作
Boolean openBol=false;
public int w=1200;
public int h=800;
float vMax=0;
float n=0;

int num=25;
Nodes balls;//每次的小球数量
float distance=800;//小球接近的阈值
float dt=0.2;//小球的速度
PVector s, s1, ds;
int tGlobal;

int random_index = int(random(0,1.99))%2;


void setup() {size(w, h);colorMode(HSB, 360, 100, 100, 100);
 minim = new Minim(this);
player = minim.loadFile("marcus_kellis_theme.mp3");
//player1 = minim.loadFile("Track78.wav");

frameRate(rate); img = loadImage("mao.jpg"); 
  oscP5 = new OscP5(this, 7110);
  f = createFont("MicrosoftYaHei-48.vlw", 120);textFont(f);textAlign(CENTER, CENTER);
}



void draw() {fill(0, 0, 0, 15);rect(0, 0, width, height);//加入透明背景

   //if(keyPressed==true){print("====");      openBol=false;played=false;bolK=true;hand=true;}


 tGlobal+=1;if(!played){ player.play();played=true; }
     
   
  ////////////////////////////////////////////////////游戏进入前画面
  if (!openBol) {//游戏进入前画面
  
    textI+=1;nn=int(textI/20);
    print(nn+"++++");
    if(nn<text1.length){
    
    f = createFont("MicrosoftYaHei-48.vlw", 250);textFont(f);
    fill(0,100,100,100);text("摸摸", w/2, h*0.333);
    f = createFont("MicrosoftYaHei-48.vlw", 100);textFont(f);
    fill(0,100,100,100);text("mo", w*0.383, h*0.555);
    f = createFont("MicrosoftYaHei-48.vlw", 50);textFont(f);
    fill(nn*60%360,0,100,100);
    String k=text1[nn]; text(k, w/2, h*0.726);
  }}
  //
  if (type==1&&bolK==true) {  
    balls=new Nodes(num);balls.start();//如果有事件发生，产生n个小球
    bolK=false;
  openBol=true;
  }
  
  //n+=1;tGlobal+=0.1;
  if (n==1) {background(0, 0, 0, 0);//s1=new PVector(mouseX,mouseY);
  }
  //////////////////////////////////////////////////////test
  //px=mouseX;py=mouseY;
  ///////////////////////////////////////////////test
  fill(300);ellipse(px, py, 50, 50);

  //////////////////小球部分////////////////////////////////////
  if (openBol) {balls.bounds();balls.mmove(dt);balls.display();//小球初始化
  
    if (type==102||type==103){noStroke();fill(300);ellipse(px, py, 80, 80);
    if(tmp<50){hand=true;tmp+=1;}else{hand=false;}
    }//如果握住，抓取持续2s的时间
    
    if(type==101){tmp=0;}//如果不抓住移动，tmp需要归零
    if(type==104){tmp=0;}//如果释放，tmp需要归零
    if (hand) {//如果用手抓取
     
      for (int k=0;k<balls.N;k++) {
        float x=(float)(balls.posx.get(k));
        float y=balls.posy.get(k);
        x-=px;y-=py;//计算坐标差
        if (x*x+y*y<distance)
        {  //if(!played1){ player1.play();played1=true; }
          
          int HH= (int)(float)(balls.hs.get(k));
        int add=(int)random(0,10);
           score+=add;int r=10;
  int c0=color(HH,90,60,60);fill(c0);
  ellipse(px,py,800,800);
  int c1=color(HH,90,60,70);fill(c1);
  ellipse(px,py,300,300);
   int c2=color(HH,100,70,80);fill(c2);
  ellipse(px,py,100,100);
   int c3=color(HH,10,100,100);fill(c3);
  ellipse(px,py,20,20);
   f = createFont("MicrosoftYaHei-48.vlw", 200);textFont(f);text("+"+add, w/2, h/2);
  
           //explode ex=new explode(px,py,HH);ex.display();//爆炸效果
          if (balls.N>1) {
            balls.remove(k);
            break;
          }
          else {
            balls.start();
          }
        }
      }
      hand=false;
    }
    
    if (tGlobal/rate>totalTime){
      fill(0, 0, 0,100);rect(0, 0, width, height);
      image(img,width*.33,height*0,width*.66,height*33);
    
     f = createFont("MicrosoftYaHei-48.vlw", 90);textFont(f);
     String [] strs={"需要支付","收入了"};
    String k="您"+strs[random_index]+score+"RMB";
    fill(nn*60%360,100,100,100); text(k, w/2, h/2);
    
    f = createFont("MicrosoftYaHei-48.vlw", 45);textFont(f);
    String k1="版权所有：摸摸开发豪华团队---低智商小组";
    fill(0,0,100,0); text(k1, w/3, h*.6666);
    
    //openBol=false;
    }
  }
  // s=new PVector(mouseX,mouseY);
  //ds=new PVector(0,0);ds.add(s);ds.sub(s1);//速度
  //s1=s;

  //if ((state==2)&&(type!=-1)){
  // fill(200);ellipse(px,py,200,200);}
}

//nodes = new Nodes[num]; 

void oscEvent(OscMessage theOscMessage) {
  /* print the address pattern and the typetag of the received OscMessage */
  //print("### received an osc message.");
  type = theOscMessage.get(0).intValue();
  state = theOscMessage.get(1).intValue();
  //start,update,stop;
  // print(state);
  px = theOscMessage.get(2).floatValue()*width;
  py = theOscMessage.get(3).floatValue()*height;
  
  
    myMessage = new OscMessage("/explode");
    myMessage.add("收到了吗"); /* add an int to the osc message */
    oscP5.send(myMessage, myRemoteLocation); 
    
  //pz = theOscMessage.get(4).floatValue();
  //println(type + "," + state + ", (" + px + "," + py + "," + pz +")" );
  // println("frame" + index++);
}
