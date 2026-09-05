package lee_fla
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol472")]
   public dynamic class 樱_1 extends MovieClip
   {
      
      public var AImain:MovieClip;
      
      public var bdmn:MovieClip;
      
      public var bs1atm:MovieClip;
      
      public var bsatm:MovieClip;
      
      public var cbs1atm:MovieClip;
      
      public var cbs2atm:MovieClip;
      
      public var cbs3atm:MovieClip;
      
      public var cbs4atm:MovieClip;
      
      public var cbsatm:MovieClip;
      
      public var k1atm:MovieClip;
      
      public var k2atm:MovieClip;
      
      public var k3atm:MovieClip;
      
      public var k4atm:MovieClip;
      
      public var kbs1atm:MovieClip;
      
      public var kbsatm:MovieClip;
      
      public var kj11atm:MovieClip;
      
      public var kj1atm:MovieClip;
      
      public var kj2atm:MovieClip;
      
      public var move_mc:MovieClip;
      
      public var sh12atm:MovieClip;
      
      public var sh1atm:MovieClip;
      
      public var sh22atm:MovieClip;
      
      public var sh2atm:MovieClip;
      
      public var tkatm:MovieClip;
      
      public var tz0atm:MovieClip;
      
      public var tzatm:MovieClip;
      
      public var zh1atm:MovieClip;
      
      public var zh21atm:MovieClip;
      
      public var zh2atm:MovieClip;
      
      public var zh3atm:MovieClip;
      
      public function 樱_1()
      {
         super();
         addFrameScript(7,this.frame8,11,this.frame12,17,this.frame18,22,this.frame23,27,this.frame28,34,this.frame35,37,this.frame38,67,this.frame68,79,this.frame80,82,this.frame83,86,this.frame87,96,this.frame97,106,this.frame107,109,this.frame110,124,this.frame125,128,this.frame129,137,this.frame138,149,this.frame150,153,this.frame154,159,this.frame160,162,this.frame163,172,this.frame173,177,this.frame178,183,this.frame184,187,this.frame188,201,this.frame202,207,this.frame208,214,this.frame215,224,this.frame225,231,this.frame232,238,this.frame239,246,this.frame247,252,this.frame253,266,this.frame267,268,this.frame269,279,this.frame280,289,this.frame290,302,this.frame303,340,this.frame341,344,this.frame345,350,this.frame351,352,this.frame353,387,this.frame388,388,this.frame389,401,this.frame402,403,this.frame404,411,this.frame412,417,this.frame418,418,this.frame419,419,this.frame420,422,this.frame423,428,this.frame429,429,this.frame430,436,this.frame437,447,this.frame448,463,this.frame464,464,this
         .frame465,470,this.frame471,471,this.frame472,476,this.frame477,485,this.frame486,496,this.frame497,508,this.frame509,512,this.frame513,523,this.frame524,534,this.frame535,538,this.frame539,557,this.frame558,578,this.frame579,601,this.frame602,604,this.frame605,607,this.frame608,625,this.frame626,634,this.frame635,638,this.frame639,639,this.frame640,640,this.frame641,641,this.frame642,642,this.frame643,643,this.frame644,652,this.frame653,653,this.frame654,660,this.frame661,672,this.frame673,673,this.frame674,674,this.frame675,695,this.frame696,704,this.frame705,720,this.frame721,722,this.frame723,738,this.frame739,751,this.frame752,771,this.frame772,798,this.frame799,806,this.frame807,837,this.frame838,839,this.frame840,849,this.frame850,852,this.frame853,862,this.frame863,871,this.frame872,879,this.frame880,890,this.frame891,900,this.frame901,909,this.frame910,917,this.frame918,933,this.frame934,934,this.frame935,939,this.frame940,953,this.frame954,1037,this.frame1038,1063,this.frame1064
         ,1138,this.frame1139,1179,this.frame1180,1207,this.frame1208,1219,this.frame1220,1228,this.frame1229);
      }
      
      internal function frame8() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame12() : *
      {
         parent.$effect_ctrler.walk();
      }
      
      internal function frame18() : *
      {
         parent.$effect_ctrler.walk();
      }
      
      internal function frame23() : *
      {
         parent.$mc_ctrler.loop("走");
      }
      
      internal function frame28() : *
      {
         parent.$mc_ctrler.dash(2.5);
         parent.$mc_ctrler.setBisha();
         parent.$mc_ctrler.setBishaUP();
         parent.$mc_ctrler.setBishaSUPER();
         parent.$effect_ctrler.shadow(0,200,0);
         parent.$effect_ctrler.dash();
      }
      
      internal function frame35() : *
      {
         parent.$mc_ctrler.dashStop();
      }
      
      internal function frame38() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame68() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame80() : *
      {
         parent.$mc_ctrler.move(10,0);
         parent.$mc_ctrler.damping(1,0);
      }
      
      internal function frame83() : *
      {
         parent.$mc_ctrler.setSkillAIR();
      }
      
      internal function frame87() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame97() : *
      {
         parent.$mc_ctrler.setHitTarget("tz0atm","跳招3");
         parent.$mc_ctrler.movePercent(1,-1);
         parent.$mc_ctrler.dampingPercent(0,0.1);
         parent.$mc_ctrler.setTouchFloor("跳招2",true);
         parent.$effect_ctrler.shadow(0,200,0);
      }
      
      internal function frame107() : *
      {
         parent.$mc_ctrler.loop("跳招loop");
      }
      
      internal function frame110() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame125() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame129() : *
      {
         parent.$mc_ctrler.movePercent(-0.5,-1);
         parent.$mc_ctrler.dampingPercent(0.05,0.05);
         parent.$effect_ctrler.shadow(0,200,0);
      }
      
      internal function frame138() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame150() : *
      {
         parent.$mc_ctrler.move(5,0);
         parent.$mc_ctrler.damping(0.5,0);
      }
      
      internal function frame154() : *
      {
         parent.$mc_ctrler.setAttack("砍2");
      }
      
      internal function frame160() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame163() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame173() : *
      {
         parent.$mc_ctrler.move(10,0);
         parent.$mc_ctrler.damping(1,0);
      }
      
      internal function frame178() : *
      {
         parent.$mc_ctrler.setAttack("砍3");
         parent.$mc_ctrler.setSkill1();
      }
      
      internal function frame184() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame188() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame202() : *
      {
         parent.$mc_ctrler.move(10,0);
         parent.$mc_ctrler.damping(1,0);
      }
      
      internal function frame208() : *
      {
         parent.$mc_ctrler.setBishaSUPER();
         parent.$mc_ctrler.setBisha();
         parent.$mc_ctrler.setZhao2();
         parent.$mc_ctrler.setZhao1();
         parent.$mc_ctrler.setSkill1();
         parent.$mc_ctrler.setDash();
         parent.$mc_ctrler.setAttack("砍4");
      }
      
      internal function frame215() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame225() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame232() : *
      {
         parent.$mc_ctrler.move(15,0);
         parent.$mc_ctrler.damping(1.5,0);
      }
      
      internal function frame239() : *
      {
         parent.$mc_ctrler.setBisha();
         parent.$mc_ctrler.setSkill2();
      }
      
      internal function frame247() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame253() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame267() : *
      {
         parent.$mc_ctrler.addQi(10);
      }
      
      internal function frame269() : *
      {
         if(parent.$fighter_ctrler.targetInRange([0,300]))
         {
            parent.$fighter_ctrler.moveToTarget(-30,0,false);
         }
         else
         {
            parent.$fighter_ctrler.moveOnce(300,0);
         }
         parent.$mc_ctrler.move(10,0);
         parent.$mc_ctrler.damping(1,0);
      }
      
      internal function frame280() : *
      {
         parent.$mc_ctrler.setBishaSUPER();
         parent.$mc_ctrler.setBisha();
         parent.$mc_ctrler.setZhao2();
         parent.$mc_ctrler.setSkill2();
         parent.$mc_ctrler.setDash();
         parent.$mc_ctrler.setJump();
      }
      
      internal function frame290() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame303() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame341() : *
      {
         parent.$mc_ctrler.addQi(10);
         parent.$mc_ctrler.setSteelBody(true);
         parent.$mc_ctrler.move(10,-15);
         parent.$mc_ctrler.damping(0.5,1);
         parent.$effect_ctrler.shadow(0,200,0);
      }
      
      internal function frame345() : *
      {
         parent.$mc_ctrler.setSteelBody(false);
      }
      
      internal function frame351() : *
      {
         parent.$effect_ctrler.endShadow();
      }
      
      internal function frame353() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame388() : *
      {
         parent.$mc_ctrler.addQi(5);
         parent.$effect_ctrler.shadow(0,200,0);
      }
      
      internal function frame389() : *
      {
         parent.$mc_ctrler.move(20,0);
         parent.$mc_ctrler.damping(0.5,0);
      }
      
      internal function frame402() : *
      {
         parent.$effect_ctrler.endShadow();
      }
      
      internal function frame404() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame412() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame418() : *
      {
         parent.$effect_ctrler.shadow(0,200,0);
      }
      
      internal function frame419() : *
      {
         parent.$mc_ctrler.addQi(10);
      }
      
      internal function frame420() : *
      {
         parent.$mc_ctrler.move(10,-10);
         parent.$mc_ctrler.damping(0,1);
      }
      
      internal function frame423() : *
      {
         parent.$mc_ctrler.setTouchFloor("招23",true);
      }
      
      internal function frame429() : *
      {
         parent.$mc_ctrler.loop("招2_loop");
      }
      
      internal function frame430() : *
      {
         parent.$effect_ctrler.shake(0,3);
      }
      
      internal function frame437() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame448() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame464() : *
      {
         parent.$mc_ctrler.move(10,0);
         parent.$effect_ctrler.shadow(0,200,0);
      }
      
      internal function frame465() : *
      {
         parent.$mc_ctrler.addQi(5);
      }
      
      internal function frame471() : *
      {
         parent.$mc_ctrler.damping(1,0);
      }
      
      internal function frame472() : *
      {
         parent.$effect_ctrler.endShadow();
      }
      
      internal function frame477() : *
      {
         parent.$mc_ctrler.setBishaSUPER();
         parent.$mc_ctrler.setBisha();
         parent.$mc_ctrler.setSkill1();
         parent.$mc_ctrler.setSkill2();
         parent.$mc_ctrler.setZhao2();
         parent.$mc_ctrler.setZhao1();
      }
      
      internal function frame486() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame497() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame509() : *
      {
         parent.$mc_ctrler.addQi(15);
      }
      
      internal function frame513() : *
      {
         parent.$mc_ctrler.movePercent(0.3,0);
         parent.$mc_ctrler.dampingPercent(0.03,0);
      }
      
      internal function frame524() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame535() : *
      {
         parent.$mc_ctrler.addQi(30);
      }
      
      internal function frame539() : *
      {
         parent.$mc_ctrler.movePercent(0.5,0);
         parent.$mc_ctrler.dampingPercent(0.05,0);
      }
      
      internal function frame558() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame579() : *
      {
         parent.$effect_ctrler.bisha(false,"小李1");
      }
      
      internal function frame602() : *
      {
         parent.$effect_ctrler.endBisha();
      }
      
      internal function frame605() : *
      {
         if(parent.$fighter_ctrler.targetInRange([0,500]))
         {
            parent.$fighter_ctrler.moveToTarget(-20,null,false);
         }
         else
         {
            parent.$fighter_ctrler.moveOnce(500,0);
         }
      }
      
      internal function frame608() : *
      {
         parent.$effect_ctrler.shine(14917603);
      }
      
      internal function frame626() : *
      {
         parent.$mc_ctrler.justHitToPlay("bs","必杀1",false);
      }
      
      internal function frame635() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame639() : *
      {
         parent.$effect_ctrler.slowDown(1);
      }
      
      internal function frame640() : *
      {
         parent.$fighter_ctrler.moveToTarget(0,0,false);
         parent.$effect_ctrler.shadow(0,200,0);
      }
      
      internal function frame641() : *
      {
         parent.$fighter_ctrler.moveToTarget(0,0,false);
      }
      
      internal function frame642() : *
      {
         parent.$fighter_ctrler.moveToTarget(0,0,false);
      }
      
      internal function frame643() : *
      {
         parent.$fighter_ctrler.moveToTarget(0,0,false);
      }
      
      internal function frame644() : *
      {
         if(parent.$fighter_ctrler.target)
         {
            parent.$fighter_ctrler.target.visible = false;
         }
         parent.$mc_ctrler.moveTarget({"followmc":"move_mc"});
      }
      
      internal function frame653() : *
      {
         parent.$mc_ctrler.setTouchFloor("必杀2",true);
      }
      
      internal function frame654() : *
      {
         parent.$effect_ctrler.shadow(0,200,0);
      }
      
      internal function frame661() : *
      {
         gotoAndPlay("必杀LOOP");
      }
      
      internal function frame673() : *
      {
         parent.$effect_ctrler.shine();
         parent.$mc_ctrler.moveTarget(null);
         parent.$effect_ctrler.endShadow();
         parent.$effect_ctrler.shake(0,5);
         parent.$effect_ctrler.shine(16777215);
      }
      
      internal function frame674() : *
      {
         if(parent.$fighter_ctrler.target)
         {
            parent.$fighter_ctrler.target.visible = true;
         }
      }
      
      internal function frame675() : *
      {
         if(parent.$fighter_ctrler.hp > 300)
         {
            parent.$fighter_ctrler.loseHp(100);
         }
         parent.$effect_ctrler.shine(16718656);
      }
      
      internal function frame696() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame705() : *
      {
         parent.$effect_ctrler.bisha(false,"小李1");
      }
      
      internal function frame721() : *
      {
         parent.$effect_ctrler.endBisha();
      }
      
      internal function frame723() : *
      {
         parent.$mc_ctrler.move(0,10);
         parent.$mc_ctrler.setTouchFloor("空中必杀2",true);
      }
      
      internal function frame739() : *
      {
         parent.$mc_ctrler.loop("空中必杀1");
      }
      
      internal function frame752() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame772() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame799() : *
      {
         parent.$effect_ctrler.bisha(true,"小李2");
         parent.$effect_ctrler.startShake(0,3);
      }
      
      internal function frame807() : *
      {
         if(parent.$fighter_ctrler.hp > 300)
         {
            parent.$fighter_ctrler.loseHp(200);
         }
      }
      
      internal function frame838() : *
      {
         parent.$effect_ctrler.shine(14917603);
      }
      
      internal function frame840() : *
      {
         parent.$effect_ctrler.endShake();
      }
      
      internal function frame850() : *
      {
         parent.$effect_ctrler.endBisha();
      }
      
      internal function frame853() : *
      {
         parent.$fighter_ctrler.moveToTarget(0,0,false);
         parent.$mc_ctrler.move(15,-0.1);
      }
      
      internal function frame863() : *
      {
         parent.$fighter_ctrler.moveToTarget(0,0,false);
         parent.$mc_ctrler.move(15,-15);
      }
      
      internal function frame872() : *
      {
         parent.$fighter_ctrler.moveToTarget(0,0,false);
         parent.$mc_ctrler.move(-15,-0.1);
      }
      
      internal function frame880() : *
      {
         parent.$fighter_ctrler.moveToTarget(0,0,false);
         parent.$mc_ctrler.move(-15,-15);
      }
      
      internal function frame891() : *
      {
         parent.$fighter_ctrler.moveToTarget(0,0,false);
         parent.$mc_ctrler.move(15,-0.1);
      }
      
      internal function frame901() : *
      {
         parent.$fighter_ctrler.moveToTarget(0,0,false);
         parent.$mc_ctrler.move(15,-15);
      }
      
      internal function frame910() : *
      {
         parent.$fighter_ctrler.moveToTarget(0,0,false);
         parent.$mc_ctrler.move(-15,-0.1);
      }
      
      internal function frame918() : *
      {
         parent.$fighter_ctrler.moveToTarget(0,0,false);
         parent.$mc_ctrler.move(-15,-15);
      }
      
      internal function frame934() : *
      {
         parent.$fighter_ctrler.moveToTarget(0,0,false);
         parent.$mc_ctrler.move(0,20);
      }
      
      internal function frame935() : *
      {
         parent.$fighter_ctrler.moveToTarget(0,0,false);
      }
      
      internal function frame940() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame954() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame1038() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame1064() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame1139() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame1180() : *
      {
         parent.$mc_ctrler.stop();
      }
      
      internal function frame1208() : *
      {
         parent.$mc_ctrler.stop();
      }
      
      internal function frame1220() : *
      {
         parent.$effect_ctrler.startWanKai("小李2");
      }
      
      internal function frame1229() : *
      {
         parent.$fighter_ctrler.doWanKai();
      }
   }
}

