package sasuke_xz_old_fla
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol739")]
   public dynamic class Timeline_1 extends MovieClip
   {
      
      public var k4atm:MovieClip;
      
      public var cbsatm:MovieClip;
      
      public var tianzhao:MovieClip;
      
      public var sh22atm:MovieClip;
      
      public var zh3atm:MovieClip;
      
      public var tzatm:MovieClip;
      
      public var sbsatm:MovieClip;
      
      public var sh12atm:MovieClip;
      
      public var zh2atm:MovieClip;
      
      public var cbs1atm:MovieClip;
      
      public var zh21atm:MovieClip;
      
      public var cbs3atm:MovieClip;
      
      public var sh1atm:MovieClip;
      
      public var tk1atm:MovieClip;
      
      public var cbs2atm:MovieClip;
      
      public var zh32atm:MovieClip;
      
      public var bdmn:MovieClip;
      
      public var zh22atm:MovieClip;
      
      public var sh2atm:MovieClip;
      
      public var kj21atm:MovieClip;
      
      public var tk2atm:MovieClip;
      
      public var AImain:MovieClip;
      
      public var kbsatm:MovieClip;
      
      public var kj10atm:MovieClip;
      
      public var kj22atm:MovieClip;
      
      public var kj13atm:MovieClip;
      
      public var kj1atm:MovieClip;
      
      public var k1atm:MovieClip;
      
      public var kj12atm:MovieClip;
      
      public var k3atm:MovieClip;
      
      public var kbs2atm:MovieClip;
      
      public var move_mc:MovieClip;
      
      public var kj2atm:MovieClip;
      
      public var k2atm:MovieClip;
      
      public var zh1atm:MovieClip;
      
      public var k5atm:MovieClip;
      
      public var tkatm:MovieClip;
      
      public function Timeline_1()
      {
         super();
         addFrameScript(11,this.frame12,13,this.frame14,22,this.frame23,26,this.frame27,29,this.frame30,59,this.frame60,69,this.frame70,78,this.frame79,82,this.frame83,86,this.frame87,95,this.frame96,97,this.frame98,112,this.frame113,124,this.frame125,141,this.frame142,150,this.frame151,168,this.frame169,178,this.frame179,182,this.frame183,190,this.frame191,202,this.frame203,223,this.frame224,227,this.frame228,233,this.frame234,239,this.frame240,248,this.frame249,259,this.frame260,265,this.frame266,268,this.frame269,280,this.frame281,292,this.frame293,299,this.frame300,306,this.frame307,317,this.frame318,323,this.frame324,329,this.frame330,336,this.frame337,344,this.frame345,359,this.frame360,373,this.frame374,381,this.frame382,389,this.frame390,402,this.frame403,403,this.frame404,412,this.frame413,415,this.frame416,420,this.frame421,422,this.frame423,428,this.frame429,435,this.frame436,441,this.frame442,450,this.frame451,453,this.frame454,454,this.frame455,455,this.frame456,472,this.frame473,480
         ,this.frame481,501,this.frame502,508,this.frame509,510,this.frame511,511,this.frame512,514,this.frame515,529,this.frame530,537,this.frame538,544,this.frame545,550,this.frame551,572,this.frame573,585,this.frame586,603,this.frame604,629,this.frame630,642,this.frame643,645,this.frame646,656,this.frame657,658,this.frame659,667,this.frame668,679,this.frame680,690,this.frame691,699,this.frame700,700,this.frame701,716,this.frame717,745,this.frame746,750,this.frame751,766,this.frame767,783,this.frame784,794,this.frame795,807,this.frame808,817,this.frame818,837,this.frame838,850,this.frame851,875,this.frame876,878,this.frame879,941,this.frame942,957,this.frame958,994,this.frame995,1001,this.frame1002,1045,this.frame1046,1064,this.frame1065,1070,this.frame1071,1095,this.frame1096,1098,this.frame1099,1099,this.frame1100,1130,this.frame1131,1158,this.frame1159,1161,this.frame1162,1205,this.frame1206,1212,this.frame1213,1288,this.frame1289,1365,this.frame1366,1367,this.frame1368,1369,this.frame1370,1392
         ,this.frame1393,1486,this.frame1487,1546,this.frame1547,1574,this.frame1575);
      }
      
      internal function frame12() : *
      {
         parent.$effect_ctrler.walk();
      }
      
      internal function frame14() : *
      {
         parent.$mc_ctrler.loop("走");
      }
      
      internal function frame23() : *
      {
         parent.$mc_ctrler.dash(5);
         parent.$effect_ctrler.dash();
      }
      
      internal function frame27() : *
      {
         parent.$mc_ctrler.dashStop();
      }
      
      internal function frame30() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame60() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame70() : *
      {
         parent.$mc_ctrler.setAirMove(true);
      }
      
      internal function frame79() : *
      {
         parent.$mc_ctrler.setSkillAIR();
         parent.$mc_ctrler.setBishaAIR();
         if(parent.$fighter_ctrler.justHit("tk2"))
         {
            parent.$mc_ctrler.setAttackAIR("跳砍0");
         }
         else
         {
            parent.$mc_ctrler.setAttackAIR("跳砍1");
         }
      }
      
      internal function frame83() : *
      {
         parent.$mc_ctrler.setTouchFloor("落地",true);
      }
      
      internal function frame87() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame96() : *
      {
         parent.$fighter_ctrler.moveToTarget(-30,0,true);
      }
      
      internal function frame98() : *
      {
         parent.$mc_ctrler.move(14,-4);
         parent.$mc_ctrler.damping(0.3,0.1);
      }
      
      internal function frame113() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame125() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame142() : *
      {
         parent.$mc_ctrler.isApplyG(false);
         parent.$effect_ctrler.slowDown(0.5);
      }
      
      internal function frame151() : *
      {
         parent.$mc_ctrler.isApplyG(true);
         parent.$mc_ctrler.setTouchFloor("跳招2",true);
         parent.$mc_ctrler.movePercent(1.5,1);
         parent.$effect_ctrler.shine(5422583);
         parent.$effect_ctrler.shadow(110,-50,255);
      }
      
      internal function frame169() : *
      {
         parent.$mc_ctrler.endAct();
         parent.$mc_ctrler.dampingPercent(0.1,0.1);
      }
      
      internal function frame179() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame183() : *
      {
         parent.$effect_ctrler.shake(0,3);
         parent.$effect_ctrler.endShadow();
      }
      
      internal function frame191() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame203() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame224() : *
      {
         parent.$mc_ctrler.move(4,0);
         parent.$mc_ctrler.damping(0.4,0);
      }
      
      internal function frame228() : *
      {
         parent.$mc_ctrler.setAttack("砍2");
      }
      
      internal function frame234() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame240() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame249() : *
      {
         parent.$mc_ctrler.move(7,0);
         parent.$mc_ctrler.damping(0.7,0);
      }
      
      internal function frame260() : *
      {
         parent.$mc_ctrler.setAttack("砍3");
      }
      
      internal function frame266() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame269() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame281() : *
      {
         parent.$mc_ctrler.move(6,0);
         parent.$mc_ctrler.damping(0.4,0);
      }
      
      internal function frame293() : *
      {
         parent.$mc_ctrler.setBishaUP();
         parent.$mc_ctrler.setZhao1();
         parent.$mc_ctrler.setAttack("砍4");
      }
      
      internal function frame300() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame307() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame318() : *
      {
         parent.$mc_ctrler.move(10,0);
      }
      
      internal function frame324() : *
      {
         parent.$mc_ctrler.damping(2,0);
      }
      
      internal function frame330() : *
      {
         parent.$mc_ctrler.setBishaSUPER();
         parent.$mc_ctrler.setBisha();
         parent.$mc_ctrler.setSkill1();
         parent.$mc_ctrler.setAttack("砍5");
      }
      
      internal function frame337() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame345() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame360() : *
      {
         parent.$mc_ctrler.move(8,0);
         parent.$mc_ctrler.damping(0.4,0);
      }
      
      internal function frame374() : *
      {
         parent.$mc_ctrler.setDash();
      }
      
      internal function frame382() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame390() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame403() : *
      {
         parent.$mc_ctrler.setHitTarget("kj10atm","砍技11");
         parent.$mc_ctrler.movePercent(2,0);
         parent.$effect_ctrler.shadow(110,-50,255);
      }
      
      internal function frame404() : *
      {
         parent.$mc_ctrler.addQi(10);
         parent.$effect_ctrler.dash();
      }
      
      internal function frame413() : *
      {
         parent.$mc_ctrler.dampingPercent(0.2,0);
      }
      
      internal function frame416() : *
      {
         parent.$effect_ctrler.endShadow();
      }
      
      internal function frame421() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame423() : *
      {
         parent.$effect_ctrler.shine();
      }
      
      internal function frame429() : *
      {
         parent.$mc_ctrler.setBisha();
         parent.$mc_ctrler.setSkill2();
         parent.$mc_ctrler.setZhao1();
         parent.$mc_ctrler.setSkill1("砍技12");
         parent.$mc_ctrler.setAttack("砍技12");
      }
      
      internal function frame436() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame442() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame451() : *
      {
         parent.$effect_ctrler.dash();
      }
      
      internal function frame454() : *
      {
         parent.$mc_ctrler.move(100,0);
         parent.$mc_ctrler.damping(50,0);
      }
      
      internal function frame455() : *
      {
         parent.$mc_ctrler.move(7,0);
      }
      
      internal function frame456() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame473() : *
      {
         parent.$mc_ctrler.damping(0.5,0);
         parent.$effect_ctrler.shine(5422583);
      }
      
      internal function frame481() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame502() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame509() : *
      {
         parent.$mc_ctrler.addQi(10);
         parent.$effect_ctrler.dash();
      }
      
      internal function frame511() : *
      {
         parent.$fighter_ctrler.moveToTarget(50,0,true);
      }
      
      internal function frame512() : *
      {
         parent.$effect_ctrler.slowDown(0.5);
      }
      
      internal function frame515() : *
      {
         parent.$mc_ctrler.move(4,0);
      }
      
      internal function frame530() : *
      {
         parent.$mc_ctrler.damping(0.4,0);
      }
      
      internal function frame538() : *
      {
         parent.$mc_ctrler.setBishaUP();
         parent.$mc_ctrler.setZhao3();
         parent.$mc_ctrler.setJump();
      }
      
      internal function frame545() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame551() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame573() : *
      {
         parent.$mc_ctrler.addQi(5);
      }
      
      internal function frame586() : *
      {
         parent.$effect_ctrler.shine(5422583);
      }
      
      internal function frame604() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame630() : *
      {
         parent.$mc_ctrler.addQi(10);
      }
      
      internal function frame643() : *
      {
         parent.$effect_ctrler.shine(6968203);
      }
      
      internal function frame646() : *
      {
         parent.$mc_ctrler.justHitToPlay("zh2","招21",false);
      }
      
      internal function frame657() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame659() : *
      {
         parent.$mc_ctrler.moveTarget({"followmc":"move_mc"});
      }
      
      internal function frame668() : *
      {
         parent.$effect_ctrler.shine(6968203);
         parent.$effect_ctrler.shake(0,4);
      }
      
      internal function frame680() : *
      {
         parent.$effect_ctrler.shine(6968203);
         parent.$effect_ctrler.shake(0,4);
      }
      
      internal function frame691() : *
      {
         parent.$effect_ctrler.shine(6968203);
         parent.$effect_ctrler.shake(0,4);
      }
      
      internal function frame700() : *
      {
         parent.$mc_ctrler.moveTarget(null);
      }
      
      internal function frame701() : *
      {
         if(parent.$fighter_ctrler.target)
         {
            parent.$fighter_ctrler.target.visible = true;
         }
      }
      
      internal function frame717() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame746() : *
      {
         parent.$mc_ctrler.addQi(5);
      }
      
      internal function frame751() : *
      {
         parent.$effect_ctrler.shine(5422583);
      }
      
      internal function frame767() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame784() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame795() : *
      {
         parent.$mc_ctrler.addQi(10);
      }
      
      internal function frame808() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame818() : *
      {
         parent.$mc_ctrler.addQi(20);
      }
      
      internal function frame838() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame851() : *
      {
         parent.$effect_ctrler.bisha(false,"须佐助1");
      }
      
      internal function frame876() : *
      {
         parent.$effect_ctrler.endBisha();
      }
      
      internal function frame879() : *
      {
         parent.$effect_ctrler.shine(0);
         parent.$mc_ctrler.addAttacker("tianzhao",{
            "x":{
               "moveToTarget":true,
               "offset":0
            },
            "applyG":false
         });
      }
      
      internal function frame942() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame958() : *
      {
         parent.$effect_ctrler.bisha(false,"须佐助2");
      }
      
      internal function frame995() : *
      {
         parent.$effect_ctrler.endBisha();
      }
      
      internal function frame1002() : *
      {
         parent.$effect_ctrler.shine(0);
      }
      
      internal function frame1046() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame1065() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame1071() : *
      {
         parent.$effect_ctrler.bisha(false,"佐助1");
      }
      
      internal function frame1096() : *
      {
         parent.$effect_ctrler.endBisha();
      }
      
      internal function frame1099() : *
      {
         parent.$mc_ctrler.move(-5,-12);
         parent.$mc_ctrler.damping(0.3,0.3);
      }
      
      internal function frame1100() : *
      {
         parent.$effect_ctrler.shine(15663104);
      }
      
      internal function frame1131() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame1159() : *
      {
         parent.$effect_ctrler.shine(648163);
      }
      
      internal function frame1162() : *
      {
         parent.$effect_ctrler.bisha(true,"须佐助2");
      }
      
      internal function frame1206() : *
      {
         parent.$effect_ctrler.endBisha();
      }
      
      internal function frame1213() : *
      {
         parent.$effect_ctrler.shine(5422583);
      }
      
      internal function frame1289() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame1366() : *
      {
         parent.$mc_ctrler.move(5,0);
      }
      
      internal function frame1368() : *
      {
         parent.$mc_ctrler.stopMove();
      }
      
      internal function frame1370() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame1393() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame1487() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame1547() : *
      {
         parent.$mc_ctrler.stop();
      }
      
      internal function frame1575() : *
      {
         parent.$mc_ctrler.stop();
      }
   }
}

