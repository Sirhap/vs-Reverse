package madara_fla
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol906")]
   public dynamic class 鸣人全动作_1 extends MovieClip
   {
      
      public var AImain:MovieClip;
      
      public var bdmn:MovieClip;
      
      public var bs1atm:MovieClip;
      
      public var bsatm:MovieClip;
      
      public var cbs2atm:MovieClip;
      
      public var cbs3atm:MovieClip;
      
      public var cbsatm:MovieClip;
      
      public var k1atm:MovieClip;
      
      public var k2atm:MovieClip;
      
      public var k3atm:MovieClip;
      
      public var k4atm:MovieClip;
      
      public var k5atm:MovieClip;
      
      public var kbsatm:MovieClip;
      
      public var kj12atm:MovieClip;
      
      public var kj13atm:MovieClip;
      
      public var kj1atm:MovieClip;
      
      public var kj22atm:MovieClip;
      
      public var kj2atm:MovieClip;
      
      public var sbs1atm:MovieClip;
      
      public var sbs2atm:MovieClip;
      
      public var sbs3atm:MovieClip;
      
      public var sbsatm:MovieClip;
      
      public var sh12atm:MovieClip;
      
      public var sh1atm:MovieClip;
      
      public var sh22atm:MovieClip;
      
      public var sh2atm:MovieClip;
      
      public var tkatm:MovieClip;
      
      public var tzatm:MovieClip;
      
      public var zh12atm:MovieClip;
      
      public var zh1atm:MovieClip;
      
      public var zh22atm:MovieClip;
      
      public var zh2atm:MovieClip;
      
      public var zh3atm:MovieClip;
      
      public function 鸣人全动作_1()
      {
         super();
         addFrameScript(10,this.frame11,13,this.frame14,16,this.frame17,28,this.frame29,31,this.frame32,35,this.frame36,65,this.frame66,71,this.frame72,73,this.frame74,77,this.frame78,82,this.frame83,90,this.frame91,95,this.frame96,108,this.frame109,116,this.frame117,120,this.frame121,126,this.frame127,131,this.frame132,134,this.frame135,140,this.frame141,146,this.frame147,149,this.frame150,151,this.frame152,157,this.frame158,164,this.frame165,169,this.frame170,187,this.frame188,198,this.frame199,222,this.frame223,228,this.frame229,242,this.frame243,246,this.frame247,257,this.frame258,280,this.frame281,295,this.frame296,301,this.frame302,302,this.frame303,304,this.frame305,314,this.frame315,319,this.frame320,323,this.frame324,328,this.frame329,342,this.frame343,349,this.frame350,359,this.frame360,363,this.frame364,365,this.frame366,381,this.frame382,389,this.frame390,394,this.frame395,399,this.frame400,404,this.frame405,408,this.frame409,418,this.frame419,431,this.frame432,437,this.frame438,449,this
         .frame450,454,this.frame455,466,this.frame467,475,this.frame476,484,this.frame485,508,this.frame509,512,this.frame513,520,this.frame521,530,this.frame531,539,this.frame540,544,this.frame545,563,this.frame564,564,this.frame565,567,this.frame568,577,this.frame578,589,this.frame590,606,this.frame607,620,this.frame621,637,this.frame638,652,this.frame653,663,this.frame664,690,this.frame691,707,this.frame708,738,this.frame739,739,this.frame740,793,this.frame794,798,this.frame799,816,this.frame817,833,this.frame834,874,this.frame875,877,this.frame878,898,this.frame899,906,this.frame907,982,this.frame983,987,this.frame988,1007,this.frame1008,1094,this.frame1095,1147,this.frame1148,1175,this.frame1176,1195,this.frame1196,1254,this.frame1255,1258,this.frame1259,1271,this.frame1272,1275,this.frame1276,1279,this.frame1280,1313,this.frame1314,1338,this.frame1339);
      }
      
      internal function frame11() : *
      {
         parent.$effect_ctrler.walk();
      }
      
      internal function frame14() : *
      {
         parent.$effect_ctrler.walk();
      }
      
      internal function frame17() : *
      {
         parent.$mc_ctrler.loop("走");
      }
      
      internal function frame29() : *
      {
         parent.$mc_ctrler.dash(5);
         parent.$mc_ctrler.setBisha();
         parent.$mc_ctrler.setBishaUP();
         parent.$mc_ctrler.setBishaSUPER();
         parent.$effect_ctrler.dash();
      }
      
      internal function frame32() : *
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
      
      internal function frame72() : *
      {
         parent.$mc_ctrler.setAirMove(true);
      }
      
      internal function frame74() : *
      {
         parent.$mc_ctrler.move(0,-5);
         parent.$mc_ctrler.damping(0,0.3);
      }
      
      internal function frame78() : *
      {
         parent.$mc_ctrler.setSkillAIR("跳招");
      }
      
      internal function frame83() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame91() : *
      {
         parent.$mc_ctrler.addQi(10);
         parent.$mc_ctrler.move(0,-5);
         parent.$mc_ctrler.damping(0,0.1);
      }
      
      internal function frame96() : *
      {
         parent.$mc_ctrler.move(-5,-5);
         parent.$mc_ctrler.damping(0.2,0.2);
         parent.$mc_ctrler.fire("tzatm",{
            "x":{
               "start":9,
               "add":2,
               "max":30
            },
            "y":{
               "start":9,
               "add":2,
               "max":30
            },
            "hold":2,
            "hits":1
         });
         parent.$effect_ctrler.shine(16552276);
      }
      
      internal function frame109() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame117() : *
      {
         parent.$mc_ctrler.movePercent(1,0);
         parent.$mc_ctrler.dampingPercent(0.1,0);
      }
      
      internal function frame121() : *
      {
         parent.$mc_ctrler.setAttack("砍2");
         parent.$mc_ctrler.setZhao1();
         parent.$mc_ctrler.setDash();
      }
      
      internal function frame127() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame132() : *
      {
         parent.$mc_ctrler.movePercent(0.5,0);
      }
      
      internal function frame135() : *
      {
         parent.$mc_ctrler.dampingPercent(0.05,0);
      }
      
      internal function frame141() : *
      {
         parent.$mc_ctrler.setAttack("砍3");
         parent.$mc_ctrler.setZhao1();
         parent.$mc_ctrler.setSkill1("砍技11");
         parent.$mc_ctrler.setDash();
      }
      
      internal function frame147() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame150() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame152() : *
      {
         parent.$mc_ctrler.movePercent(0.3,0);
         parent.$mc_ctrler.dampingPercent(0.06,0);
      }
      
      internal function frame158() : *
      {
         parent.$mc_ctrler.setBishaUP();
         parent.$mc_ctrler.setBishaSUPER();
         parent.$mc_ctrler.setZhao3();
         parent.$mc_ctrler.setZhao1();
         parent.$mc_ctrler.setDash();
         parent.$mc_ctrler.setAttack("砍4");
      }
      
      internal function frame165() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame170() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame188() : *
      {
         parent.$mc_ctrler.setBisha();
         parent.$mc_ctrler.setSkill2("砍技21");
         parent.$mc_ctrler.setZhao3();
         parent.$mc_ctrler.setAttack("砍5");
      }
      
      internal function frame199() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame223() : *
      {
         parent.$effect_ctrler.shake(0,5);
         parent.$effect_ctrler.shine();
      }
      
      internal function frame229() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame243() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame247() : *
      {
         parent.$mc_ctrler.addQi(10);
      }
      
      internal function frame258() : *
      {
         parent.$effect_ctrler.shake(0,5);
         parent.$effect_ctrler.shine();
      }
      
      internal function frame281() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame296() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame302() : *
      {
         parent.$effect_ctrler.dash();
      }
      
      internal function frame303() : *
      {
         if(parent.$fighter_ctrler.targetInRange([0,1000]))
         {
            parent.$fighter_ctrler.moveToTarget(-80,null,false);
         }
         else
         {
            parent.$fighter_ctrler.moveOnce(150,0);
         }
         parent.$mc_ctrler.movePercent(1,0);
         parent.$mc_ctrler.dampingPercent(0.05,0);
      }
      
      internal function frame305() : *
      {
         parent.$effect_ctrler.shadow(-100,-100,-100);
      }
      
      internal function frame315() : *
      {
         parent.$mc_ctrler.setAttack("砍技12");
         parent.$mc_ctrler.setSkill2("砍3");
         parent.$mc_ctrler.setBishaUP();
         parent.$mc_ctrler.setBisha();
         parent.$mc_ctrler.setDash();
         parent.$effect_ctrler.endShadow();
      }
      
      internal function frame320() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame324() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame329() : *
      {
         parent.$mc_ctrler.addQi(10);
      }
      
      internal function frame343() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame350() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame360() : *
      {
         parent.$mc_ctrler.addQi(10);
      }
      
      internal function frame364() : *
      {
         parent.$effect_ctrler.dash();
      }
      
      internal function frame366() : *
      {
         parent.$fighter_ctrler.moveToTarget(1,10,true);
         parent.$mc_ctrler.move(-10,-10);
         parent.$mc_ctrler.damping(0.2,0.2);
         parent.$effect_ctrler.slowDown(0.5);
         parent.$effect_ctrler.shadow(-100,-100,-100);
      }
      
      internal function frame382() : *
      {
         parent.$mc_ctrler.setSkillAIR();
         parent.$mc_ctrler.setBishaAIR();
         parent.$effect_ctrler.endShadow();
      }
      
      internal function frame390() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame395() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame400() : *
      {
         parent.$mc_ctrler.addQi(5);
      }
      
      internal function frame405() : *
      {
         parent.$mc_ctrler.fire("zh12atm",{
            "x":{
               "start":14,
               "add":2,
               "max":25
            },
            "y":0,
            "hold":80,
            "hits":1
         });
         parent.$effect_ctrler.shine(16759653);
      }
      
      internal function frame409() : *
      {
         parent.$mc_ctrler.fire("zh12atm",{
            "x":{
               "start":14,
               "add":2,
               "max":25
            },
            "y":0,
            "hold":80,
            "hits":1
         });
         parent.$effect_ctrler.shine(16759653);
      }
      
      internal function frame419() : *
      {
         parent.$mc_ctrler.fire("zh1atm",{
            "x":{
               "start":14,
               "add":2,
               "max":25
            },
            "y":0,
            "hold":100,
            "hits":1
         });
         parent.$effect_ctrler.shine(16759653);
      }
      
      internal function frame432() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame438() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame450() : *
      {
         parent.$mc_ctrler.addQi(10);
      }
      
      internal function frame455() : *
      {
         parent.$effect_ctrler.shine(11927551);
      }
      
      internal function frame467() : *
      {
         parent.$mc_ctrler.fire("zh3atm",{
            "x":20,
            "y":-20,
            "hold":5,
            "hits":99,
            "hp":300
         });
      }
      
      internal function frame476() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame485() : *
      {
         parent.$effect_ctrler.bisha(false,"斑1");
      }
      
      internal function frame509() : *
      {
         parent.$effect_ctrler.endBisha();
      }
      
      internal function frame513() : *
      {
         parent.$effect_ctrler.shake(0,3);
         parent.$effect_ctrler.shine();
      }
      
      internal function frame521() : *
      {
         parent.$mc_ctrler.justHitToPlay("sbs","上必杀2",false);
      }
      
      internal function frame531() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame540() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame545() : *
      {
         parent.$effect_ctrler.bisha(false,"斑1");
      }
      
      internal function frame564() : *
      {
         parent.$effect_ctrler.endBisha();
      }
      
      internal function frame565() : *
      {
         parent.$effect_ctrler.slowDown(2);
      }
      
      internal function frame568() : *
      {
         parent.$effect_ctrler.shine();
      }
      
      internal function frame578() : *
      {
         parent.$effect_ctrler.shine();
      }
      
      internal function frame590() : *
      {
         parent.$effect_ctrler.shine();
      }
      
      internal function frame607() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame621() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame638() : *
      {
         parent.$mc_ctrler.addQi(10);
      }
      
      internal function frame653() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame664() : *
      {
         parent.$mc_ctrler.addQi(20);
      }
      
      internal function frame691() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame708() : *
      {
         parent.$effect_ctrler.bisha(false,"斑1");
      }
      
      internal function frame739() : *
      {
         parent.$effect_ctrler.endBisha();
      }
      
      internal function frame740() : *
      {
         parent.$effect_ctrler.shine(303095);
         parent.$effect_ctrler.shake(0,5);
      }
      
      internal function frame794() : *
      {
         parent.$effect_ctrler.shine(9697014);
      }
      
      internal function frame799() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame817() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame834() : *
      {
         parent.$effect_ctrler.bisha(false,"斑1");
      }
      
      internal function frame875() : *
      {
         parent.$effect_ctrler.endBisha();
      }
      
      internal function frame878() : *
      {
         parent.$mc_ctrler.move(-2,-2);
         parent.$mc_ctrler.damping(0.05,0.05);
         parent.$effect_ctrler.shine(9697014);
         parent.$effect_ctrler.slowDown(1);
         parent.$mc_ctrler.fire("kbsatm",{
            "x":30,
            "y":25,
            "hold":5,
            "hits":1,
            "hp":300
         });
      }
      
      internal function frame899() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame907() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame983() : *
      {
         parent.$mc_ctrler.movePercent(0.2,0);
      }
      
      internal function frame988() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame1008() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame1095() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame1148() : *
      {
         parent.$mc_ctrler.stop();
      }
      
      internal function frame1176() : *
      {
         parent.$mc_ctrler.stop();
      }
      
      internal function frame1196() : *
      {
         parent.$effect_ctrler.bisha(true,"斑2");
      }
      
      internal function frame1255() : *
      {
         parent.$effect_ctrler.endBisha();
      }
      
      internal function frame1259() : *
      {
         parent.$effect_ctrler.shake(0,5);
         parent.$effect_ctrler.shine();
         parent.$effect_ctrler.slowDown(3);
      }
      
      internal function frame1272() : *
      {
         parent.$effect_ctrler.shake(0,5);
      }
      
      internal function frame1276() : *
      {
         parent.$effect_ctrler.shake(0,5);
      }
      
      internal function frame1280() : *
      {
         parent.$effect_ctrler.shake(0,5);
      }
      
      internal function frame1314() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame1339() : *
      {
         parent.$mc_ctrler.idle();
      }
   }
}

