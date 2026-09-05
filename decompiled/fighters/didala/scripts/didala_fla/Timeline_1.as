package didala_fla
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol524")]
   public dynamic class Timeline_1 extends MovieClip
   {
      
      public var k4atm:MovieClip;
      
      public var cbsatm:MovieClip;
      
      public var sh22atm:MovieClip;
      
      public var zh3atm:MovieClip;
      
      public var tzatm:MovieClip;
      
      public var sbsatm:MovieClip;
      
      public var sh12atm:MovieClip;
      
      public var zh2atm:MovieClip;
      
      public var sbs1atm:MovieClip;
      
      public var cbs1atm:MovieClip;
      
      public var zh21atm:MovieClip;
      
      public var sh1atm:MovieClip;
      
      public var bdmn:MovieClip;
      
      public var sh2atm:MovieClip;
      
      public var kj21atm:MovieClip;
      
      public var AImain:MovieClip;
      
      public var bsatm:MovieClip;
      
      public var kj1atm:MovieClip;
      
      public var k1atm:MovieClip;
      
      public var bs2atm:MovieClip;
      
      public var k3atm:MovieClip;
      
      public var kj2atm:MovieClip;
      
      public var k2atm:MovieClip;
      
      public var zh1atm:MovieClip;
      
      public var tkatm:MovieClip;
      
      public function Timeline_1()
      {
         super();
         addFrameScript(13,this.frame14,21,this.frame22,26,this.frame27,32,this.frame33,35,this.frame36,43,this.frame44,69,this.frame70,79,this.frame80,86,this.frame87,91,this.frame92,96,this.frame97,98,this.frame99,115,this.frame116,129,this.frame130,135,this.frame136,142,this.frame143,147,this.frame148,153,this.frame154,158,this.frame159,160,this.frame161,167,this.frame168,173,this.frame174,179,this.frame180,185,this.frame186,194,this.frame195,200,this.frame201,209,this.frame210,213,this.frame214,215,this.frame216,228,this.frame229,234,this.frame235,245,this.frame246,250,this.frame251,251,this.frame252,257,this.frame258,259,this.frame260,265,this.frame266,269,this.frame270,270,this.frame271,275,this.frame276,277,this.frame278,283,this.frame284,289,this.frame290,300,this.frame301,303,this.frame304,320,this.frame321,325,this.frame326,339,this.frame340,359,this.frame360,367,this.frame368,378,this.frame379,380,this.frame381,381,this.frame382,395,this.frame396,403,this.frame404,411,this.frame412,426
         ,this.frame427,433,this.frame434,470,this.frame471,480,this.frame481,499,this.frame500,500,this.frame501,538,this.frame539,545,this.frame546,569,this.frame570,582,this.frame583,584,this.frame585,620,this.frame621,621,this.frame622,653,this.frame654,665,this.frame666,679,this.frame680,710,this.frame711,772,this.frame773,829,this.frame830,835,this.frame836,843,this.frame844,848,this.frame849,873,this.frame874,955,this.frame956,981,this.frame982,1073,this.frame1074,1114,this.frame1115,1142,this.frame1143);
      }
      
      internal function frame14() : *
      {
         parent.$effect_ctrler.walk();
      }
      
      internal function frame22() : *
      {
         parent.$effect_ctrler.walk();
      }
      
      internal function frame27() : *
      {
         parent.$mc_ctrler.loop("走");
      }
      
      internal function frame33() : *
      {
         parent.$mc_ctrler.movePercent(6,0);
      }
      
      internal function frame36() : *
      {
         parent.$mc_ctrler.stopMove();
      }
      
      internal function frame44() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame70() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame80() : *
      {
         parent.$mc_ctrler.setAirMove(true);
      }
      
      internal function frame87() : *
      {
         parent.$mc_ctrler.setSkillAIR();
         parent.$mc_ctrler.setAttack("跳砍2");
      }
      
      internal function frame92() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame97() : *
      {
         parent.$mc_ctrler.move(0,-2);
         parent.$mc_ctrler.damping(0,0.08);
      }
      
      internal function frame99() : *
      {
         parent.$mc_ctrler.fire("tzatm",{
            "y":15,
            "x":0,
            "hold":2,
            "hits":1
         });
      }
      
      internal function frame116() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame130() : *
      {
         parent.$mc_ctrler.setAttack("砍2");
         parent.$mc_ctrler.setZhao1();
      }
      
      internal function frame136() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame143() : *
      {
         parent.$mc_ctrler.movePercent(0.5,0);
         parent.$mc_ctrler.dampingPercent(0.05,0);
      }
      
      internal function frame148() : *
      {
         parent.$mc_ctrler.setSkill2();
         parent.$mc_ctrler.setAttack("砍3");
         parent.$mc_ctrler.setZhao1();
         parent.$mc_ctrler.setDash();
      }
      
      internal function frame154() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame159() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame161() : *
      {
         parent.$mc_ctrler.movePercent(1.3,0);
         parent.$mc_ctrler.dampingPercent(0.07,0);
      }
      
      internal function frame168() : *
      {
         parent.$mc_ctrler.setBishaSUPER();
         parent.$mc_ctrler.setBisha();
         parent.$mc_ctrler.setSkill1();
         parent.$mc_ctrler.setAttack("砍4");
         parent.$mc_ctrler.setZhao1();
         parent.$mc_ctrler.setDash();
      }
      
      internal function frame174() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame180() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame186() : *
      {
         parent.$mc_ctrler.movePercent(1,0);
         parent.$mc_ctrler.dampingPercent(0.1,0);
      }
      
      internal function frame195() : *
      {
         parent.$mc_ctrler.setBishaUP();
         parent.$mc_ctrler.setZhao3();
      }
      
      internal function frame201() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame210() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame214() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame216() : *
      {
         parent.$mc_ctrler.addQi(10);
      }
      
      internal function frame229() : *
      {
         parent.$mc_ctrler.setBishaUP();
         parent.$mc_ctrler.setZhao3();
         parent.$mc_ctrler.setJump();
      }
      
      internal function frame235() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame246() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame251() : *
      {
         parent.$mc_ctrler.addQi(10);
      }
      
      internal function frame252() : *
      {
         parent.$mc_ctrler.movePercent(2.5,0);
         parent.$mc_ctrler.dampingPercent(0.25,0);
         parent.$effect_ctrler.shadow(200,200,200);
      }
      
      internal function frame258() : *
      {
         parent.$effect_ctrler.endShadow();
      }
      
      internal function frame260() : *
      {
         parent.$mc_ctrler.setBishaSUPER();
         parent.$mc_ctrler.setBisha();
         parent.$mc_ctrler.setSkill1();
         parent.$mc_ctrler.setAttack("砍技21");
         parent.$mc_ctrler.setDash();
      }
      
      internal function frame266() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame270() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame271() : *
      {
         parent.$effect_ctrler.shadow(200,200,200);
      }
      
      internal function frame276() : *
      {
         parent.$effect_ctrler.endShadow();
      }
      
      internal function frame278() : *
      {
         parent.$mc_ctrler.setAttack("砍4");
      }
      
      internal function frame284() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame290() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame301() : *
      {
         parent.$mc_ctrler.addQi(5);
      }
      
      internal function frame304() : *
      {
         parent.$mc_ctrler.fire("zh1atm",{
            "x":20,
            "y":{
               "start":0,
               "max":10,
               "add":0.1
            },
            "hold":2,
            "hits":1
         });
      }
      
      internal function frame321() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame326() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame340() : *
      {
         parent.$mc_ctrler.addQi(10);
      }
      
      internal function frame360() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame368() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame379() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame381() : *
      {
         parent.$mc_ctrler.addQi(5);
      }
      
      internal function frame382() : *
      {
         parent.$mc_ctrler.fire("zh3atm",{
            "y":-15,
            "x":15,
            "hold":2,
            "hits":1
         });
      }
      
      internal function frame396() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame404() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame412() : *
      {
         parent.$mc_ctrler.addQi(10);
      }
      
      internal function frame427() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame434() : *
      {
         parent.$mc_ctrler.addQi(20);
      }
      
      internal function frame471() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame481() : *
      {
         parent.$effect_ctrler.bisha(false,"迪达拉1");
      }
      
      internal function frame500() : *
      {
         parent.$effect_ctrler.endBisha();
      }
      
      internal function frame501() : *
      {
         parent.$mc_ctrler.movePercent(1.4,0);
         parent.$effect_ctrler.shadow(200,200,200);
      }
      
      internal function frame539() : *
      {
         parent.$mc_ctrler.stopMove();
         parent.$effect_ctrler.endShadow();
      }
      
      internal function frame546() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame570() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame583() : *
      {
         parent.$effect_ctrler.shine();
      }
      
      internal function frame585() : *
      {
         parent.$effect_ctrler.bisha(false,"迪达拉1");
      }
      
      internal function frame621() : *
      {
         parent.$effect_ctrler.endBisha();
      }
      
      internal function frame622() : *
      {
         parent.$effect_ctrler.shadow(100,100,100);
      }
      
      internal function frame654() : *
      {
         parent.$effect_ctrler.endShadow();
      }
      
      internal function frame666() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame680() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame711() : *
      {
         parent.$effect_ctrler.bisha(true,"迪达拉2");
      }
      
      internal function frame773() : *
      {
         parent.$effect_ctrler.endBisha();
      }
      
      internal function frame830() : *
      {
         parent.$fighter_ctrler.moveOnce(0,-250);
      }
      
      internal function frame836() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame844() : *
      {
         parent.$effect_ctrler.shine();
         parent.$effect_ctrler.shine(303095);
      }
      
      internal function frame849() : *
      {
         doZhaoHuan();
      }
      
      internal function frame874() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame956() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame982() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame1074() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame1115() : *
      {
         parent.$mc_ctrler.stop();
      }
      
      internal function frame1143() : *
      {
         parent.$mc_ctrler.stop();
      }
   }
}

