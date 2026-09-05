package gaara_fla
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol500")]
   public dynamic class Timeline_1 extends MovieClip
   {
      
      public var sh22atm:MovieClip;
      
      public var tzatm:MovieClip;
      
      public var sbsatm:MovieClip;
      
      public var sh12atm:MovieClip;
      
      public var zh2atm:MovieClip;
      
      public var sbs1atm:MovieClip;
      
      public var zzzz:MovieClip;
      
      public var sbs3atm:MovieClip;
      
      public var sbs2atm:MovieClip;
      
      public var sh1atm:MovieClip;
      
      public var bdmn:MovieClip;
      
      public var sh2atm:MovieClip;
      
      public var AImain:MovieClip;
      
      public var kj1atm:MovieClip;
      
      public var k1atm:MovieClip;
      
      public var k3atm:MovieClip;
      
      public var move_mc:MovieClip;
      
      public var kj2atm:MovieClip;
      
      public var k2atm:MovieClip;
      
      public var zh1atm:MovieClip;
      
      public var zzz1:MovieClip;
      
      public var tkatm:MovieClip;
      
      public var zz:*;
      
      public var zz1:*;
      
      public var zz2:*;
      
      public var justHit:*;
      
      public var bsmc1:*;
      
      public var bsmc:*;
      
      public function Timeline_1()
      {
         super();
         addFrameScript(11,this.frame12,17,this.frame18,22,this.frame23,25,this.frame26,27,this.frame28,34,this.frame35,39,this.frame40,69,this.frame70,81,this.frame82,86,this.frame87,90,this.frame91,95,this.frame96,96,this.frame97,104,this.frame105,112,this.frame113,131,this.frame132,136,this.frame137,140,this.frame141,152,this.frame153,159,this.frame160,169,this.frame170,173,this.frame174,187,this.frame188,193,this.frame194,209,this.frame210,224,this.frame225,225,this.frame226,245,this.frame246,260,this.frame261,268,this.frame269,269,this.frame270,274,this.frame275,280,this.frame281,286,this.frame287,299,this.frame300,321,this.frame322,328,this.frame329,338,this.frame339,345,this.frame346,357,this.frame358,365,this.frame366,393,this.frame394,401,this.frame402,405,this.frame406,421,this.frame422,431,this.frame432,436,this.frame437,451,this.frame452,459,this.frame460,470,this.frame471,477,this.frame478,504,this.frame505,519,this.frame520,531,this.frame532,532,this.frame533,534,this.frame535,552,this
         .frame553,553,this.frame554,572,this.frame573,597,this.frame598,603,this.frame604,623,this.frame624,644,this.frame645,659,this.frame660,679,this.frame680,692,this.frame693,708,this.frame709,711,this.frame712,712,this.frame713,721,this.frame722,741,this.frame742,746,this.frame747,767,this.frame768,786,this.frame787,824,this.frame825,826,this.frame827,833,this.frame834,836,this.frame837,865,this.frame866,867,this.frame868,886,this.frame887,936,this.frame937,966,this.frame967,1054,this.frame1055,1074,this.frame1075,1172,this.frame1173,1213,this.frame1214,1241,this.frame1242);
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
      
      internal function frame26() : *
      {
         parent.$effect_ctrler.dash();
      }
      
      internal function frame28() : *
      {
         parent.$mc_ctrler.dash(3);
         parent.$mc_ctrler.setBisha();
         parent.$mc_ctrler.setBishaUP();
         parent.$mc_ctrler.setBishaSUPER();
      }
      
      internal function frame35() : *
      {
         parent.$mc_ctrler.dashStop();
      }
      
      internal function frame40() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame70() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame82() : *
      {
         parent.$mc_ctrler.move(0,-2);
         parent.$mc_ctrler.damping(0,0.2);
      }
      
      internal function frame87() : *
      {
         parent.$mc_ctrler.setSkillAIR();
      }
      
      internal function frame91() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame96() : *
      {
         parent.$mc_ctrler.move(0,-2);
         parent.$mc_ctrler.damping(0,0.05);
      }
      
      internal function frame97() : *
      {
         parent.$mc_ctrler.addQi(5);
      }
      
      internal function frame105() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame113() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame132() : *
      {
         parent.$mc_ctrler.setAttack("砍2");
      }
      
      internal function frame137() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame141() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame153() : *
      {
         parent.$mc_ctrler.setBishaSUPER();
         parent.$mc_ctrler.setAttack("砍3");
         parent.$mc_ctrler.setSkill1();
         parent.$mc_ctrler.setSkill2();
      }
      
      internal function frame160() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame170() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame174() : *
      {
         parent.$mc_ctrler.movePercent(1,0);
         parent.$mc_ctrler.dampingPercent(0.1,0);
      }
      
      internal function frame188() : *
      {
         parent.$mc_ctrler.setBishaUP();
         parent.$mc_ctrler.setBisha();
         parent.$mc_ctrler.setZhao2();
         parent.$mc_ctrler.setZhao3();
         parent.$mc_ctrler.setZhao1("招11");
         parent.$mc_ctrler.setDash();
      }
      
      internal function frame194() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame210() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame225() : *
      {
         parent.$mc_ctrler.movePercent(1.5,0);
         parent.$mc_ctrler.dampingPercent(0.15,0);
      }
      
      internal function frame226() : *
      {
         parent.$mc_ctrler.addQi(10);
      }
      
      internal function frame246() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame261() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame269() : *
      {
         parent.$mc_ctrler.addQi(10);
      }
      
      internal function frame270() : *
      {
         parent.$effect_ctrler.slowDown(0.5);
         parent.$mc_ctrler.addAttacker("zzz1",{"x":{
            "followTarget":true,
            "offset":0,
            "range":[0,250]
         }});
      }
      
      internal function frame275() : *
      {
         parent.$mc_ctrler.setJump();
      }
      
      internal function frame281() : *
      {
         parent.$mc_ctrler.setSkill1();
         parent.$mc_ctrler.setSkill2();
         parent.$mc_ctrler.setBishaUP();
         parent.$mc_ctrler.setBishaSUPER();
      }
      
      internal function frame287() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame300() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame322() : *
      {
         parent.$mc_ctrler.addQi(5);
      }
      
      internal function frame329() : *
      {
         parent.$mc_ctrler.fire("zh1atm",{
            "x":{
               "start":5,
               "max":30,
               "add":0.5
            },
            "y":0,
            "hold":3,
            "hits":-1
         });
      }
      
      internal function frame339() : *
      {
         parent.$mc_ctrler.setBisha();
      }
      
      internal function frame346() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame358() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame366() : *
      {
         parent.$mc_ctrler.addQi(10);
      }
      
      internal function frame394() : *
      {
         parent.$mc_ctrler.setBishaUP();
         parent.$mc_ctrler.setBisha();
      }
      
      internal function frame402() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame406() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame422() : *
      {
         parent.$mc_ctrler.addQi(5);
      }
      
      internal function frame432() : *
      {
         parent.$effect_ctrler.shine(9074006);
      }
      
      internal function frame437() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame452() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame460() : *
      {
         parent.$mc_ctrler.addQi(10);
      }
      
      internal function frame471() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame478() : *
      {
         parent.$mc_ctrler.addQi(20);
      }
      
      internal function frame505() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame520() : *
      {
         parent.$effect_ctrler.bisha(false,"我爱罗1");
      }
      
      internal function frame532() : *
      {
         parent.$effect_ctrler.endBisha();
      }
      
      internal function frame533() : *
      {
         parent.$effect_ctrler.slowDown(0.5);
      }
      
      internal function frame535() : *
      {
         parent.$mc_ctrler.addAttacker("zzzz",{"x":{
            "followTarget":true,
            "offset":0,
            "range":[0,400]
         }});
      }
      
      internal function frame553() : *
      {
         if(!parent.$fighter_ctrler.justHit("bs1"))
         {
            parent.$mc_ctrler.gotoAndPlay("必杀1");
         }
      }
      
      internal function frame554() : *
      {
         if(parent.$fighter_ctrler.target)
         {
            parent.$fighter_ctrler.target.visible = false;
         }
         this.zz = parent.$mc_ctrler.getAttacker("zzzz");
         if(this.zz)
         {
            this.zz.gotoAndPlay("fly");
         }
      }
      
      internal function frame573() : *
      {
         this.zz1 = parent.$mc_ctrler.getAttacker("zzzz");
         if(this.zz1)
         {
            this.zz1.gotoAndPlay("boom");
         }
         parent.$effect_ctrler.shine();
      }
      
      internal function frame598() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame604() : *
      {
         parent.$mc_ctrler.endAct();
         this.zz2 = parent.$mc_ctrler.getAttacker("zzzz");
         if(this.zz2)
         {
            this.zz2.gotoAndPlay("miss");
         }
      }
      
      internal function frame624() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame645() : *
      {
         parent.$effect_ctrler.bisha(false,"我爱罗1");
      }
      
      internal function frame660() : *
      {
         parent.$effect_ctrler.endBisha();
      }
      
      internal function frame680() : *
      {
         parent.$effect_ctrler.shine(9074006);
      }
      
      internal function frame693() : *
      {
         this.justHit = parent.$fighter_ctrler.justHit("sbs3");
         if(this.justHit)
         {
            parent.$mc_ctrler.moveTarget({"followmc":"move_mc"});
            if(parent.$fighter_ctrler.target)
            {
               parent.$fighter_ctrler.target.visible = false;
            }
         }
      }
      
      internal function frame709() : *
      {
         if(!this.justHit)
         {
            parent.$mc_ctrler.gotoAndPlay("上必杀2");
         }
      }
      
      internal function frame712() : *
      {
         parent.$effect_ctrler.shine();
      }
      
      internal function frame713() : *
      {
         if(parent.$fighter_ctrler.target)
         {
            parent.$fighter_ctrler.target.visible = true;
         }
      }
      
      internal function frame722() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame742() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame747() : *
      {
         parent.$mc_ctrler.endAct();
      }
      
      internal function frame768() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame787() : *
      {
         parent.$effect_ctrler.bisha(true,"我爱罗2");
      }
      
      internal function frame825() : *
      {
         parent.$effect_ctrler.endBisha();
         parent.$effect_ctrler.slowDown(1);
      }
      
      internal function frame827() : *
      {
         parent.$mc_ctrler.addAttacker("bsmc",{
            "x":{
               "followTarget":true,
               "offset":10,
               "range":[0,500]
            },
            "y":{
               "followTarget":true,
               "offset":-15,
               "range":[-250,250]
            },
            "applyG":false
         });
      }
      
      internal function frame834() : *
      {
         parent.$mc_ctrler.justHitToPlay("cbs1","超必杀HIT",false,false);
      }
      
      internal function frame837() : *
      {
         this.bsmc1 = parent.$mc_ctrler.getAttacker("bsmc");
         if(this.bsmc1)
         {
            this.bsmc1.gotoAndPlay("miss");
         }
      }
      
      internal function frame866() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame868() : *
      {
         parent.$fighter_ctrler.setTargetVelocity(0,-3);
      }
      
      internal function frame887() : *
      {
         this.bsmc = parent.$mc_ctrler.getAttacker("bsmc");
         if(this.bsmc)
         {
            this.bsmc.gotoAndPlay("start");
         }
      }
      
      internal function frame937() : *
      {
         if(this.bsmc)
         {
            this.bsmc.gotoAndPlay("big");
         }
         parent.$effect_ctrler.slowDown(0.5);
      }
      
      internal function frame967() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame1055() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame1075() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame1173() : *
      {
         parent.$mc_ctrler.idle();
      }
      
      internal function frame1214() : *
      {
         parent.$mc_ctrler.stop();
      }
      
      internal function frame1242() : *
      {
         parent.$mc_ctrler.stop();
      }
   }
}

