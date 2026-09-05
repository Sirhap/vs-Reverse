package konan_fla
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol561")]
   public dynamic class 卡卡西_1 extends MovieClip
   {
      
      public var AImain:MovieClip;
      
      public var aabb:MovieClip;
      
      public var bdmn:MovieClip;
      
      public var bsatm:MovieClip;
      
      public var cbs1atm:MovieClip;
      
      public var cbsatm:MovieClip;
      
      public var k1atm:MovieClip;
      
      public var k2atm:MovieClip;
      
      public var k3atm:MovieClip;
      
      public var kj12atm:MovieClip;
      
      public var kj1atm:MovieClip;
      
      public var kj2atm:MovieClip;
      
      public var sbsmc:MovieClip;
      
      public var sh12atm:MovieClip;
      
      public var sh1atm:MovieClip;
      
      public var sh22atm:MovieClip;
      
      public var sh2atm:MovieClip;
      
      public var tk1atm:MovieClip;
      
      public var tkatm:MovieClip;
      
      public var tz2atm:MovieClip;
      
      public var tz3atm:MovieClip;
      
      public var tz4atm:MovieClip;
      
      public var tzatm:MovieClip;
      
      public var zh1atm:MovieClip;
      
      public var zh2mc:MovieClip;
      
      public var Cbshit:Boolean;
      
      public function 卡卡西_1()
      {
         super();
         addFrameScript(22,this.frame23,29,this.frame30,35,this.frame36,39,this.frame40,77,this.frame78,89,this.frame90,101,this.frame102,107,this.frame108,109,this.frame110,125,this.frame126,150,this.frame151,168,this.frame169,174,this.frame175,177,this.frame178,198,this.frame199,206,this.frame207,209,this.frame210,226,this.frame227,238,this.frame239,246,this.frame247,255,this.frame256,269,this.frame270,276,this.frame277,281,this.frame282,284,this.frame285,291,this.frame292,296,this.frame297,304,this.frame305,329,this.frame330,354,this.frame355,363,this.frame364,372,this.frame373,390,this.frame391,427,this.frame428,442,this.frame443,449,this.frame450,456,this.frame457,465,this.frame466,473,this.frame474,497,this.frame498,500,this.frame501,547,this.frame548,556,this.frame557,569,this.frame570,575,this.frame576,590,this.frame591,600,this.frame601,614,this.frame615,626,this.frame627,649,this.frame650,667,this.frame668,680,this.frame681,683,this.frame684,728,this.frame729,743,this.frame744,749,this
         .frame750,751,this.frame752,766,this.frame767,769,this.frame770,774,this.frame775,787,this.frame788,788,this.frame789,822,this.frame823,823,this.frame824,887,this.frame888,894,this.frame895,903,this.frame904,913,this.frame914,998,this.frame999,1018,this.frame1019,1081,this.frame1082,1185,this.frame1186,1217,this.frame1218);
      }
      
      internal function frame23() : *
      {
         parent.$mc_ctrler.loop("走");
      }
      
      internal function frame30() : *
      {
         parent.$mc_ctrler.dash(3);
         parent.$mc_ctrler.setBisha();
         parent.$mc_ctrler.setBishaUP();
         parent.$mc_ctrler.setBishaSUPER();
      }
      
      internal function frame36() : *
      {
         parent.$mc_ctrler.dashStop();
      }
      
      internal function frame40() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame78() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame90() : *
      {
         parent.$mc_ctrler.setAirMove(true);
      }
      
      internal function frame102() : *
      {
         parent.$mc_ctrler.setBishaAIR();
         parent.$mc_ctrler.setSkillAIR();
      }
      
      internal function frame108() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame110() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame126() : *
      {
         parent.$mc_ctrler.move(-1,-2);
         parent.$mc_ctrler.damping(0.05,0.05);
      }
      
      internal function frame151() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame169() : *
      {
         parent.$mc_ctrler.setAttack("砍2");
         parent.$mc_ctrler.setDash();
      }
      
      internal function frame175() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame178() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame199() : *
      {
         parent.$mc_ctrler.setBishaSUPER();
         parent.$mc_ctrler.setSkill1();
         parent.$mc_ctrler.setAttack("砍3");
      }
      
      internal function frame207() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame210() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame227() : *
      {
         parent.$mc_ctrler.movePercent(0.5,0);
         parent.$mc_ctrler.dampingPercent(0.05,0);
      }
      
      internal function frame239() : *
      {
         parent.$mc_ctrler.setBisha();
         parent.$mc_ctrler.setZhao2();
         parent.$mc_ctrler.setZhao1();
      }
      
      internal function frame247() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame256() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame270() : *
      {
         parent.$mc_ctrler.addQi(10);
         parent.$mc_ctrler.movePercent(1.5,0);
         parent.$mc_ctrler.dampingPercent(0.15,0);
      }
      
      internal function frame277() : *
      {
         parent.$mc_ctrler.setBishaSUPER();
         parent.$mc_ctrler.setSkill2();
         parent.$mc_ctrler.setAttack("砍技12");
         parent.$mc_ctrler.setZhao1();
      }
      
      internal function frame282() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame285() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame292() : *
      {
         parent.$mc_ctrler.movePercent(1,0);
         parent.$mc_ctrler.dampingPercent(0.2,0);
      }
      
      internal function frame297() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame305() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame330() : *
      {
         parent.$mc_ctrler.addQi(10);
      }
      
      internal function frame355() : *
      {
         parent.$mc_ctrler.setBisha();
         parent.$mc_ctrler.setJump();
         parent.$mc_ctrler.setZhao1();
      }
      
      internal function frame364() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame373() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame391() : *
      {
         parent.$mc_ctrler.addQi(5);
      }
      
      internal function frame428() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame443() : *
      {
         parent.$mc_ctrler.addQi(10);
      }
      
      internal function frame450() : *
      {
         parent.$effect_ctrler.shine();
         parent.$mc_ctrler.addAttacker("zh2mc",{
            "x":{
               "moveToTarget":true,
               "offset":0
            },
            "applyG":false
         });
      }
      
      internal function frame457() : *
      {
         parent.$mc_ctrler.setBishaUP();
         parent.$mc_ctrler.setSkill2();
         parent.$mc_ctrler.setZhao1();
      }
      
      internal function frame466() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame474() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame498() : *
      {
         parent.$mc_ctrler.addQi(10);
      }
      
      internal function frame501() : *
      {
         parent.$mc_ctrler.addAttacker("aabb",{
            "x":{
               "moveToTarget":true,
               "offset":0
            },
            "y":{
               "moveToTarget":true,
               "offset":-20
            },
            "applyG":false
         });
      }
      
      internal function frame548() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame557() : *
      {
         parent.$mc_ctrler.addQi(10);
      }
      
      internal function frame570() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame576() : *
      {
         parent.$mc_ctrler.addQi(10);
      }
      
      internal function frame591() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame601() : *
      {
         parent.$effect_ctrler.bisha(false,"小南1");
      }
      
      internal function frame615() : *
      {
         parent.$effect_ctrler.endBisha();
      }
      
      internal function frame627() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame650() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame668() : *
      {
         parent.$effect_ctrler.bisha(false,"小南1");
      }
      
      internal function frame681() : *
      {
         parent.$effect_ctrler.endBisha();
      }
      
      internal function frame684() : *
      {
         parent.$mc_ctrler.addAttacker("sbsmc",{
            "x":{
               "followTarget":true,
               "offset":0
            },
            "y":{
               "followTarget":true,
               "offset":0
            },
            "applyG":false
         });
      }
      
      internal function frame729() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame744() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame750() : *
      {
         parent.$effect_ctrler.shine(16409859);
      }
      
      internal function frame752() : *
      {
         parent.$effect_ctrler.bisha(false,"小南2");
      }
      
      internal function frame767() : *
      {
         parent.$effect_ctrler.endBisha();
      }
      
      internal function frame770() : *
      {
         gotoAndPlay("超必杀2");
      }
      
      internal function frame775() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame788() : *
      {
         this.Cbshit = false;
      }
      
      internal function frame789() : *
      {
         parent.$effect_ctrler.bisha(true,"小南2");
      }
      
      internal function frame823() : *
      {
         parent.$effect_ctrler.endBisha();
      }
      
      internal function frame824() : *
      {
         parent.$effect_ctrler.shine();
         parent.$mc_ctrler.move(0,-20);
         parent.$mc_ctrler.damping(0,0.8);
         parent.$mc_ctrler.isApplyG(false);
      }
      
      internal function frame888() : *
      {
         parent.$mc_ctrler.move(15,25);
         parent.$mc_ctrler.setTouchFloor("超必杀3",true);
      }
      
      internal function frame895() : *
      {
         parent.$mc_ctrler.stop();
      }
      
      internal function frame904() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame914() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame999() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame1019() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame1082() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame1186() : *
      {
         parent.$mc_ctrler.stop();
      }
      
      internal function frame1218() : *
      {
         parent.$mc_ctrler.stop();
      }
   }
}

