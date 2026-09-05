package obito_fla
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol449")]
   public dynamic class 樱_1 extends MovieClip
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
      
      public var k4atm:MovieClip;
      
      public var k5atm:MovieClip;
      
      public var kj12atm:MovieClip;
      
      public var kj1atm:MovieClip;
      
      public var kj20atm:MovieClip;
      
      public var kj2atm:MovieClip;
      
      public var move_mc:MovieClip;
      
      public var sbs0ckm:MovieClip;
      
      public var sbs1atm:MovieClip;
      
      public var sbs2atm:MovieClip;
      
      public var sbs3atm:MovieClip;
      
      public var sbs4atm:MovieClip;
      
      public var sh12atm:MovieClip;
      
      public var sh1atm:MovieClip;
      
      public var sh22atm:MovieClip;
      
      public var sh23atm:MovieClip;
      
      public var sh2atm:MovieClip;
      
      public var tk1atm:MovieClip;
      
      public var tkatm:MovieClip;
      
      public var zh2atm:MovieClip;
      
      public var zh3atm:MovieClip;
      
      public var zh3mc:MovieClip;
      
      public function 樱_1()
      {
         super();
         addFrameScript(12,this.frame13,21,this.frame22,29,this.frame30,37,this.frame38,40,this.frame41,44,this.frame45,52,this.frame53,80,this.frame81,103,this.frame104,113,this.frame114,124,this.frame125,133,this.frame134,139,this.frame140,144,this.frame145,147,this.frame148,160,this.frame161,165,this.frame166,170,this.frame171,174,this.frame175,182,this.frame183,186,this.frame187,191,this.frame192,195,this.frame196,201,this.frame202,206,this.frame207,210,this.frame211,216,this.frame217,220,this.frame221,227,this.frame228,231,this.frame232,232,this.frame233,238,this.frame239,248,this.frame249,251,this.frame252,253,this.frame254,266,this.frame267,272,this.frame273,282,this.frame283,284,this.frame285,290,this.frame291,296,this.frame297,310,this.frame311,335,this.frame336,348,this.frame349,367,this.frame368,373,this.frame374,381,this.frame382,382,this.frame383,400,this.frame401,401,this.frame402,414,this.frame415,420,this.frame421,432,this.frame433,440,this.frame441,441,this.frame442,446,this.frame447
         ,453,this.frame454,459,this.frame460,460,this.frame461,464,this.frame465,481,this.frame482,491,this.frame492,500,this.frame501,515,this.frame516,579,this.frame580,594,this.frame595,600,this.frame601,617,this.frame618,619,this.frame620,668,this.frame669,677,this.frame678,685,this.frame686,743,this.frame744,759,this.frame760,772,this.frame773,886,this.frame887,887,this.frame888,958,this.frame959,971,this.frame972,1072,this.frame1073,1094,this.frame1095,1116,this.frame1117,1163,this.frame1164,1221,this.frame1222,1266,this.frame1267,1285,this.frame1286,1289,this.frame1290);
      }
      
      internal function frame13() : *
      {
         parent.$effect_ctrler.walk();
      }
      
      internal function frame22() : *
      {
         parent.$effect_ctrler.walk();
      }
      
      internal function frame30() : *
      {
         parent.$mc_ctrler.loop("走");
      }
      
      internal function frame38() : *
      {
         parent.$effect_ctrler.dash();
      }
      
      internal function frame41() : *
      {
         parent.$mc_ctrler.movePercent(4.5,0);
      }
      
      internal function frame45() : *
      {
         parent.$mc_ctrler.stopMove();
      }
      
      internal function frame53() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame81() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame104() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame114() : *
      {
         parent.$fighter_ctrler.moveToTarget(40,0,true);
      }
      
      internal function frame125() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame134() : *
      {
         parent.$mc_ctrler.movePercent(0.5,0);
         parent.$mc_ctrler.dampingPercent(0.1,0);
      }
      
      internal function frame140() : *
      {
         parent.$mc_ctrler.setAttack("砍2");
      }
      
      internal function frame145() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame148() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame161() : *
      {
         parent.$mc_ctrler.setAttack("砍3");
         parent.$mc_ctrler.setSkill2("砍技21");
      }
      
      internal function frame166() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame171() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame175() : *
      {
         parent.$mc_ctrler.movePercent(1,0);
         parent.$mc_ctrler.dampingPercent(0.1,0);
      }
      
      internal function frame183() : *
      {
         parent.$mc_ctrler.setAttack("砍4");
         parent.$mc_ctrler.setSkill1();
         parent.$mc_ctrler.setZhao2();
      }
      
      internal function frame187() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame192() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame196() : *
      {
         parent.$mc_ctrler.movePercent(0.5,0);
         parent.$mc_ctrler.dampingPercent(0.05,0);
      }
      
      internal function frame202() : *
      {
         parent.$mc_ctrler.setBishaSUPER();
         parent.$mc_ctrler.setBisha();
         parent.$mc_ctrler.setBishaUP();
         parent.$mc_ctrler.setZhao2();
         parent.$mc_ctrler.setAttack("砍5");
         parent.$mc_ctrler.setDash();
      }
      
      internal function frame207() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame211() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame217() : *
      {
         parent.$mc_ctrler.movePercent(1,0);
         parent.$mc_ctrler.dampingPercent(0.1,0);
      }
      
      internal function frame221() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame228() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame232() : *
      {
         parent.$mc_ctrler.movePercent(1,0);
         parent.$mc_ctrler.dampingPercent(0.1,0);
         parent.$effect_ctrler.shadow(-100,-100,-100);
      }
      
      internal function frame233() : *
      {
         parent.$mc_ctrler.addQi(10);
      }
      
      internal function frame239() : *
      {
         parent.$mc_ctrler.movePercent(1,0);
         parent.$mc_ctrler.dampingPercent(0.1,0);
      }
      
      internal function frame249() : *
      {
         parent.$mc_ctrler.movePercent(1,0);
         parent.$mc_ctrler.dampingPercent(0.1,0);
      }
      
      internal function frame252() : *
      {
         parent.$effect_ctrler.endShadow();
      }
      
      internal function frame254() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame267() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame273() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame283() : *
      {
         parent.$mc_ctrler.justHitToPlay("zh3","招32",false,false);
      }
      
      internal function frame285() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame291() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame297() : *
      {
         if(parent.$fighter_ctrler.target)
         {
            parent.$fighter_ctrler.target.visible = false;
         }
      }
      
      internal function frame311() : *
      {
         parent.$mc_ctrler.addAttacker("zh3mc",{"applyG":false});
      }
      
      internal function frame336() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame349() : *
      {
         parent.$mc_ctrler.addQi(5);
      }
      
      internal function frame368() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame374() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame382() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame383() : *
      {
         parent.$mc_ctrler.addQi(10);
         parent.$mc_ctrler.movePercent(2,0);
         parent.$mc_ctrler.setHitTarget("kj20atm","砍技21");
         parent.$effect_ctrler.shadow(-100,-100,-100);
      }
      
      internal function frame401() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame402() : *
      {
         parent.$mc_ctrler.movePercent(1,0);
         parent.$mc_ctrler.dampingPercent(0.1,0);
      }
      
      internal function frame415() : *
      {
         parent.$mc_ctrler.setAttack("砍3");
         parent.$mc_ctrler.setZhao2();
         parent.$mc_ctrler.setDash();
      }
      
      internal function frame421() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame433() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame441() : *
      {
         parent.$mc_ctrler.moveTarget({"followmc":"move_mc"});
      }
      
      internal function frame442() : *
      {
         parent.$mc_ctrler.addQi(10);
      }
      
      internal function frame447() : *
      {
         parent.$mc_ctrler.moveTarget(null);
      }
      
      internal function frame454() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame460() : *
      {
         parent.$mc_ctrler.moveTarget({"followmc":"move_mc"});
      }
      
      internal function frame461() : *
      {
         parent.$mc_ctrler.addQi(10);
      }
      
      internal function frame465() : *
      {
         parent.$mc_ctrler.moveTarget(null);
      }
      
      internal function frame482() : *
      {
         parent.$mc_ctrler.movePercent(1,0);
         parent.$mc_ctrler.dampingPercent(0.1,0);
      }
      
      internal function frame492() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame501() : *
      {
         parent.$effect_ctrler.bisha(false,"带土1");
      }
      
      internal function frame516() : *
      {
         parent.$effect_ctrler.endBisha();
      }
      
      internal function frame580() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame595() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame601() : *
      {
         parent.$effect_ctrler.bisha(false,"带土1");
      }
      
      internal function frame618() : *
      {
         parent.$effect_ctrler.endBisha();
      }
      
      internal function frame620() : *
      {
         parent.$mc_ctrler.setHitTarget("sbs0ckm","上必杀2");
         parent.$mc_ctrler.moveTarget({
            "followmc":"move_mc",
            "speed":8
         });
      }
      
      internal function frame669() : *
      {
         parent.$mc_ctrler.moveTarget(null);
         parent.$mc_ctrler.moveTarget(null);
      }
      
      internal function frame678() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame686() : *
      {
         if(parent.$fighter_ctrler.target)
         {
            parent.$fighter_ctrler.target.visible = false;
         }
      }
      
      internal function frame744() : *
      {
         if(parent.$fighter_ctrler.target)
         {
            parent.$fighter_ctrler.target.visible = true;
         }
      }
      
      internal function frame760() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame773() : *
      {
         parent.$effect_ctrler.bisha(true,"带土2");
      }
      
      internal function frame887() : *
      {
         parent.$effect_ctrler.endBisha();
      }
      
      internal function frame888() : *
      {
         parent.$mc_ctrler.move(-10,0);
         parent.$mc_ctrler.damping(2,0);
      }
      
      internal function frame959() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame972() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame1073() : *
      {
         if(sw == true)
         {
            parent.$mc_ctrler.stop();
         }
      }
      
      internal function frame1095() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame1117() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame1164() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame1222() : *
      {
         parent.$mc_ctrler.stop();
      }
      
      internal function frame1267() : *
      {
         parent.$mc_ctrler.stop();
      }
      
      internal function frame1286() : *
      {
         parent.$effect_ctrler.startWanKai();
      }
      
      internal function frame1290() : *
      {
         parent.$fighter_ctrler.doWanKai();
      }
   }
}

