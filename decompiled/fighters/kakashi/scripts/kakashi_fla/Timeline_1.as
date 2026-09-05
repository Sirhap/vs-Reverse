package kakashi_fla
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol642")]
   public dynamic class Timeline_1 extends MovieClip
   {
      
      public var sh22atm:MovieClip;
      
      public var zh3atm:MovieClip;
      
      public var tzatm:MovieClip;
      
      public var shenwei:MovieClip;
      
      public var sh12atm:MovieClip;
      
      public var zh2atm:MovieClip;
      
      public var zh31atm:MovieClip;
      
      public var sh1atm:MovieClip;
      
      public var zh20atm:MovieClip;
      
      public var zh32atm:MovieClip;
      
      public var bdmn:MovieClip;
      
      public var zh13atm:MovieClip;
      
      public var sh2atm:MovieClip;
      
      public var kj21atm:MovieClip;
      
      public var zh12atm:MovieClip;
      
      public var k21atm:MovieClip;
      
      public var AImain:MovieClip;
      
      public var kj20atm:MovieClip;
      
      public var dog1:MovieClip;
      
      public var bsatm:MovieClip;
      
      public var bs1atm:MovieClip;
      
      public var zh14atm:MovieClip;
      
      public var kj10atm:MovieClip;
      
      public var bs0atm:MovieClip;
      
      public var kj22atm:MovieClip;
      
      public var kj1atm:MovieClip;
      
      public var k1atm:MovieClip;
      
      public var shuilong:MovieClip;
      
      public var k3atm:MovieClip;
      
      public var kj2atm:MovieClip;
      
      public var k2atm:MovieClip;
      
      public var zh1atm:MovieClip;
      
      public var tkatm:MovieClip;
      
      public var target:*;
      
      public var moveY:Number;
      
      public function Timeline_1()
      {
         super();
         addFrameScript(11,this.frame12,20,this.frame21,23,this.frame24,28,this.frame29,35,this.frame36,38,this.frame39,68,this.frame69,80,this.frame81,88,this.frame89,92,this.frame93,107,this.frame108,111,this.frame112,113,this.frame114,126,this.frame127,142,this.frame143,147,this.frame148,152,this.frame153,156,this.frame157,169,this.frame170,179,this.frame180,185,this.frame186,190,this.frame191,216,this.frame217,223,this.frame224,228,this.frame229,246,this.frame247,251,this.frame252,255,this.frame256,272,this.frame273,283,this.frame284,290,this.frame291,291,this.frame292,296,this.frame297,297,this.frame298,304,this.frame305,315,this.frame316,326,this.frame327,327,this.frame328,335,this.frame336,353,this.frame354,371,this.frame372,393,this.frame394,398,this.frame399,402,this.frame403,406,this.frame407,410,this.frame411,419,this.frame420,422,this.frame423,449,this.frame450,450,this.frame451,466,this.frame467,468,this.frame469,480,this.frame481,526,this.frame527,530,this.frame531,543,this.frame544
         ,554,this.frame555,573,this.frame574,582,this.frame583,585,this.frame586,587,this.frame588,591,this.frame592,616,this.frame617,630,this.frame631,641,this.frame642,658,this.frame659,703,this.frame704,717,this.frame718,733,this.frame734,735,this.frame736,746,this.frame747,756,this.frame757,770,this.frame771,782,this.frame783,818,this.frame819,819,this.frame820,833,this.frame834,844,this.frame845,850,this.frame851,866,this.frame867,876,this.frame877,890,this.frame891,912,this.frame913,932,this.frame933,933,this.frame934,998,this.frame999,1209,this.frame1210,1213,this.frame1214,1214,this.frame1215,1234,this.frame1235,1309,this.frame1310,1350,this.frame1351,1378,this.frame1379);
      }
      
      internal function frame12() : *
      {
         parent.$effect_ctrler.walk();
      }
      
      internal function frame21() : *
      {
         parent.$effect_ctrler.walk();
      }
      
      internal function frame24() : *
      {
         parent.$mc_ctrler.loop("走");
      }
      
      internal function frame29() : *
      {
         parent.$mc_ctrler.dash(3);
         parent.$mc_ctrler.setBisha();
         parent.$mc_ctrler.setBishaUP();
         parent.$mc_ctrler.setBishaSUPER();
         parent.$effect_ctrler.shadow(50,50,255);
         parent.$effect_ctrler.dash();
      }
      
      internal function frame36() : *
      {
         parent.$mc_ctrler.dashStop();
      }
      
      internal function frame39() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame69() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame81() : *
      {
         parent.$mc_ctrler.setAirMove(true);
      }
      
      internal function frame89() : *
      {
         parent.$mc_ctrler.setSkillAIR();
      }
      
      internal function frame93() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame108() : *
      {
         parent.$mc_ctrler.move(0,-1);
      }
      
      internal function frame112() : *
      {
         parent.$mc_ctrler.move(-5,-5);
         parent.$mc_ctrler.damping(0.5,0.5);
      }
      
      internal function frame114() : *
      {
         parent.$mc_ctrler.fire("tzatm",{
            "x":15,
            "y":15,
            "hold":2,
            "hits":1
         });
      }
      
      internal function frame127() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame143() : *
      {
         parent.$mc_ctrler.movePercent(1.7,0);
         parent.$mc_ctrler.dampingPercent(0.7,0);
      }
      
      internal function frame148() : *
      {
         parent.$mc_ctrler.setAttack("砍2");
         parent.$mc_ctrler.setZhao1();
         parent.$mc_ctrler.setBisha();
      }
      
      internal function frame153() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame157() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame170() : *
      {
         parent.$mc_ctrler.movePercent(1,0);
         parent.$mc_ctrler.dampingPercent(0.05,0);
      }
      
      internal function frame180() : *
      {
         parent.$mc_ctrler.setBishaSUPER();
         parent.$mc_ctrler.setAttack("砍3");
         parent.$mc_ctrler.setSkill2();
         parent.$mc_ctrler.setSkill1();
         parent.$mc_ctrler.setZhao2();
         parent.$mc_ctrler.setBisha();
         parent.$mc_ctrler.setDash();
         parent.$mc_ctrler.setJump();
      }
      
      internal function frame186() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame191() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame217() : *
      {
         parent.$mc_ctrler.setSkill1();
         parent.$mc_ctrler.setZhao3("招32");
         parent.$mc_ctrler.setBishaUP();
         parent.$mc_ctrler.setDash();
      }
      
      internal function frame224() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame229() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame247() : *
      {
         if(parent.$mc_ctrler.getAttacker("dog1"))
         {
            parent.$mc_ctrler.idle();
         }
      }
      
      internal function frame252() : *
      {
         parent.$mc_ctrler.addQi(10);
      }
      
      internal function frame256() : *
      {
         parent.$mc_ctrler.addAttacker("dog1");
      }
      
      internal function frame273() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame284() : *
      {
         parent.$mc_ctrler.movePercent(3,0);
         parent.$mc_ctrler.setHitTarget("kj10atm","砍技12");
         parent.$effect_ctrler.shadow(50,50,255);
         parent.$effect_ctrler.dash();
      }
      
      internal function frame291() : *
      {
         parent.$mc_ctrler.gotoAndPlay("砍技1_miss");
      }
      
      internal function frame292() : *
      {
         parent.$mc_ctrler.movePercent(2,0);
         parent.$fighter_ctrler.setCross(true);
         parent.$effect_ctrler.shadow(50,50,255);
      }
      
      internal function frame297() : *
      {
         parent.$fighter_ctrler.setDirectToTarget();
      }
      
      internal function frame298() : *
      {
         parent.$mc_ctrler.dampingPercent(0.2,0);
         parent.$fighter_ctrler.setCross(false);
      }
      
      internal function frame305() : *
      {
         parent.$mc_ctrler.setZhao1("招12");
         parent.$mc_ctrler.setBisha();
         parent.$effect_ctrler.endShadow();
      }
      
      internal function frame316() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame327() : *
      {
         parent.$mc_ctrler.addQi(10);
      }
      
      internal function frame328() : *
      {
         parent.$mc_ctrler.movePercent(2,0);
         parent.$mc_ctrler.setHitTarget("kj20atm","砍技21");
      }
      
      internal function frame336() : *
      {
         parent.$mc_ctrler.dampingPercent(0.3,0);
      }
      
      internal function frame354() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame372() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame394() : *
      {
         parent.$mc_ctrler.addQi(5);
      }
      
      internal function frame399() : *
      {
         parent.$mc_ctrler.fire("zh1atm",{
            "x":20,
            "y":0,
            "hold":2,
            "hits":1
         });
      }
      
      internal function frame403() : *
      {
         parent.$mc_ctrler.fire("zh12atm",{
            "x":20,
            "y":0,
            "hold":2,
            "hits":1
         });
      }
      
      internal function frame407() : *
      {
         parent.$mc_ctrler.fire("zh14atm",{
            "x":20,
            "y":0,
            "hold":2,
            "hits":1
         });
      }
      
      internal function frame411() : *
      {
         parent.$mc_ctrler.fire("zh13atm",{
            "x":20,
            "y":0,
            "hold":2,
            "hits":1
         });
      }
      
      internal function frame420() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame423() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame450() : *
      {
         parent.$mc_ctrler.addQi(10);
      }
      
      internal function frame451() : *
      {
         parent.$mc_ctrler.movePercent(4,0);
         parent.$mc_ctrler.setHitTarget("zh20atm","招21");
         parent.$effect_ctrler.dash();
      }
      
      internal function frame467() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame469() : *
      {
         parent.$mc_ctrler.dampingPercent(0.4,0);
      }
      
      internal function frame481() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame527() : *
      {
         parent.$effect_ctrler.shine();
         parent.$effect_ctrler.shine(0);
      }
      
      internal function frame531() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame544() : *
      {
         parent.$mc_ctrler.setZhao3("招32");
         parent.$mc_ctrler.setBishaUP();
         parent.$mc_ctrler.setDash();
      }
      
      internal function frame555() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame574() : *
      {
         parent.$mc_ctrler.addQi(5);
      }
      
      internal function frame583() : *
      {
         parent.$effect_ctrler.dash();
      }
      
      internal function frame586() : *
      {
         parent.$mc_ctrler.addQi(5);
      }
      
      internal function frame588() : *
      {
         this.target = parent.$fighter_ctrler.getTargetSP();
         this.moveY = 50;
         if(Boolean(this.target) && !this.target.isInAir)
         {
            this.moveY = 0;
         }
         parent.$fighter_ctrler.moveToTarget(50,this.moveY,true);
         parent.$effect_ctrler.shine();
         parent.$mc_ctrler.movePercent(0.5,-0.5);
         parent.$mc_ctrler.dampingPercent(0.01,0.01);
         parent.$effect_ctrler.slowDown(0.5);
      }
      
      internal function frame592() : *
      {
         parent.$mc_ctrler.movePercent(1,-1);
         parent.$mc_ctrler.dampingPercent(0.02,0.03);
      }
      
      internal function frame617() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame631() : *
      {
         parent.$mc_ctrler.addQi(10);
      }
      
      internal function frame642() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame659() : *
      {
         parent.$mc_ctrler.addQi(20);
      }
      
      internal function frame704() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame718() : *
      {
         parent.$effect_ctrler.bisha(false,"卡卡西1");
      }
      
      internal function frame734() : *
      {
         parent.$effect_ctrler.endBisha();
         parent.$mc_ctrler.addAttacker("shuilong",{"applyG":false});
      }
      
      internal function frame736() : *
      {
         parent.$effect_ctrler.shine(2676984);
      }
      
      internal function frame747() : *
      {
         parent.$effect_ctrler.shine();
      }
      
      internal function frame757() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame771() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame783() : *
      {
         parent.$effect_ctrler.bisha(false,"卡卡西2");
      }
      
      internal function frame819() : *
      {
         parent.$effect_ctrler.endBisha();
      }
      
      internal function frame820() : *
      {
         parent.$mc_ctrler.movePercent(3,0);
         parent.$mc_ctrler.setHitTarget("bs0atm","必杀2");
         parent.$effect_ctrler.shadow(50,50,255);
         parent.$effect_ctrler.dash();
      }
      
      internal function frame834() : *
      {
         parent.$mc_ctrler.dampingPercent(0.3,0);
      }
      
      internal function frame845() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame851() : *
      {
      }
      
      internal function frame867() : *
      {
         parent.$effect_ctrler.shine(16777215);
      }
      
      internal function frame877() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame891() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame913() : *
      {
         parent.$effect_ctrler.bisha(true,"卡卡西3");
      }
      
      internal function frame933() : *
      {
         parent.$effect_ctrler.endBisha();
         parent.$effect_ctrler.slowDown(0.5);
      }
      
      internal function frame934() : *
      {
         parent.$mc_ctrler.addAttacker("shenwei",{
            "x":{
               "followTarget":true,
               "offset":0
            },
            "y":{
               "followTarget":true,
               "offset":-20
            },
            "applyG":false
         });
      }
      
      internal function frame999() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame1210() : *
      {
         parent.$mc_ctrler.movePercent(0.8,0);
      }
      
      internal function frame1214() : *
      {
         parent.$mc_ctrler.stopMove();
      }
      
      internal function frame1215() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame1235() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame1310() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame1351() : *
      {
         parent.$mc_ctrler.stop();
      }
      
      internal function frame1379() : *
      {
         parent.$mc_ctrler.stop();
      }
   }
}

