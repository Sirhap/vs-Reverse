package temari_fla
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol505")]
   public dynamic class 佐助咒化_1 extends MovieClip
   {
      
      public var AImain:MovieClip;
      
      public var bdmn:MovieClip;
      
      public var bsatm:MovieClip;
      
      public var cbs1atm:MovieClip;
      
      public var cbsatm:MovieClip;
      
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
      
      public var tz1atm:MovieClip;
      
      public var tzatm:MovieClip;
      
      public var zh11atm:MovieClip;
      
      public var zh1atm:MovieClip;
      
      public var zh2atm:MovieClip;
      
      public var zh31atm:MovieClip;
      
      public var zh32atm:MovieClip;
      
      public var zh3atm:MovieClip;
      
      public function 佐助咒化_1()
      {
         super();
         addFrameScript(13,this.frame14,19,this.frame20,22,this.frame23,26,this.frame27,31,this.frame32,37,this.frame38,42,this.frame43,70,this.frame71,84,this.frame85,90,this.frame91,96,this.frame97,113,this.frame114,114,this.frame115,116,this.frame117,125,this.frame126,177,this.frame178,183,this.frame184,190,this.frame191,198,this.frame199,206,this.frame207,213,this.frame214,220,this.frame221,228,this.frame229,241,this.frame242,251,this.frame252,258,this.frame259,263,this.frame264,279,this.frame280,284,this.frame285,287,this.frame288,299,this.frame300,309,this.frame310,328,this.frame329,356,this.frame357,362,this.frame363,389,this.frame390,390,this.frame391,393,this.frame394,416,this.frame417,428,this.frame429,436,this.frame437,437,this.frame438,449,this.frame450,456,this.frame457,494,this.frame495,497,this.frame498,499,this.frame500,501,this.frame502,519,this.frame520,530,this.frame531,542,this.frame543,551,this.frame552,575,this.frame576,592,this.frame593,608,this.frame609,611,this.frame612,615
         ,this.frame616,616,this.frame617,618,this.frame619,643,this.frame644,680,this.frame681,699,this.frame700,702,this.frame703,707,this.frame708,732,this.frame733,783,this.frame784,813,this.frame814,815,this.frame816,920,this.frame921,925,this.frame926,1028,this.frame1029,1048,this.frame1049,1097,this.frame1098,1177,this.frame1178,1205,this.frame1206);
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
         parent.$effect_ctrler.dash();
      }
      
      internal function frame32() : *
      {
         parent.$mc_ctrler.dash(3.5);
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
      
      internal function frame85() : *
      {
         parent.$mc_ctrler.setAirMove(true);
      }
      
      internal function frame91() : *
      {
         parent.$mc_ctrler.setSkillAIR();
         parent.$mc_ctrler.setAirMove(false);
      }
      
      internal function frame97() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame114() : *
      {
         parent.$mc_ctrler.move(-7,-7);
         parent.$mc_ctrler.damping(0.7,0.7);
      }
      
      internal function frame115() : *
      {
         parent.$mc_ctrler.fire("tzatm",{
            "x":10,
            "y":10,
            "hold":2,
            "hits":1
         });
      }
      
      internal function frame117() : *
      {
         parent.$mc_ctrler.fire("tz1atm",{
            "x":10,
            "y":10,
            "hold":2,
            "hits":1
         });
      }
      
      internal function frame126() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame178() : *
      {
         parent.$mc_ctrler.movePercent(0.5,0);
         parent.$mc_ctrler.dampingPercent(0.05,0);
      }
      
      internal function frame184() : *
      {
         parent.$mc_ctrler.setAttack("砍2");
         parent.$mc_ctrler.setZhao1();
      }
      
      internal function frame191() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame199() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame207() : *
      {
         parent.$mc_ctrler.movePercent(1,0);
         parent.$mc_ctrler.dampingPercent(0.1,0);
      }
      
      internal function frame214() : *
      {
         parent.$mc_ctrler.setBishaSUPER();
         parent.$mc_ctrler.setZhao2();
         parent.$mc_ctrler.setAttack("砍3");
         parent.$mc_ctrler.setZhao1();
         parent.$mc_ctrler.setBisha();
         parent.$mc_ctrler.setSkill1();
      }
      
      internal function frame221() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame229() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame242() : *
      {
         parent.$mc_ctrler.movePercent(1.5,0);
         parent.$mc_ctrler.dampingPercent(0.15,0);
      }
      
      internal function frame252() : *
      {
         parent.$mc_ctrler.setBishaUP();
         parent.$mc_ctrler.setZhao3();
         parent.$mc_ctrler.setDash();
         parent.$mc_ctrler.setJump();
      }
      
      internal function frame259() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame264() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame280() : *
      {
         parent.$mc_ctrler.addQi(10);
      }
      
      internal function frame285() : *
      {
         parent.$mc_ctrler.movePercent(1,0);
         parent.$mc_ctrler.dampingPercent(0.1,0);
      }
      
      internal function frame288() : *
      {
         parent.$mc_ctrler.setBishaUP();
         parent.$mc_ctrler.setZhao3();
      }
      
      internal function frame300() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame310() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame329() : *
      {
         parent.$mc_ctrler.addQi(10);
      }
      
      internal function frame357() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame363() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame390() : *
      {
         parent.$mc_ctrler.addQi(5);
      }
      
      internal function frame391() : *
      {
         parent.$mc_ctrler.fire("zh1atm",{
            "x":20,
            "y":0,
            "hold":2,
            "hits":1
         });
      }
      
      internal function frame394() : *
      {
         parent.$mc_ctrler.fire("zh11atm",{
            "x":20,
            "y":0,
            "hold":2,
            "hits":1
         });
      }
      
      internal function frame417() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame429() : *
      {
         parent.$mc_ctrler.addQi(10);
         parent.$mc_ctrler.setSteelBody(true);
         parent.$mc_ctrler.movePercent(1,0);
      }
      
      internal function frame437() : *
      {
         parent.$mc_ctrler.setSteelBody(false);
      }
      
      internal function frame438() : *
      {
         parent.$mc_ctrler.dampingPercent(0.3,0);
      }
      
      internal function frame450() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame457() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame495() : *
      {
         parent.$mc_ctrler.addQi(5);
      }
      
      internal function frame498() : *
      {
         parent.$mc_ctrler.fire("zh3atm",{
            "x":15,
            "y":-15,
            "hold":2,
            "hits":1
         });
      }
      
      internal function frame500() : *
      {
         parent.$mc_ctrler.fire("zh31atm",{
            "x":15,
            "y":-15,
            "hold":2,
            "hits":1
         });
      }
      
      internal function frame502() : *
      {
         parent.$mc_ctrler.fire("zh32atm",{
            "x":15,
            "y":-15,
            "hold":2,
            "hits":1
         });
      }
      
      internal function frame520() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame531() : *
      {
         parent.$mc_ctrler.addQi(10);
      }
      
      internal function frame543() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame552() : *
      {
         parent.$mc_ctrler.addQi(20);
      }
      
      internal function frame576() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame593() : *
      {
         parent.$effect_ctrler.bisha(false,"手鞠1");
      }
      
      internal function frame609() : *
      {
         parent.$effect_ctrler.endBisha();
         parent.$mc_ctrler.setSteelBody(true);
      }
      
      internal function frame612() : *
      {
         parent.$fighter_ctrler.setCross(true);
         parent.$mc_ctrler.move(30,0);
      }
      
      internal function frame616() : *
      {
         parent.$mc_ctrler.setSteelBody(false);
      }
      
      internal function frame617() : *
      {
         parent.$fighter_ctrler.setCross(false);
         parent.$mc_ctrler.damping(3,0);
      }
      
      internal function frame619() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame644() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame681() : *
      {
         parent.$effect_ctrler.bisha(false,"手鞠1");
      }
      
      internal function frame700() : *
      {
         parent.$effect_ctrler.endBisha();
         parent.$mc_ctrler.setSteelBody(true);
      }
      
      internal function frame703() : *
      {
         parent.$mc_ctrler.setSteelBody(false);
      }
      
      internal function frame708() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame733() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame784() : *
      {
         parent.$effect_ctrler.bisha(true,"手鞠1");
      }
      
      internal function frame814() : *
      {
         parent.$effect_ctrler.endBisha();
      }
      
      internal function frame816() : *
      {
         parent.$effect_ctrler.startShake(0,3);
      }
      
      internal function frame921() : *
      {
         parent.$mc_ctrler.endAct();
         parent.$effect_ctrler.endShake();
      }
      
      internal function frame926() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame1029() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame1049() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame1098() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame1178() : *
      {
         parent.$mc_ctrler.stop();
      }
      
      internal function frame1206() : *
      {
         parent.$mc_ctrler.stop();
      }
   }
}

