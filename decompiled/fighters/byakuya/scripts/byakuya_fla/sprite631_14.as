package byakuya_fla
{
   import flash.accessibility.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.net.drm.*;
   import flash.system.*;
   import flash.text.*;
   import flash.text.ime.*;
   import flash.ui.*;
   import flash.utils.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1054")]
   public dynamic class sprite631_14 extends MovieClip
   {
      
      public var AImain:MovieClip;
      
      public var bdmn:MovieClip;
      
      public var bs1atm:MovieClip;
      
      public var bsatm:MovieClip;
      
      public var cbs1atm:MovieClip;
      
      public var cbsatm:MovieClip;
      
      public var k1atm:MovieClip;
      
      public var k2atm:MovieClip;
      
      public var k3atm:MovieClip;
      
      public var kj1atm:MovieClip;
      
      public var kj2atm:MovieClip;
      
      public var mc:MovieClip;
      
      public var sbsatm:MovieClip;
      
      public var sh12atm:MovieClip;
      
      public var sh1atm:MovieClip;
      
      public var sh22atm:MovieClip;
      
      public var sh2atm:MovieClip;
      
      public var tkatm:MovieClip;
      
      public var tzatm:MovieClip;
      
      public var zh1atm:MovieClip;
      
      public var zh21atm:MovieClip;
      
      public var zh2atm:MovieClip;
      
      public var zh3atm:MovieClip;
      
      public function sprite631_14()
      {
         super();
         addFrameScript(16,this.frame17,23,this.frame24,30,this.frame31,35,this.frame36,65,this.frame66,76,this.frame77,86,this.frame87,91,this.frame92,94,this.frame95,96,this.frame97,105,this.frame106,113,this.frame114,125,this.frame126,131,this.frame132,150,this.frame151,166,this.frame167,172,this.frame173,178,this.frame179,208,this.frame209,215,this.frame216,223,this.frame224,245,this.frame246,252,this.frame253,260,this.frame261,281,this.frame282,288,this.frame289,302,this.frame303,319,this.frame320,321,this.frame322,342,this.frame343,351,this.frame352,354,this.frame355,365,this.frame366,379,this.frame380,383,this.frame384,385,this.frame386,390,this.frame391,411,this.frame412,419,this.frame420,428,this.frame429,438,this.frame439,439,this.frame440,440,this.frame441,453,this.frame454,458,this.frame459,476,this.frame477,504,this.frame505,542,this.frame543,555,this.frame556,563,this.frame564,578,this.frame579,594,this.frame595,622,this.frame623,633,this.frame634,670,this.frame671,675,this.frame676
         ,706,this.frame707,721,this.frame722,724,this.frame725,778,this.frame779,779,this.frame780,780,this.frame781,873,this.frame874,882,this.frame883,1004,this.frame1005,1025,this.frame1026,1092,this.frame1093,1114,this.frame1115,1137,this.frame1138,1181,this.frame1182);
      }
      
      internal function frame17() : *
      {
         parent.$mc_ctrler.loop("走");
      }
      
      internal function frame24() : *
      {
         parent.$mc_ctrler.dash(3);
         parent.$mc_ctrler.setBisha();
         parent.$mc_ctrler.setBishaUP();
         parent.$mc_ctrler.setBishaSUPER();
         parent.$effect_ctrler.dash();
      }
      
      internal function frame31() : *
      {
         parent.$mc_ctrler.dashStop();
      }
      
      internal function frame36() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame66() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame77() : *
      {
         parent.$effect_ctrler.shine(8245740);
         parent.$mc_ctrler.move(-3,-3);
         parent.$mc_ctrler.damping(0.1,0.1);
      }
      
      internal function frame87() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame92() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame95() : *
      {
         parent.$mc_ctrler.move(0,10);
         parent.$mc_ctrler.setTouchFloor("跳招2",true);
         parent.$effect_ctrler.shadow(200,0,200);
      }
      
      internal function frame97() : *
      {
         parent.$effect_ctrler.shine();
         parent.$effect_ctrler.shine(12605448);
      }
      
      internal function frame106() : *
      {
         parent.$mc_ctrler.loop("跳招1");
      }
      
      internal function frame114() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame126() : *
      {
         parent.$effect_ctrler.shine(15174887);
      }
      
      internal function frame132() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame151() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame167() : *
      {
         parent.$mc_ctrler.setAttack("砍2");
         parent.$mc_ctrler.setSkill1();
         parent.$mc_ctrler.setZhao1();
      }
      
      internal function frame173() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame179() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame209() : *
      {
         parent.$mc_ctrler.setSkill2();
         parent.$mc_ctrler.setAttack("砍3");
         parent.$mc_ctrler.setSkill1();
      }
      
      internal function frame216() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame224() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame246() : *
      {
         parent.$mc_ctrler.setBishaSUPER();
         parent.$mc_ctrler.setBisha();
         parent.$mc_ctrler.setZhao1();
         parent.$mc_ctrler.setDash();
      }
      
      internal function frame253() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame261() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame282() : *
      {
         parent.$effect_ctrler.shine();
      }
      
      internal function frame289() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame303() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame320() : *
      {
         parent.$mc_ctrler.addQi(10);
      }
      
      internal function frame322() : *
      {
         parent.$mc_ctrler.setHurtAction("招31");
      }
      
      internal function frame343() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame352() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame355() : *
      {
         parent.$effect_ctrler.shine(15174887);
      }
      
      internal function frame366() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame380() : *
      {
         parent.$mc_ctrler.addQi(10);
      }
      
      internal function frame384() : *
      {
         parent.$fighter_ctrler.moveToTarget(100,null,false);
      }
      
      internal function frame386() : *
      {
         parent.$effect_ctrler.slowDown(1);
      }
      
      internal function frame391() : *
      {
         parent.$effect_ctrler.shine(8245740);
      }
      
      internal function frame412() : *
      {
         parent.$mc_ctrler.setBishaUP();
         parent.$mc_ctrler.setZhao3("招31");
         parent.$mc_ctrler.setSkill1();
         parent.$mc_ctrler.setZhao1();
      }
      
      internal function frame420() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame429() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame439() : *
      {
         parent.$mc_ctrler.addQi(5);
      }
      
      internal function frame440() : *
      {
         parent.$mc_ctrler.fire("zh1atm",{
            "x":{
               "start":5,
               "add":1,
               "max":20
            },
            "y":0,
            "hold":2,
            "hits":1
         });
      }
      
      internal function frame441() : *
      {
         parent.$effect_ctrler.shine(15174887);
      }
      
      internal function frame454() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame459() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame477() : *
      {
         parent.$effect_ctrler.bisha(false,"白哉2");
      }
      
      internal function frame505() : *
      {
         parent.$effect_ctrler.endBisha();
      }
      
      internal function frame543() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame556() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame564() : *
      {
         parent.$mc_ctrler.addQi(10);
      }
      
      internal function frame579() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame595() : *
      {
         parent.$mc_ctrler.addQi(20);
      }
      
      internal function frame623() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame634() : *
      {
         parent.$effect_ctrler.bisha(false,"白哉2");
      }
      
      internal function frame671() : *
      {
         parent.$effect_ctrler.endBisha();
      }
      
      internal function frame676() : *
      {
         parent.$effect_ctrler.shine();
      }
      
      internal function frame707() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame722() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame725() : *
      {
         parent.$effect_ctrler.bisha(true,"白哉3");
      }
      
      internal function frame779() : *
      {
         parent.$effect_ctrler.endBisha();
      }
      
      internal function frame780() : *
      {
         parent.$effect_ctrler.dash();
         parent.$effect_ctrler.slowDown(1);
      }
      
      internal function frame781() : *
      {
         parent.$fighter_ctrler.moveToTarget(150,null,false);
         parent.$effect_ctrler.shine();
      }
      
      internal function frame874() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame883() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame1005() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame1026() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame1093() : *
      {
         parent.$effect_ctrler.endWanKai();
      }
      
      internal function frame1115() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame1138() : *
      {
         stop();
      }
      
      internal function frame1182() : *
      {
         stop();
      }
   }
}

