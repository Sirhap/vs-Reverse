package pain_fla
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol622")]
   public dynamic class 佩恩_1 extends MovieClip
   {
      
      public var AImain:MovieClip;
      
      public var bdmn:MovieClip;
      
      public var bsatm:MovieClip;
      
      public var cbs1atm:MovieClip;
      
      public var cbsatm:MovieClip;
      
      public var k1atm:MovieClip;
      
      public var k2atm:MovieClip;
      
      public var k3atm:MovieClip;
      
      public var k4atm:MovieClip;
      
      public var kj1atm:MovieClip;
      
      public var kj2:MovieClip;
      
      public var kj20atm:MovieClip;
      
      public var move_mc:MovieClip;
      
      public var rjd:MovieClip;
      
      public var sbs1:MovieClip;
      
      public var sbs3atm:MovieClip;
      
      public var sbsatm:MovieClip;
      
      public var sh12atm:MovieClip;
      
      public var sh1atm:MovieClip;
      
      public var sh22atm:MovieClip;
      
      public var sh2atm:MovieClip;
      
      public var tk2:MovieClip;
      
      public var tkatm:MovieClip;
      
      public var tzatm:MovieClip;
      
      public var xld:MovieClip;
      
      public var zh1:MovieClip;
      
      public var zh2:MovieClip;
      
      public var zh20:MovieClip;
      
      public var zh3:MovieClip;
      
      public function 佩恩_1()
      {
         super();
         addFrameScript(13,this.frame14,19,this.frame20,22,this.frame23,26,this.frame27,33,this.frame34,35,this.frame36,65,this.frame66,79,this.frame80,82,this.frame83,85,this.frame86,89,this.frame90,98,this.frame99,99,this.frame100,102,this.frame103,108,this.frame109,136,this.frame137,138,this.frame139,140,this.frame141,159,this.frame160,171,this.frame172,176,this.frame177,180,this.frame181,184,this.frame185,189,this.frame190,196,this.frame197,200,this.frame201,203,this.frame204,211,this.frame212,216,this.frame217,221,this.frame222,226,this.frame227,234,this.frame235,237,this.frame238,247,this.frame248,254,this.frame255,260,this.frame261,263,this.frame264,267,this.frame268,270,this.frame271,272,this.frame273,276,this.frame277,289,this.frame290,315,this.frame316,322,this.frame323,343,this.frame344,344,this.frame345,349,this.frame350,353,this.frame354,358,this.frame359,368,this.frame369,405,this.frame406,406,this.frame407,432,this.frame433,437,this.frame438,438,this.frame439,449,this.frame450,456
         ,this.frame457,474,this.frame475,475,this.frame476,489,this.frame490,500,this.frame501,511,this.frame512,541,this.frame542,567,this.frame568,574,this.frame575,619,this.frame620,634,this.frame635,638,this.frame639,646,this.frame647,670,this.frame671,691,this.frame692,718,this.frame719,719,this.frame720,730,this.frame731,738,this.frame739,743,this.frame744,753,this.frame754,771,this.frame772,789,this.frame790,812,this.frame813,830,this.frame831,841,this.frame842,863,this.frame864,872,this.frame873,892,this.frame893,912,this.frame913,914,this.frame915,939,this.frame940,944,this.frame945,982,this.frame983,1024,this.frame1025,1081,this.frame1082,1085,this.frame1086,1102,this.frame1103,1201,this.frame1202,1228,this.frame1229,1295,this.frame1296,1344,this.frame1345,1372,this.frame1373);
      }
      
      internal function frame14() : *
      {
         parent.$effect_ctrler.walk();
      }
      
      internal function frame20() : *
      {
         parent.$effect_ctrler.walk();
      }
      
      internal function frame23() : *
      {
         parent.$mc_ctrler.loop("走");
      }
      
      internal function frame27() : *
      {
         parent.$mc_ctrler.dash(3.5);
         parent.$mc_ctrler.setBisha();
         parent.$mc_ctrler.setBishaUP();
         parent.$mc_ctrler.setBishaSUPER();
         parent.$effect_ctrler.dash();
         parent.$effect_ctrler.shadow(-50,-50,-50);
      }
      
      internal function frame34() : *
      {
         parent.$mc_ctrler.dashStop();
         parent.$mc_ctrler.stopMove();
      }
      
      internal function frame36() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame66() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame80() : *
      {
         parent.$mc_ctrler.isApplyG(false);
      }
      
      internal function frame83() : *
      {
         parent.$mc_ctrler.movePercent(1,-1);
         parent.$mc_ctrler.dampingPercent(0.1,0.2);
      }
      
      internal function frame86() : *
      {
         parent.$mc_ctrler.setAttackAIR("跳砍2");
         parent.$mc_ctrler.setSkillAIR();
         parent.$mc_ctrler.setBishaAIR();
      }
      
      internal function frame90() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame99() : *
      {
         parent.$mc_ctrler.isApplyG(false);
         parent.$mc_ctrler.setAirMove(true);
      }
      
      internal function frame100() : *
      {
         parent.$mc_ctrler.addAttacker("tk2",{"applyG":false});
      }
      
      internal function frame103() : *
      {
         parent.$mc_ctrler.setSkillAIR();
         parent.$mc_ctrler.setBishaAIR();
      }
      
      internal function frame109() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame137() : *
      {
         parent.$mc_ctrler.isApplyG(false);
      }
      
      internal function frame139() : *
      {
         parent.$mc_ctrler.movePercent(2,0);
         parent.$mc_ctrler.dampingPercent(0.3,0);
      }
      
      internal function frame141() : *
      {
         parent.$effect_ctrler.shine(16409859);
      }
      
      internal function frame160() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame172() : *
      {
         parent.$mc_ctrler.movePercent(1.2,0);
         parent.$mc_ctrler.dampingPercent(0.4,0);
      }
      
      internal function frame177() : *
      {
         parent.$mc_ctrler.setAttack("砍2");
         parent.$mc_ctrler.setZhao1();
         parent.$mc_ctrler.setBisha();
      }
      
      internal function frame181() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame185() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame190() : *
      {
         parent.$mc_ctrler.movePercent(1.3,0);
         parent.$mc_ctrler.dampingPercent(0.1,0);
      }
      
      internal function frame197() : *
      {
         parent.$mc_ctrler.setAttack("砍3");
         parent.$mc_ctrler.setSkill1();
      }
      
      internal function frame201() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame204() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame212() : *
      {
         parent.$mc_ctrler.movePercent(1,0);
         parent.$mc_ctrler.dampingPercent(0.1,0);
      }
      
      internal function frame217() : *
      {
         parent.$mc_ctrler.setAttack("砍4");
         parent.$mc_ctrler.setZhao3();
         parent.$mc_ctrler.setBishaSUPER();
      }
      
      internal function frame222() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame227() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame235() : *
      {
         parent.$mc_ctrler.movePercent(1,0);
         parent.$mc_ctrler.dampingPercent(0.4,0);
      }
      
      internal function frame238() : *
      {
         parent.$effect_ctrler.shine(16409859);
      }
      
      internal function frame248() : *
      {
         parent.$mc_ctrler.setZhao2();
         parent.$mc_ctrler.setBishaUP();
      }
      
      internal function frame255() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame261() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame264() : *
      {
         parent.$mc_ctrler.addQi(10);
      }
      
      internal function frame268() : *
      {
         parent.$mc_ctrler.movePercent(3.5,0);
         parent.$effect_ctrler.shadow(-50,-50,-50);
         parent.$effect_ctrler.dash();
      }
      
      internal function frame271() : *
      {
         parent.$mc_ctrler.movePercent(0.8,0);
         parent.$mc_ctrler.dampingPercent(0.03,0);
      }
      
      internal function frame273() : *
      {
         parent.$mc_ctrler.setBishaUP();
         parent.$mc_ctrler.setZhao3();
         parent.$mc_ctrler.setJump();
      }
      
      internal function frame277() : *
      {
         parent.$mc_ctrler.endAct();
         parent.$effect_ctrler.endShadow();
      }
      
      internal function frame290() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame316() : *
      {
         parent.$mc_ctrler.setHitTarget("kj20atm","砍技21");
      }
      
      internal function frame323() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame344() : *
      {
         parent.$mc_ctrler.addQi(10);
         parent.$mc_ctrler.moveTarget({
            "followmc":"move_mc",
            "speed":35
         });
      }
      
      internal function frame345() : *
      {
         parent.$mc_ctrler.addAttacker("kj2",{"applyG":false});
      }
      
      internal function frame350() : *
      {
         parent.$mc_ctrler.moveTarget(null);
      }
      
      internal function frame354() : *
      {
         parent.$mc_ctrler.setZhao2();
         parent.$mc_ctrler.setBishaUP();
      }
      
      internal function frame359() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame369() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame406() : *
      {
         parent.$mc_ctrler.addQi(10);
      }
      
      internal function frame407() : *
      {
         parent.$mc_ctrler.addAttacker("zh1",{"applyG":false});
      }
      
      internal function frame433() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame438() : *
      {
         parent.$mc_ctrler.addQi(10);
      }
      
      internal function frame439() : *
      {
         parent.$mc_ctrler.addAttacker("zh1",{"applyG":false});
      }
      
      internal function frame450() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame457() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame475() : *
      {
         parent.$mc_ctrler.addQi(5);
      }
      
      internal function frame476() : *
      {
         parent.$mc_ctrler.addAttacker("zh2");
         parent.$mc_ctrler.addAttacker("zh20",{"applyG":false});
      }
      
      internal function frame490() : *
      {
         parent.$mc_ctrler.setBishaSUPER();
         parent.$mc_ctrler.setBishaUP();
         parent.$mc_ctrler.setZhao1("招12");
         parent.$mc_ctrler.setSkill1();
      }
      
      internal function frame501() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame512() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame542() : *
      {
         parent.$mc_ctrler.addQi(5);
         parent.$mc_ctrler.addAttacker("zh3",{"applyG":false});
         parent.$mc_ctrler.addAttacker("zh20",{"applyG":false});
      }
      
      internal function frame568() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame575() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame620() : *
      {
         parent.$mc_ctrler.addQi(10);
      }
      
      internal function frame635() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame639() : *
      {
         parent.$mc_ctrler.addQi(20);
      }
      
      internal function frame647() : *
      {
         parent.$effect_ctrler.shine(16409859);
      }
      
      internal function frame671() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame692() : *
      {
         parent.$effect_ctrler.bisha(false,"佩恩3");
      }
      
      internal function frame719() : *
      {
         parent.$effect_ctrler.endBisha();
         parent.$mc_ctrler.addAttacker("zh20",{"applyG":false});
      }
      
      internal function frame720() : *
      {
         parent.$mc_ctrler.addAttacker("sbs1",{
            "x":{
               "moveToTarget":true,
               "offset":-5
            },
            "applyG":false
         });
      }
      
      internal function frame731() : *
      {
         parent.$mc_ctrler.justHitToPlay("sbs1","上必杀1",false,false);
      }
      
      internal function frame739() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame744() : *
      {
         parent.$mc_ctrler.addAttacker("rjd",{
            "x":{"moveToTarget":true},
            "applyG":false
         });
      }
      
      internal function frame754() : *
      {
         parent.$fighter_ctrler.moveToTarget(-20,null,true);
      }
      
      internal function frame772() : *
      {
         parent.$mc_ctrler.addAttacker("xld",{
            "x":{
               "moveToTarget":true,
               "offset":-10
            },
            "applyG":false
         });
      }
      
      internal function frame790() : *
      {
         parent.$mc_ctrler.addAttacker("xld",{
            "x":{
               "moveToTarget":true,
               "offset":-10
            },
            "applyG":false
         });
      }
      
      internal function frame813() : *
      {
         parent.$fighter_ctrler.moveToTarget(-180,null,true);
      }
      
      internal function frame831() : *
      {
         parent.$mc_ctrler.moveTarget({
            "followmc":"move_mc",
            "speed":50
         });
      }
      
      internal function frame842() : *
      {
         parent.$mc_ctrler.moveTarget(null);
      }
      
      internal function frame864() : *
      {
         parent.$mc_ctrler.addAttacker("kj2",{"applyG":false});
      }
      
      internal function frame873() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame893() : *
      {
         parent.$effect_ctrler.bisha(false,"佩恩1");
         parent.$mc_ctrler.isApplyG(false);
      }
      
      internal function frame913() : *
      {
         parent.$effect_ctrler.endBisha();
      }
      
      internal function frame915() : *
      {
         parent.$effect_ctrler.shine(16409859);
      }
      
      internal function frame940() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame945() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame983() : *
      {
         parent.$effect_ctrler.bisha(true,"佩恩2");
      }
      
      internal function frame1025() : *
      {
         parent.$effect_ctrler.endBisha();
         parent.$mc_ctrler.moveTarget({
            "followmc":"move_mc",
            "speed":10
         });
      }
      
      internal function frame1082() : *
      {
         parent.$mc_ctrler.moveTarget(null);
      }
      
      internal function frame1086() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame1103() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame1202() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame1229() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame1296() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame1345() : *
      {
         parent.$mc_ctrler.stop();
      }
      
      internal function frame1373() : *
      {
         parent.$mc_ctrler.stop();
      }
   }
}

