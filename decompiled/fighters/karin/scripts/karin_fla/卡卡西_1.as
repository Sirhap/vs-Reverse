package karin_fla
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol425")]
   public dynamic class 卡卡西_1 extends MovieClip
   {
      
      public var AImain:MovieClip;
      
      public var bdmn:MovieClip;
      
      public var k1atm:MovieClip;
      
      public var k2atm:MovieClip;
      
      public var k3atm:MovieClip;
      
      public var k4atm:MovieClip;
      
      public var kj1atm:MovieClip;
      
      public var kj21atm:MovieClip;
      
      public var kj22atm:MovieClip;
      
      public var kj2atm:MovieClip;
      
      public var sbsatm:MovieClip;
      
      public var sh12atm:MovieClip;
      
      public var sh1atm:MovieClip;
      
      public var sh22atm:MovieClip;
      
      public var sh2atm:MovieClip;
      
      public var tkatm:MovieClip;
      
      public var tzatm:MovieClip;
      
      public var zh11atm:MovieClip;
      
      public var zh1atm:MovieClip;
      
      public var zh2atm:MovieClip;
      
      public var zh3atm:MovieClip;
      
      public var zzz:MovieClip;
      
      public var zzz2:MovieClip;
      
      public var loops:int;
      
      public function 卡卡西_1()
      {
         super();
         addFrameScript(11,this.frame12,18,this.frame19,24,this.frame25,31,this.frame32,35,this.frame36,73,this.frame74,89,this.frame90,107,this.frame108,113,this.frame114,123,this.frame124,129,this.frame130,131,this.frame132,150,this.frame151,164,this.frame165,170,this.frame171,175,this.frame176,178,this.frame179,187,this.frame188,195,this.frame196,200,this.frame201,206,this.frame207,214,this.frame215,225,this.frame226,233,this.frame234,242,this.frame243,245,this.frame246,256,this.frame257,262,this.frame263,270,this.frame271,287,this.frame288,297,this.frame298,301,this.frame302,317,this.frame318,342,this.frame343,349,this.frame350,357,this.frame358,358,this.frame359,367,this.frame368,374,this.frame375,382,this.frame383,400,this.frame401,403,this.frame404,406,this.frame407,409,this.frame410,429,this.frame430,444,this.frame445,453,this.frame454,464,this.frame465,470,this.frame471,477,this.frame478,494,this.frame495,498,this.frame499,521,this.frame522,530,this.frame531,543,this.frame544,550,this.frame551
         ,568,this.frame569,579,this.frame580,622,this.frame623,626,this.frame627,634,this.frame635,652,this.frame653,669,this.frame670,717,this.frame718,727,this.frame728,734,this.frame735,735,this.frame736,743,this.frame744,752,this.frame753,760,this.frame761,805,this.frame806,863,this.frame864,865,this.frame866,872,this.frame873,881,this.frame882,896,this.frame897,948,this.frame949,1038,this.frame1039,1057,this.frame1058,1084,this.frame1085,1134,this.frame1135,1218,this.frame1219,1250,this.frame1251);
      }
      
      internal function frame12() : *
      {
         parent.$effect_ctrler.walk();
      }
      
      internal function frame19() : *
      {
         parent.$mc_ctrler.loop("走");
      }
      
      internal function frame25() : *
      {
         parent.$mc_ctrler.dash(3);
         parent.$mc_ctrler.setBisha();
         parent.$mc_ctrler.setBishaUP();
         parent.$mc_ctrler.setBishaSUPER();
         parent.$effect_ctrler.dash();
      }
      
      internal function frame32() : *
      {
         parent.$mc_ctrler.dashStop();
         parent.$mc_ctrler.move(0,0);
      }
      
      internal function frame36() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame74() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame90() : *
      {
         parent.$mc_ctrler.move(7,-1);
         parent.$mc_ctrler.damping(0.3,0.05);
      }
      
      internal function frame108() : *
      {
         parent.$mc_ctrler.setBishaAIR();
         parent.$mc_ctrler.setSkillAIR();
      }
      
      internal function frame114() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame124() : *
      {
         parent.$mc_ctrler.move(0,-4);
      }
      
      internal function frame130() : *
      {
         parent.$mc_ctrler.move(-10,-10);
         parent.$mc_ctrler.damping(1,1);
      }
      
      internal function frame132() : *
      {
         parent.$mc_ctrler.fire("tzatm",{
            "x":12,
            "y":12,
            "hold":3,
            "hits":3
         });
      }
      
      internal function frame151() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame165() : *
      {
         parent.$mc_ctrler.movePercent(1,0);
         parent.$mc_ctrler.dampingPercent(0.1,0);
      }
      
      internal function frame171() : *
      {
         parent.$mc_ctrler.setAttack("砍2");
         parent.$mc_ctrler.setDash();
      }
      
      internal function frame176() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame179() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame188() : *
      {
         parent.$mc_ctrler.movePercent(1,0);
         parent.$mc_ctrler.dampingPercent(0.1,0);
      }
      
      internal function frame196() : *
      {
         parent.$mc_ctrler.setBishaSUPER();
         parent.$mc_ctrler.setSkill2();
         parent.$mc_ctrler.setAttack("砍3");
      }
      
      internal function frame201() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame207() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame215() : *
      {
         parent.$mc_ctrler.movePercent(1,0);
         parent.$mc_ctrler.dampingPercent(0.05,0);
      }
      
      internal function frame226() : *
      {
         parent.$mc_ctrler.setBishaSUPER();
         parent.$mc_ctrler.setBishaUP();
         parent.$mc_ctrler.setBisha();
         parent.$mc_ctrler.setZhao2();
         parent.$mc_ctrler.setSkill2("砍技21");
         parent.$mc_ctrler.setAttack("砍4");
         parent.$mc_ctrler.setZhao1();
         parent.$mc_ctrler.setDash();
      }
      
      internal function frame234() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame243() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame246() : *
      {
         parent.$mc_ctrler.movePercent(1,0);
         parent.$mc_ctrler.dampingPercent(0.1,0);
      }
      
      internal function frame257() : *
      {
         parent.$mc_ctrler.setBishaSUPER();
         parent.$mc_ctrler.setBisha();
         parent.$mc_ctrler.setZhao1();
      }
      
      internal function frame263() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame271() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame288() : *
      {
         parent.$mc_ctrler.addQi(10);
      }
      
      internal function frame298() : *
      {
         parent.$effect_ctrler.dash();
      }
      
      internal function frame302() : *
      {
         parent.$fighter_ctrler.moveToTarget(30,0,true);
         parent.$effect_ctrler.slowDown(0.5);
      }
      
      internal function frame318() : *
      {
         parent.$mc_ctrler.gotoAndPlay("砍2");
      }
      
      internal function frame343() : *
      {
         parent.$mc_ctrler.addQi(5);
         parent.$mc_ctrler.movePercent(1,0);
         parent.$mc_ctrler.dampingPercent(0.1,0);
      }
      
      internal function frame350() : *
      {
         parent.$mc_ctrler.movePercent(1,0);
         parent.$mc_ctrler.dampingPercent(0.1,0);
      }
      
      internal function frame358() : *
      {
         parent.$mc_ctrler.movePercent(1,0);
         parent.$mc_ctrler.dampingPercent(0.1,0);
      }
      
      internal function frame359() : *
      {
         parent.$mc_ctrler.addQi(5);
      }
      
      internal function frame368() : *
      {
         parent.$mc_ctrler.setBisha();
         parent.$mc_ctrler.setZhao3();
         parent.$mc_ctrler.setJump();
      }
      
      internal function frame375() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame383() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame401() : *
      {
         parent.$mc_ctrler.addQi(5);
      }
      
      internal function frame404() : *
      {
         parent.$mc_ctrler.fire("zh1atm",{
            "x":{"start":20},
            "y":0,
            "hold":2,
            "hits":1
         });
      }
      
      internal function frame407() : *
      {
         parent.$mc_ctrler.fire("zh1atm",{
            "x":{"start":20},
            "y":0,
            "hold":2,
            "hits":1
         });
      }
      
      internal function frame410() : *
      {
         parent.$mc_ctrler.fire("zh11atm",{
            "x":{"start":20},
            "y":0,
            "hold":2,
            "hits":1
         });
      }
      
      internal function frame430() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame445() : *
      {
         parent.$mc_ctrler.addQi(10);
      }
      
      internal function frame454() : *
      {
         parent.$effect_ctrler.shine();
      }
      
      internal function frame465() : *
      {
         parent.$mc_ctrler.setBisha();
         parent.$mc_ctrler.setZhao3();
      }
      
      internal function frame471() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame478() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame495() : *
      {
         parent.$mc_ctrler.addQi(10);
      }
      
      internal function frame499() : *
      {
         parent.$mc_ctrler.fire("zh3atm",{
            "x":10,
            "y":{
               "start":0,
               "min":-12,
               "add":-0.5
            },
            "hold":2,
            "hits":3
         });
      }
      
      internal function frame522() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame531() : *
      {
         parent.$mc_ctrler.addQi(10);
      }
      
      internal function frame544() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame551() : *
      {
         parent.$mc_ctrler.addQi(20);
      }
      
      internal function frame569() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame580() : *
      {
         parent.$effect_ctrler.bisha(false,"香磷1");
      }
      
      internal function frame623() : *
      {
         parent.$effect_ctrler.endBisha();
      }
      
      internal function frame627() : *
      {
         parent.$effect_ctrler.shine();
         parent.$mc_ctrler.addAttacker("zzz",{
            "x":{
               "moveToTarget":true,
               "offset":0
            },
            "y":{"moveToTarget":true},
            "applyG":false
         });
      }
      
      internal function frame635() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame653() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame670() : *
      {
         parent.$effect_ctrler.bisha(false,"香磷1");
      }
      
      internal function frame718() : *
      {
         parent.$effect_ctrler.endBisha();
      }
      
      internal function frame728() : *
      {
         this.loops = 0;
      }
      
      internal function frame735() : *
      {
         parent.$effect_ctrler.shine(11401981);
      }
      
      internal function frame736() : *
      {
         parent.$fighter_ctrler.addHpPercent(0.03);
      }
      
      internal function frame744() : *
      {
         parent.$mc_ctrler.setAllAct();
      }
      
      internal function frame753() : *
      {
         if(++this.loops < 10)
         {
            parent.$mc_ctrler.loop("上必杀2");
         }
      }
      
      internal function frame761() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame806() : *
      {
         parent.$effect_ctrler.bisha(true,"香磷2");
      }
      
      internal function frame864() : *
      {
         parent.$effect_ctrler.endBisha();
      }
      
      internal function frame866() : *
      {
         parent.$effect_ctrler.shine();
         parent.$mc_ctrler.addAttacker("zzz",{
            "x":{
               "moveToTarget":true,
               "offset":0
            },
            "y":{"moveToTarget":false},
            "applyG":false
         });
      }
      
      internal function frame873() : *
      {
         parent.$mc_ctrler.justHitToPlay("cbs1","超必杀2",false);
      }
      
      internal function frame882() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame897() : *
      {
         parent.$mc_ctrler.addAttacker("zzz2",{"applyG":false});
      }
      
      internal function frame949() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame1039() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame1058() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame1085() : *
      {
         parent.$effect_ctrler.shine(11401981);
      }
      
      internal function frame1135() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame1219() : *
      {
         parent.$mc_ctrler.stop();
      }
      
      internal function frame1251() : *
      {
         parent.$mc_ctrler.stop();
      }
   }
}

