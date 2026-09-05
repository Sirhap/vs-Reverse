package uryuu_fla
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol387")]
   public dynamic class Timeline_1 extends MovieClip
   {
      
      public var sh23atm:MovieClip;
      
      public var cbsatm:MovieClip;
      
      public var sh22atm:MovieClip;
      
      public var zh3atm:MovieClip;
      
      public var tzatm:MovieClip;
      
      public var sbsatm:MovieClip;
      
      public var sh12atm:MovieClip;
      
      public var cbs1atm:MovieClip;
      
      public var sh1atm:MovieClip;
      
      public var cbs2atm:MovieClip;
      
      public var bdmn:MovieClip;
      
      public var k31atm:MovieClip;
      
      public var sh2atm:MovieClip;
      
      public var AImain:MovieClip;
      
      public var bsatm:MovieClip;
      
      public var k32atm:MovieClip;
      
      public var kj1atm:MovieClip;
      
      public var k1atm:MovieClip;
      
      public var k3atm:MovieClip;
      
      public var kj2atm:MovieClip;
      
      public var k2atm:MovieClip;
      
      public var jian:MovieClip;
      
      public var zh1atm:MovieClip;
      
      public var tkatm:MovieClip;
      
      public function Timeline_1()
      {
         super();
         addFrameScript(15,this.frame16,24,this.frame25,26,this.frame27,30,this.frame31,37,this.frame38,42,this.frame43,70,this.frame71,80,this.frame81,85,this.frame86,90,this.frame91,95,this.frame96,97,this.frame98,103,this.frame104,108,this.frame109,109,this.frame110,118,this.frame119,132,this.frame133,148,this.frame149,154,this.frame155,160,this.frame161,166,this.frame167,170,this.frame171,179,this.frame180,184,this.frame185,192,this.frame193,203,this.frame204,213,this.frame214,216,this.frame217,222,this.frame223,229,this.frame230,241,this.frame242,251,this.frame252,253,this.frame254,255,this.frame256,263,this.frame264,285,this.frame286,292,this.frame293,302,this.frame303,310,this.frame311,326,this.frame327,328,this.frame329,335,this.frame336,340,this.frame341,348,this.frame349,361,this.frame362,363,this.frame364,370,this.frame371,378,this.frame379,384,this.frame385,400,this.frame401,433,this.frame434,443,this.frame444,451,this.frame452,463,this.frame464,474,this.frame475,510,this.frame511,525
         ,this.frame526,549,this.frame550,550,this.frame551,569,this.frame570,577,this.frame578,606,this.frame607,610,this.frame611,621,this.frame622,629,this.frame630,630,this.frame631,643,this.frame644,664,this.frame665,699,this.frame700,752,this.frame753,765,this.frame766,800,this.frame801,859,this.frame860,926,this.frame927,944,this.frame945,1035,this.frame1036,1059,this.frame1060,1138,this.frame1139,1175,this.frame1176,1198,this.frame1199);
      }
      
      internal function frame16() : *
      {
         parent.$effect_ctrler.walk();
      }
      
      internal function frame25() : *
      {
         parent.$effect_ctrler.walk();
      }
      
      internal function frame27() : *
      {
         parent.$mc_ctrler.loop("走");
      }
      
      internal function frame31() : *
      {
         parent.$mc_ctrler.dash(3);
         parent.$mc_ctrler.setBisha();
         parent.$mc_ctrler.setBishaUP();
         parent.$mc_ctrler.setBishaSUPER();
         parent.$effect_ctrler.shadow(0,150,255);
         parent.$effect_ctrler.dash();
      }
      
      internal function frame38() : *
      {
         parent.$mc_ctrler.dashStop();
      }
      
      internal function frame43() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame71() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame81() : *
      {
         parent.$mc_ctrler.move(0,-2);
         parent.$mc_ctrler.damping(0,0.1);
      }
      
      internal function frame86() : *
      {
         parent.$mc_ctrler.fire("tkatm",{
            "x":15,
            "y":13,
            "hold":0.5,
            "hits":1
         });
      }
      
      internal function frame91() : *
      {
         parent.$mc_ctrler.fire("tkatm",{
            "x":15,
            "y":13,
            "hold":0.5,
            "hits":1
         });
      }
      
      internal function frame96() : *
      {
         parent.$mc_ctrler.fire("tkatm",{
            "x":15,
            "y":13,
            "hold":0.5,
            "hits":1
         });
      }
      
      internal function frame98() : *
      {
         parent.$mc_ctrler.setSkillAIR("跳招");
         parent.$mc_ctrler.setBishaAIR();
      }
      
      internal function frame104() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame109() : *
      {
         parent.$mc_ctrler.move(0,-2);
         parent.$mc_ctrler.damping(0,0.1);
      }
      
      internal function frame110() : *
      {
         parent.$mc_ctrler.addQi(5);
      }
      
      internal function frame119() : *
      {
         parent.$mc_ctrler.move(-2,-2);
         parent.$mc_ctrler.damping(0.1,0.1);
         parent.$mc_ctrler.fire("tzatm",{
            "x":20,
            "y":10,
            "hold":1,
            "hits":1
         });
      }
      
      internal function frame133() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame149() : *
      {
         parent.$mc_ctrler.fire("k1atm",{
            "x":15,
            "y":0,
            "hold":0.3,
            "hits":1,
            "hp":50
         });
      }
      
      internal function frame155() : *
      {
         parent.$mc_ctrler.setAttack("砍2");
         parent.$mc_ctrler.setZhao1();
         parent.$mc_ctrler.setBisha();
      }
      
      internal function frame161() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame167() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame171() : *
      {
         parent.$mc_ctrler.move(15,0);
         parent.$mc_ctrler.damping(1.5,0);
      }
      
      internal function frame180() : *
      {
         parent.$mc_ctrler.fire("k2atm",{
            "x":15,
            "y":0,
            "hold":0.5,
            "hits":1
         });
      }
      
      internal function frame185() : *
      {
         parent.$mc_ctrler.setAttack("砍3");
         parent.$mc_ctrler.setZhao1();
         parent.$mc_ctrler.setZhao3();
         parent.$mc_ctrler.setSkill1();
         parent.$mc_ctrler.setSkill2();
         parent.$mc_ctrler.setBisha();
      }
      
      internal function frame193() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame204() : *
      {
         parent.$mc_ctrler.move(-5,-8);
         parent.$mc_ctrler.damping(0.2,0.5);
      }
      
      internal function frame214() : *
      {
         parent.$mc_ctrler.setTouchFloor("砍32",true);
         parent.$mc_ctrler.fire("k3atm",{
            "x":15,
            "y":5,
            "hold":0.5,
            "hits":1,
            "hp":50
         });
         parent.$mc_ctrler.fire("k31atm",{
            "x":18,
            "y":2,
            "hold":0.5,
            "hits":1,
            "hp":50
         });
         parent.$mc_ctrler.fire("k32atm",{
            "x":12,
            "y":8,
            "hold":0.5,
            "hits":1,
            "hp":50
         });
      }
      
      internal function frame217() : *
      {
         parent.$mc_ctrler.setSkillAIR("跳招");
         parent.$mc_ctrler.setBishaAIR();
      }
      
      internal function frame223() : *
      {
         parent.$mc_ctrler.stop();
      }
      
      internal function frame230() : *
      {
         parent.$mc_ctrler.setZhao3();
         parent.$mc_ctrler.setSkill2();
         parent.$mc_ctrler.setBishaSUPER();
      }
      
      internal function frame242() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame252() : *
      {
         parent.$effect_ctrler.slowDown(0.5);
         parent.$effect_ctrler.shadow(0,150,255);
         parent.$effect_ctrler.dash();
      }
      
      internal function frame254() : *
      {
         parent.$fighter_ctrler.moveToTarget(100,-40,true);
      }
      
      internal function frame256() : *
      {
         parent.$mc_ctrler.move(-5,-1);
      }
      
      internal function frame264() : *
      {
         parent.$mc_ctrler.move(-10,-5);
         parent.$mc_ctrler.damping(0.2,0.2);
         parent.$effect_ctrler.endShadow();
      }
      
      internal function frame286() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame293() : *
      {
         parent.$mc_ctrler.addQi(10);
      }
      
      internal function frame303() : *
      {
         parent.$effect_ctrler.shine(11382189);
      }
      
      internal function frame311() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame327() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame329() : *
      {
         parent.$mc_ctrler.addQi(5);
      }
      
      internal function frame336() : *
      {
         parent.$mc_ctrler.fire("zh1atm",{
            "x":30,
            "y":0,
            "hold":1,
            "hits":1
         });
      }
      
      internal function frame341() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame349() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame362() : *
      {
         parent.$mc_ctrler.addQi(10);
      }
      
      internal function frame364() : *
      {
         parent.$mc_ctrler.movePercent(1,-1.5);
         parent.$mc_ctrler.dampingPercent(0.05,0);
      }
      
      internal function frame371() : *
      {
         parent.$mc_ctrler.setAttackAIR();
         parent.$mc_ctrler.setSkillAIR();
         parent.$mc_ctrler.setBishaAIR();
         parent.$mc_ctrler.dampingPercent(0.1,0.1);
      }
      
      internal function frame379() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame385() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame401() : *
      {
         parent.$mc_ctrler.addQi(5);
      }
      
      internal function frame434() : *
      {
         parent.$mc_ctrler.addAttacker("jian",{
            "x":{
               "moveToTarget":true,
               "offset":0
            },
            "y":{
               "moveToTarget":true,
               "offset":-500
            },
            "applyG":true
         });
      }
      
      internal function frame444() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame452() : *
      {
         parent.$mc_ctrler.addQi(15);
      }
      
      internal function frame464() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame475() : *
      {
         parent.$mc_ctrler.addQi(15);
      }
      
      internal function frame511() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame526() : *
      {
         parent.$effect_ctrler.bisha(false,"石田1");
      }
      
      internal function frame550() : *
      {
         parent.$effect_ctrler.endBisha();
      }
      
      internal function frame551() : *
      {
         parent.$mc_ctrler.move(-15,0);
         parent.$mc_ctrler.damping(2,0);
      }
      
      internal function frame570() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame578() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame607() : *
      {
         parent.$fighter_ctrler.moveToTarget(0,-200,true);
      }
      
      internal function frame611() : *
      {
         parent.$effect_ctrler.bisha(false,"石田2");
      }
      
      internal function frame622() : *
      {
         parent.$effect_ctrler.shine();
      }
      
      internal function frame630() : *
      {
         parent.$effect_ctrler.endBisha();
      }
      
      internal function frame631() : *
      {
         parent.$mc_ctrler.move(0,-15);
         parent.$mc_ctrler.damping(0,0.5);
      }
      
      internal function frame644() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame665() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame700() : *
      {
         parent.$effect_ctrler.bisha(true,"石田2");
      }
      
      internal function frame753() : *
      {
         parent.$fighter_ctrler.moveToTarget(0,0,false);
      }
      
      internal function frame766() : *
      {
         parent.$effect_ctrler.endBisha();
      }
      
      internal function frame801() : *
      {
         parent.$effect_ctrler.bisha(false,"石田3");
      }
      
      internal function frame860() : *
      {
         parent.$effect_ctrler.endBisha();
      }
      
      internal function frame927() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame945() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame1036() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame1060() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame1139() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame1176() : *
      {
         parent.$mc_ctrler.stop();
      }
      
      internal function frame1199() : *
      {
         parent.$mc_ctrler.stop();
      }
   }
}

