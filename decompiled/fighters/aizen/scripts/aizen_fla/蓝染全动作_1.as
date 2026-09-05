package aizen_fla
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol638")]
   public dynamic class 蓝染全动作_1 extends MovieClip
   {
      
      public var AImain:MovieClip;
      
      public var bdmn:MovieClip;
      
      public var bsmc:MovieClip;
      
      public var cbs2atm:MovieClip;
      
      public var cbsatm:MovieClip;
      
      public var dk:MovieClip;
      
      public var k1atm:MovieClip;
      
      public var k2atm:MovieClip;
      
      public var k3atm:MovieClip;
      
      public var k4atm:MovieClip;
      
      public var k52atm:MovieClip;
      
      public var k5atm:MovieClip;
      
      public var kbsatm:MovieClip;
      
      public var kj1atm:MovieClip;
      
      public var kj20atm:MovieClip;
      
      public var kj21atm:MovieClip;
      
      public var kj2atm:MovieClip;
      
      public var move_mc:MovieClip;
      
      public var sbs1atm:MovieClip;
      
      public var sbs2atm:MovieClip;
      
      public var sbs3atm:MovieClip;
      
      public var sbs4atm:MovieClip;
      
      public var sbsatm:MovieClip;
      
      public var sh12atm:MovieClip;
      
      public var sh1atm:MovieClip;
      
      public var sh22atm:MovieClip;
      
      public var tkatm:MovieClip;
      
      public var tzatm:MovieClip;
      
      public var zh1atm:MovieClip;
      
      public var zh20atm:MovieClip;
      
      public var zh2atm:MovieClip;
      
      public var zh3atm:MovieClip;
      
      public function 蓝染全动作_1()
      {
         super();
         addFrameScript(26,this.frame27,35,this.frame36,39,this.frame40,44,this.frame45,47,this.frame48,77,this.frame78,89,this.frame90,92,this.frame93,98,this.frame99,104,this.frame105,107,this.frame108,116,this.frame117,127,this.frame128,142,this.frame143,156,this.frame157,177,this.frame178,184,this.frame185,190,this.frame191,195,this.frame196,200,this.frame201,206,this.frame207,211,this.frame212,214,this.frame215,220,this.frame221,225,this.frame226,227,this.frame228,233,this.frame234,242,this.frame243,249,this.frame250,253,this.frame254,260,this.frame261,266,this.frame267,271,this.frame272,276,this.frame277,294,this.frame295,301,this.frame302,315,this.frame316,334,this.frame335,338,this.frame339,364,this.frame365,370,this.frame371,375,this.frame376,381,this.frame382,397,this.frame398,430,this.frame431,444,this.frame445,458,this.frame459,469,this.frame470,474,this.frame475,478,this.frame479,485,this.frame486,495,this.frame496,519,this.frame520,523,this.frame524,539,this.frame540,552,this.frame553
         ,570,this.frame571,571,this.frame572,590,this.frame591,594,this.frame595,608,this.frame609,609,this.frame610,620,this.frame621,626,this.frame627,633,this.frame634,658,this.frame659,674,this.frame675,687,this.frame688,692,this.frame693,705,this.frame706,721,this.frame722,725,this.frame726,736,this.frame737,742,this.frame743,746,this.frame747,759,this.frame760,769,this.frame770,778,this.frame779,814,this.frame815,816,this.frame817,872,this.frame873,885,this.frame886,890,this.frame891,927,this.frame928,929,this.frame930,930,this.frame931,937,this.frame938,939,this.frame940,953,this.frame954,959,this.frame960,971,this.frame972,984,this.frame985,1000,this.frame1001,1013,this.frame1014,1030,this.frame1031,1049,this.frame1050,1067,this.frame1068,1083,this.frame1084,1123,this.frame1124,1140,this.frame1141,1146,this.frame1147,1158,this.frame1159,1164,this.frame1165,1186,this.frame1187,1211,this.frame1212,1251,this.frame1252,1410,this.frame1411,1428,this.frame1429,1516,this.frame1517,1536,this.frame1537
         ,1607,this.frame1608,1671,this.frame1672,1715,this.frame1716);
      }
      
      internal function frame27() : *
      {
         parent.$mc_ctrler.loop("走");
      }
      
      internal function frame36() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame40() : *
      {
         parent.$effect_ctrler.dash();
         parent.$mc_ctrler.dash(4);
         parent.$mc_ctrler.setBisha();
         parent.$mc_ctrler.setBishaUP();
         parent.$mc_ctrler.setBishaSUPER();
         parent.$effect_ctrler.dash();
      }
      
      internal function frame45() : *
      {
         parent.$mc_ctrler.dashStop();
      }
      
      internal function frame48() : *
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
      
      internal function frame93() : *
      {
         parent.$mc_ctrler.move(0,-5);
         parent.$mc_ctrler.damping(0,0.3);
      }
      
      internal function frame99() : *
      {
         parent.$mc_ctrler.setSkillAIR();
         parent.$mc_ctrler.setBishaAIR();
      }
      
      internal function frame105() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame108() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame117() : *
      {
         parent.$mc_ctrler.move(0,-1);
      }
      
      internal function frame128() : *
      {
         parent.$fighter_ctrler.moveToTarget(0,0,false);
         parent.$mc_ctrler.stopMove();
      }
      
      internal function frame143() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame157() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame178() : *
      {
         parent.$mc_ctrler.move(0.25,0);
         parent.$mc_ctrler.damping(0.01,0);
      }
      
      internal function frame185() : *
      {
         parent.$mc_ctrler.setAttack("砍2");
      }
      
      internal function frame191() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame196() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame201() : *
      {
         parent.$mc_ctrler.move(0.25,0);
         parent.$mc_ctrler.damping(0.02,0);
      }
      
      internal function frame207() : *
      {
         parent.$mc_ctrler.setSkill2();
         parent.$mc_ctrler.setAttack("砍3");
      }
      
      internal function frame212() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame215() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame221() : *
      {
         parent.$mc_ctrler.movePercent(2,0);
         parent.$mc_ctrler.dampingPercent(0.1,0);
         parent.$fighter_ctrler.setCross(true);
         parent.$effect_ctrler.dash();
      }
      
      internal function frame226() : *
      {
         parent.$fighter_ctrler.setCross(false);
      }
      
      internal function frame228() : *
      {
         parent.$mc_ctrler.setBishaSUPER();
         parent.$mc_ctrler.setBishaUP();
         parent.$mc_ctrler.setBisha();
         parent.$mc_ctrler.setAttack("砍4");
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
      
      internal function frame250() : *
      {
         parent.$fighter_ctrler.setDirectToTarget();
      }
      
      internal function frame254() : *
      {
         parent.$mc_ctrler.movePercent(0.5,0);
         parent.$mc_ctrler.dampingPercent(0.05,0);
      }
      
      internal function frame261() : *
      {
         parent.$mc_ctrler.setZhao1();
         parent.$mc_ctrler.setAttack("砍5");
      }
      
      internal function frame267() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame272() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame277() : *
      {
         parent.$mc_ctrler.movePercent(0.5,0);
         parent.$mc_ctrler.dampingPercent(0.05,0);
      }
      
      internal function frame295() : *
      {
         parent.$mc_ctrler.setBishaUP();
         parent.$mc_ctrler.setZhao3();
         parent.$mc_ctrler.setZhao1();
         parent.$mc_ctrler.setJump();
      }
      
      internal function frame302() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame316() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame335() : *
      {
         parent.$mc_ctrler.addQi(5);
         parent.$mc_ctrler.setSteelBody(true);
      }
      
      internal function frame339() : *
      {
         parent.$mc_ctrler.setHitTarget("zh20atm","招22");
      }
      
      internal function frame365() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame371() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame376() : *
      {
         parent.$mc_ctrler.addQi(5);
      }
      
      internal function frame382() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame398() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame431() : *
      {
         parent.$mc_ctrler.addQi(5);
         parent.$mc_ctrler.setHurtAction("砍技12");
      }
      
      internal function frame445() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame459() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame470() : *
      {
         parent.$fighter_ctrler.moveToTarget(60,0,true);
      }
      
      internal function frame475() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame479() : *
      {
         parent.$mc_ctrler.setSkill2();
         parent.$mc_ctrler.setAttack("砍3");
      }
      
      internal function frame486() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame496() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame520() : *
      {
         parent.$mc_ctrler.addQi(5);
      }
      
      internal function frame524() : *
      {
         parent.$effect_ctrler.shine();
      }
      
      internal function frame540() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame553() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame571() : *
      {
         parent.$mc_ctrler.movePercent(2,0);
         parent.$mc_ctrler.setHitTarget("kj20atm","砍技22");
      }
      
      internal function frame572() : *
      {
         parent.$mc_ctrler.addQi(5);
         parent.$effect_ctrler.dash();
         parent.$effect_ctrler.shadow(50,255,255);
      }
      
      internal function frame591() : *
      {
         parent.$mc_ctrler.endAct();
         parent.$mc_ctrler.dampingPercent(0.2,0);
      }
      
      internal function frame595() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame609() : *
      {
         gotoAndPlay("招22");
      }
      
      internal function frame610() : *
      {
         parent.$mc_ctrler.movePercent(2,0);
         parent.$mc_ctrler.dampingPercent(0.4,0);
      }
      
      internal function frame621() : *
      {
         parent.$mc_ctrler.setAttack("砍41");
         parent.$mc_ctrler.setSkill2("砍技23");
      }
      
      internal function frame627() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame634() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame659() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame675() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame688() : *
      {
         parent.$mc_ctrler.addQi(5);
      }
      
      internal function frame693() : *
      {
         parent.$mc_ctrler.addAttacker("dk",{"applyG":false});
      }
      
      internal function frame706() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame722() : *
      {
         parent.$mc_ctrler.addQi(5);
      }
      
      internal function frame726() : *
      {
         parent.$fighter_ctrler.setCross(true);
      }
      
      internal function frame737() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame743() : *
      {
         parent.$mc_ctrler.addQi(10);
      }
      
      internal function frame747() : *
      {
         parent.$mc_ctrler.moveTarget({
            "followmc":"move_mc",
            "speed":5
         });
      }
      
      internal function frame760() : *
      {
         parent.$mc_ctrler.moveTarget(null);
      }
      
      internal function frame770() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame779() : *
      {
         parent.$effect_ctrler.bisha(false,"蓝染1");
      }
      
      internal function frame815() : *
      {
         parent.$effect_ctrler.endBisha();
         parent.$effect_ctrler.shine(16711680);
      }
      
      internal function frame817() : *
      {
         parent.$mc_ctrler.addAttacker("bsmc",{
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
      
      internal function frame873() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame886() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame891() : *
      {
         parent.$effect_ctrler.bisha(false,"蓝染1");
      }
      
      internal function frame928() : *
      {
         parent.$effect_ctrler.endBisha();
      }
      
      internal function frame930() : *
      {
         parent.$effect_ctrler.shine();
         parent.$fighter_ctrler.moveToTarget(30,0,true);
      }
      
      internal function frame931() : *
      {
         parent.$effect_ctrler.slowDown(0.5);
         parent.$effect_ctrler.shadow(100,255,255);
         parent.$mc_ctrler.isApplyG(false);
      }
      
      internal function frame938() : *
      {
         parent.$mc_ctrler.justHitToPlay("sbs1","上必杀2",false,false);
      }
      
      internal function frame940() : *
      {
         parent.$mc_ctrler.endAct();
         parent.$effect_ctrler.endShadow();
      }
      
      internal function frame954() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame960() : *
      {
         parent.$effect_ctrler.shine();
         parent.$fighter_ctrler.moveToTarget(30,0,true);
         parent.$effect_ctrler.shadow(100,255,255);
         parent.$mc_ctrler.isApplyG(false);
      }
      
      internal function frame972() : *
      {
         parent.$effect_ctrler.shine();
         parent.$fighter_ctrler.moveToTarget(30,0,true);
      }
      
      internal function frame985() : *
      {
         parent.$effect_ctrler.shine();
         parent.$fighter_ctrler.moveToTarget(30,0,true);
      }
      
      internal function frame1001() : *
      {
         parent.$effect_ctrler.shine();
         parent.$fighter_ctrler.moveToTarget(30,0,true);
      }
      
      internal function frame1014() : *
      {
         parent.$effect_ctrler.shine();
         parent.$fighter_ctrler.moveToTarget(30,0,true);
      }
      
      internal function frame1031() : *
      {
         parent.$effect_ctrler.shine();
         parent.$fighter_ctrler.moveToTarget(50,0,true);
      }
      
      internal function frame1050() : *
      {
         parent.$effect_ctrler.shine();
         parent.$fighter_ctrler.moveToTarget(50,0,true);
      }
      
      internal function frame1068() : *
      {
         parent.$effect_ctrler.shine();
         parent.$fighter_ctrler.moveToTarget(50,0,true);
         parent.$effect_ctrler.endShadow();
      }
      
      internal function frame1084() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame1124() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame1141() : *
      {
         parent.$effect_ctrler.dash();
         parent.$effect_ctrler.bisha(false,"蓝染1");
      }
      
      internal function frame1147() : *
      {
         parent.$fighter_ctrler.moveToTarget(50,-70,true);
      }
      
      internal function frame1159() : *
      {
         parent.$effect_ctrler.endBisha();
      }
      
      internal function frame1165() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame1187() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame1212() : *
      {
         parent.$effect_ctrler.bisha(true,"蓝染2");
      }
      
      internal function frame1252() : *
      {
         parent.$effect_ctrler.endBisha();
      }
      
      internal function frame1411() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame1429() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame1517() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame1537() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame1608() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame1672() : *
      {
         parent.$mc_ctrler.stop();
      }
      
      internal function frame1716() : *
      {
         parent.$mc_ctrler.stop();
      }
   }
}

