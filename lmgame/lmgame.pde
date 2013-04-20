// img
PImage img; 
//audio
import ddf.minim.*;Minim minim;
AudioPlayer player;boolean played=false;
AudioPlayer ex;

// socket
import oscP5.*;import netP5.*;OscP5 oscP5;
int type = 3;float px = 0;float py = 0;float pz = 0;int state;

// 游戏参数
public PFont f;
String[] start_text={"想~~~~~中~~~~~~奖","摸~~~~~~一~~~~~~摸","摸~~~~~~完~~~~~~了","抓~~~~~~一~~~~~~把","快~~~~~~摸~~~~~~啊","........","摸~~~~~~~~~~~~啊","摸~~~~~~~~~~~~！！"};
int textI=0; final int mod=90;int nn;
int random_index = int(random(0,1.99))%2;
int totalTime = 50   ; // 游戏时间

int score=0;
int tmp=0;
public float rate=30;

// 屏幕参数
public int w=1200;
public int h=800;
float vMax=0;
float n=0;

//游戏 小球参数
Boolean openBol=false;
Boolean bolK=true;
int num=50;
Nodes balls;//每次的小球数量
float distance=400;//小球接近的阈值
float dt=0.1;//小球的速度
PVector s, s1, ds;
int tGlobal;
Boolean hand=true;//需要改成false！抓取的动作
Boolean endBol=false;
void setup() {
   control con =new control();
    size(w, h);colorMode(HSB, 360, 100, 100, 100);
    minim = new Minim(this);
    player = minim.loadFile("marcus_kellis_theme.mp3");player.loop();
    ex=minim.loadFile("Track38.wav");
    frameRate(rate); img = loadImage("mao.png"); 
    oscP5 = new OscP5(this, 7110);
    f = createFont("MicrosoftYaHei-48.vlw", 120);textFont(f);textAlign(CENTER, CENTER);
}



void draw() { 
  tGlobal+=1;
     if(tGlobal == 1){background(0, 0, 0, 0);}
     noStroke(); fill(0, 0, 0, 25);rect(0, 0, width, height);//加入透明背景
     
   
    ////////////////////////////////////////////////////游戏进入前画面
    if(!openBol && !endBol) {//游戏进入前画面
        textI += 1;
        nn=int(textI/40);
        if(nn < start_text.length){
            f = createFont("MicrosoftYaHei-48.vlw", 250);textFont(f);
            fill(0,100,100,100);text("摸摸", w/2, h*0.333);
            f = createFont("MicrosoftYaHei-48.vlw", 100);textFont(f);
            fill(0,100,100,100);text("mo", w*0.383, h*0.555);
            f = createFont("MicrosoftYaHei-48.vlw", 50);textFont(f);
            fill(nn*60%360,0,100,100);
            String k=start_text[nn]; text(k, w/2, h*0.726);
       }
    }
  
    if (type == 1 && bolK == true){  
      //if(keyPressed&& bolK == true){
        balls=new Nodes(num);
        balls.start();  //如果有事件发生，产生n个小球
        bolK=false;
        openBol=true;
    }
  
   
   

    //////////////////小球动画////////////////////////////////////
    if(openBol&& !endBol){
      //px=mouseX;py=mouseY;
        fill(300); ellipse(px, py, 40, 40);//小鼠标
        balls.bounds();balls.mmove(dt);balls.display();//小球初始化
        if (type==102 || type==103){
         // if(mousePressed){
            noStroke();
            fill(300);
            ellipse(px, py, 80, 80);
            if(tmp < 30){
                hand = true;
                tmp += 1;
            } else {
              hand=false;
            }
    }//如果握住，抓取持续2s的时间
    
    if(type==101){tmp=0;}//如果不抓住移动，tmp需要归零
    if(type==104){tmp=0;}//如果释放，tmp需要归零
    
    //如果用手抓取
    if(hand) {
       for(int k = 0; k < balls.N; k++){
           float x=(float)(balls.posx.get(k));
           float y=balls.posy.get(k);
           x -= px; y -= py; //计算坐标差
       if( x*x + y*y < distance){ 
           int vFinal=(int)(abs(balls.velx.get(k))+abs(balls.vely.get(k)));
           int HH= (int)(float)(balls.hs.get(k));
           score += vFinal; int r=10;
             
          explode exp=new explode(px,py,90,HH,20);
          exp.vRandom=0.01; exp.k=8;exp.display();
          ex.loop(0);

           f = createFont("MicrosoftYaHei-48.vlw", 200);textFont(f);text("+"+vFinal, w/2, h/2);
          
           //爆炸效果
           if(balls.N > 0) {
               balls.remove(k);
               break;
            }else {
                balls=new Nodes(num);
                balls.start();
            }
        }
  }
      hand=false;
    }
    // 游戏结束，展示分数
    if (tGlobal/rate > totalTime){
      openBol=false;endBol=true;
     }
  }
  
  if(endBol){ 
        fill(0, 0, 0,100);rect(0, 0, width, height);
        int ran=20;
        int xPos=600+(int)(ran*random(-1,1));int yPos=100+(int)(ran*random(-1,1));
        explode exp1=new explode(xPos+img.width/2,yPos+250,90,5,50);
        exp1.vRandom=0.01;exp1.BMax=60; exp1.k=10;exp1.maxWeight=60;exp1.g=1;exp1.display();
          
        image(img,xPos,yPos);
        f = createFont("MicrosoftYaHei-48.vlw", 80);textFont(f);
        String [] strs = {"需要支付","收入了"};
        String k = "您" + strs[random_index] + score + "RMB";
        fill(0,100,100,100); text(k, w/3, h/2);
        f = createFont("MicrosoftYaHei-48.vlw  ", 25);textFont(f);
        String k1="版权所有：摸摸开发团队---低智商欢乐小组";
        fill(0,0,100,100); text(k1, w*.333, h*.6);
       if(type==110){tGlobal=0;endBol=false;openBol=false; bolK = true;}
     }
  
}

void mouseReleased(){
tmp=0;
}

// socket OSC
void oscEvent(OscMessage theOscMessage) {
 type = theOscMessage.get(0).intValue();
 state = theOscMessage.get(1).intValue();
 px = theOscMessage.get(2).floatValue()*width;
 py = theOscMessage.get(3).floatValue()*height;
 pz = theOscMessage.get(4).floatValue()*height;
}
