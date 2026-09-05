package sasuke_fla
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol966")]
   public dynamic class 佐助咒化_12 extends MovieClip
   {
      
      public var AImain:MovieClip;
      
      public var bdmn:MovieClip;
      
      public var bs1atm:MovieClip;
      
      public var bs2atm:MovieClip;
      
      public var bsatm:MovieClip;
      
      public var k1atm:MovieClip;
      
      public var k2atm:MovieClip;
      
      public var k3atm:MovieClip;
      
      public var kj1atm:MovieClip;
      
      public var kj2atm:MovieClip;
      
      public var sbsatm:MovieClip;
      
      public var sh12atm:MovieClip;
      
      public var sh1atm:MovieClip;
      
      public var sh22atm:MovieClip;
      
      public var sh2atm:MovieClip;
      
      public var tkatm:MovieClip;
      
      public var tzatm:MovieClip;
      
      public var zh1atm:MovieClip;
      
      public var zh2atm:MovieClip;
      
      public var zz1:MovieClip;
      
      public function 佐助咒化_12()
      {
         super();
         addFrameScript(15,this.frame16,21,this.frame22,24,this.frame25,29,this.frame30,56,this.frame57,74,this.frame75,79,this.frame80,83,this.frame84,100,this.frame101,109,this.frame110,120,this.frame121,133,this.frame134,138,this.frame139,143,this.frame144,149,this.frame150,159,this.frame160,166,this.frame167,171,this.frame172,180,this.frame181,192,this.frame193,200,this.frame201,207,this.frame208,212,this.frame213,219,this.frame220,220,this.frame221,229,this.frame230,238,this.frame239,248,this.frame249,252,this.frame253,255,this.frame256,265,this.frame266,270,this.frame271,276,this.frame277,278,this.frame279,281,this.frame282,285,this.frame286,296,this.frame297,304,this.frame305,314,this.frame315,315,this.frame316,326,this.frame327,330,this.frame331,342,this.frame343,356,this.frame357,371,this.frame372,374,this.frame375,383,this.frame384,392,this.frame393,424,this.frame425,429,this.frame430,438,this.frame439,442,this.frame443,452,this.frame453,470,this.frame471,493,this.frame494,517,this.frame518
         ,542,this.frame543,546,this.frame547,553,this.frame554,585,this.frame586,588,this.frame589,591,this.frame592,604,this.frame605,616,this.frame617,629,this.frame630,630,this.frame631,632,this.frame633,664,this.frame665,677,this.frame678,693,this.frame694,724,this.frame725,728,this.frame729,734,this.frame735,745,this.frame746,759,this.frame760,860,this.frame861,883,this.frame884,886,this.frame887,903,this.frame904,905,this.frame906,921,this.frame922,937,this.frame938,978,this.frame979,1006,this.frame1007);
      }
      
      internal function frame16() : *
      {
         parent.$mc_ctrler.loop("走");
      }
      
      internal function frame22() : *
      {
         parent.$mc_ctrler.movePercent(8,0);
      }
      
      internal function frame25() : *
      {
         parent.$mc_ctrler.stopMove();
      }
      
      internal function frame30() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame57() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame75() : *
      {
         parent.$mc_ctrler.fire("tkatm",{
            "x":{
               "start":15,
               "add":-0.5,
               "hit":8
            },
            "y":{
               "start":10,
               "add":-0.3,
               "hit":6
            },
            "hold":3,
            "hits":3,
            "hp":200
         });
      }
      
      internal function frame80() : *
      {
         parent.$mc_ctrler.setSkillAIR();
      }
      
      internal function frame84() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame101() : *
      {
         parent.$mc_ctrler.movePercent(-0.5,-0.5);
         parent.$effect_ctrler.shine(16724480);
      }
      
      internal function frame110() : *
      {
         parent.$mc_ctrler.dampingPercent(0.04,0.04);
      }
      
      internal function frame121() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame134() : *
      {
         parent.$mc_ctrler.movePercent(1,0);
         parent.$mc_ctrler.dampingPercent(0.2,0);
      }
      
      internal function frame139() : *
      {
         parent.$mc_ctrler.setAttack("砍2");
         parent.$mc_ctrler.setZhao1();
         parent.$mc_ctrler.setBisha();
      }
      
      internal function frame144() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame150() : *
      {
         parent.$mc_ctrler.movePercent(2,0);
         parent.$mc_ctrler.dampingPercent(0.2,0);
      }
      
      internal function frame160() : *
      {
         parent.$mc_ctrler.setAttack("砍3");
         parent.$mc_ctrler.setZhao1();
         parent.$mc_ctrler.setBisha();
         parent.$mc_ctrler.setDash();
      }
      
      internal function frame167() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame172() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame181() : *
      {
         parent.$mc_ctrler.movePercent(2,0);
         parent.$mc_ctrler.dampingPercent(0.2,0);
      }
      
      internal function frame193() : *
      {
         parent.$mc_ctrler.setBishaUP();
         parent.$mc_ctrler.setBishaSUPER();
         parent.$mc_ctrler.setSkill2();
         parent.$mc_ctrler.setZhao3();
         parent.$mc_ctrler.setDash();
         parent.$mc_ctrler.setJump();
      }
      
      internal function frame201() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame208() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame213() : *
      {
         parent.$mc_ctrler.addQi(10);
         parent.$mc_ctrler.setSteelBody(true);
      }
      
      internal function frame220() : *
      {
         parent.$mc_ctrler.setSteelBody(false);
      }
      
      internal function frame221() : *
      {
         parent.$effect_ctrler.shine(9720574);
      }
      
      internal function frame230() : *
      {
         parent.$mc_ctrler.setBishaUP();
         parent.$mc_ctrler.setZhao3();
         parent.$mc_ctrler.setDash();
      }
      
      internal function frame239() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame249() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame253() : *
      {
         parent.$mc_ctrler.addQi(10);
      }
      
      internal function frame256() : *
      {
         parent.$mc_ctrler.move(-6,0);
         parent.$mc_ctrler.damping(1,0);
         parent.$effect_ctrler.shine();
      }
      
      internal function frame266() : *
      {
         parent.$mc_ctrler.setBishaUP();
         parent.$mc_ctrler.setDash();
         parent.$mc_ctrler.setBishaSUPER();
         parent.$mc_ctrler.setAttack("砍1");
      }
      
      internal function frame271() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame277() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame279() : *
      {
         parent.$mc_ctrler.addQi(10);
      }
      
      internal function frame282() : *
      {
         parent.$mc_ctrler.move(-6,0);
         parent.$mc_ctrler.damping(1,0);
         parent.$effect_ctrler.shine();
      }
      
      internal function frame286() : *
      {
         parent.$mc_ctrler.setBishaUP();
         parent.$mc_ctrler.setDash();
         parent.$mc_ctrler.setBishaSUPER();
         parent.$mc_ctrler.setAttack("砍1");
      }
      
      internal function frame297() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame305() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame315() : *
      {
         parent.$mc_ctrler.addQi(5);
      }
      
      internal function frame316() : *
      {
         parent.$mc_ctrler.fire("zh1atm",{
            "x":{
               "start":20,
               "add":-0.5,
               "hit":8,
               "min":8
            },
            "y":0,
            "hold":3,
            "hits":4,
            "hp":200
         });
      }
      
      internal function frame327() : *
      {
         parent.$mc_ctrler.setBisha();
      }
      
      internal function frame331() : *
      {
         parent.$mc_ctrler.setDash();
      }
      
      internal function frame343() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame357() : *
      {
         parent.$mc_ctrler.addQi(10);
      }
      
      internal function frame372() : *
      {
         parent.$effect_ctrler.shine(9720574);
      }
      
      internal function frame375() : *
      {
         parent.$mc_ctrler.setBishaSUPER();
         parent.$mc_ctrler.setAttack("砍1");
      }
      
      internal function frame384() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame393() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame425() : *
      {
         parent.$mc_ctrler.addQi(5);
      }
      
      internal function frame430() : *
      {
         parent.$mc_ctrler.addAttacker("zz1",{
            "x":{
               "moveToTarget":true,
               "offset":0
            },
            "y":{
               "moveToTarget":false,
               "offset":0
            },
            "applyG":false
         });
      }
      
      internal function frame439() : *
      {
         parent.$mc_ctrler.setJump();
         parent.$mc_ctrler.setSkill2();
         parent.$mc_ctrler.setBisha();
      }
      
      internal function frame443() : *
      {
         parent.$mc_ctrler.setBishaUP();
      }
      
      internal function frame453() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame471() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame494() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame518() : *
      {
         parent.$effect_ctrler.bisha(false,"佐助3");
      }
      
      internal function frame543() : *
      {
         parent.$fighter_ctrler.moveToTarget(-150,0,true);
         parent.$mc_ctrler.isApplyG(false);
      }
      
      internal function frame547() : *
      {
         parent.$effect_ctrler.endBisha();
         parent.$mc_ctrler.movePercent(1,0);
      }
      
      internal function frame554() : *
      {
         parent.$effect_ctrler.shine(118);
      }
      
      internal function frame586() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame589() : *
      {
         parent.$mc_ctrler.isApplyG(true);
      }
      
      internal function frame592() : *
      {
         parent.$mc_ctrler.dampingPercent(0.1,0);
      }
      
      internal function frame605() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame617() : *
      {
         parent.$effect_ctrler.bisha(false,"佐助3");
      }
      
      internal function frame630() : *
      {
         parent.$effect_ctrler.endBisha();
      }
      
      internal function frame631() : *
      {
         parent.$mc_ctrler.movePercent(-1,0);
         parent.$mc_ctrler.dampingPercent(0.1,0);
      }
      
      internal function frame633() : *
      {
         parent.$effect_ctrler.shine(16724480);
      }
      
      internal function frame665() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame678() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame694() : *
      {
         parent.$effect_ctrler.bisha(true,"佐助3");
      }
      
      internal function frame725() : *
      {
         parent.$effect_ctrler.endBisha();
      }
      
      internal function frame729() : *
      {
         parent.$mc_ctrler.addAttacker("zz1",{
            "x":{
               "moveToTarget":true,
               "offset":0
            },
            "y":{
               "moveToTarget":false,
               "offset":0
            },
            "applyG":false
         });
      }
      
      internal function frame735() : *
      {
         parent.$effect_ctrler.shine();
      }
      
      internal function frame746() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame760() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame861() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame884() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame887() : *
      {
         parent.$effect_ctrler.startShake(0,3);
      }
      
      internal function frame904() : *
      {
         parent.$effect_ctrler.endShake();
      }
      
      internal function frame906() : *
      {
         parent.$effect_ctrler.shine();
      }
      
      internal function frame922() : *
      {
         parent.$effect_ctrler.endWanKai();
      }
      
      internal function frame938() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame979() : *
      {
         parent.$mc_ctrler.stop();
      }
      
      internal function frame1007() : *
      {
         parent.$mc_ctrler.stop();
      }
   }
}

