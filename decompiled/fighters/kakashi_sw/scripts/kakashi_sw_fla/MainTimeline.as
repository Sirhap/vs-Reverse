package kakashi_sw_fla
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
   
   public dynamic class MainTimeline extends MovieClip
   {
      
      public var mc:MovieClip;
      
      public var $fighter_ctrler:*;
      
      public var $mc_ctrler:*;
      
      public var $effect_ctrler:*;
      
      public var defineAction:Function;
      
      public var yh:*;
      
      public function MainTimeline()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2);
      }
      
      public function setFighterCtrler(param1:*) : void
      {
         this.$fighter_ctrler = param1;
         this.defineAction = this.$fighter_ctrler.defineAction;
      }
      
      public function setFighterMcCtrler(param1:*) : void
      {
         this.$mc_ctrler = param1;
      }
      
      public function setEffectCtrler(param1:*) : void
      {
         this.$effect_ctrler = param1;
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame2() : *
      {
         if(!this.$fighter_ctrler)
         {
            return;
         }
         this.defineAction("tk",{
            "power":20,
            "hitType":1,
            "hitx":1,
            "hity":0,
            "hurtTime":400,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("tk2",{
            "power":30,
            "hitType":3,
            "hitx":-4,
            "hity":-7,
            "hurtTime":400,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("tk3",{
            "power":60,
            "hitType":3,
            "hitx":5,
            "hity":-9,
            "hurtTime":400,
            "hurtType":1,
            "isBreakDef":false
         });
         this.defineAction("tz",{
            "power":40,
            "hitType":1,
            "hitx":2,
            "hity":2,
            "hurtTime":400,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("tz2",{
            "power":40,
            "hitType":6,
            "hitx":4,
            "hity":4,
            "hurtTime":300,
            "hurtType":1,
            "isBreakDef":false
         });
         this.defineAction("k1",{
            "power":40,
            "hitType":2,
            "hitx":3,
            "hity":0,
            "hurtTime":300,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("k2",{
            "power":40,
            "hitType":1,
            "hitx":2,
            "hity":0,
            "hurtTime":400,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("k22",{
            "power":40,
            "hitType":2,
            "hitx":2,
            "hity":-1,
            "hurtTime":400,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("k3",{
            "power":40,
            "hitType":2,
            "hitx":3,
            "hity":0,
            "hurtTime":500,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("k4",{
            "power":50,
            "hitType":3,
            "hitx":3,
            "hity":-3,
            "hurtTime":400,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("k5",{
            "power":50,
            "hitType":3,
            "hitx":5,
            "hity":-15,
            "hurtTime":900,
            "hurtType":0,
            "isBreakDef":true
         });
         this.defineAction("kj9",{
            "power":80,
            "hitType":4,
            "hitx":8,
            "hity":0,
            "hurtTime":0,
            "hurtType":0,
            "isBreakDef":true
         });
         this.defineAction("kj99",{
            "power":80,
            "hitType":5,
            "hitx":8,
            "hity":0,
            "hurtTime":0,
            "hurtType":1,
            "isBreakDef":true
         });
         this.defineAction("kj1",{
            "power":60,
            "hitType":9,
            "hitx":0,
            "hity":0,
            "hurtTime":600,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("kj12",{
            "power":40,
            "hitType":3,
            "hitx":0,
            "hity":-3,
            "hurtTime":800,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("kj6",{
            "power":20,
            "hitType":8,
            "hitx":1,
            "hity":0,
            "hurtTime":100,
            "hurtType":1,
            "isBreakDef":false
         });
         this.defineAction("kj2",{
            "power":50,
            "hitType":6,
            "hitx":0,
            "hity":7,
            "hurtTime":800,
            "hurtType":1,
            "isBreakDef":false
         });
         this.defineAction("kj26",{
            "power":70,
            "hitType":5,
            "hitx":5,
            "hity":-5,
            "hurtTime":500,
            "hurtType":1,
            "isBreakDef":false
         });
         this.defineAction("kj27",{
            "power":0,
            "hitType":0,
            "hitx":0,
            "hity":0,
            "hurtTime":500,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("zh1",{
            "power":40,
            "hitType":1,
            "hitx":3,
            "hity":0,
            "hurtTime":400,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("zh12",{
            "power":40,
            "hitType":6,
            "hitx":3,
            "hity":0,
            "hurtTime":300,
            "hurtType":1,
            "isBreakDef":false
         });
         this.defineAction("zh2",{
            "power":50,
            "hitType":11,
            "hitx":0,
            "hity":0,
            "hurtTime":900,
            "hurtType":0,
            "isBreakDef":true
         });
         this.defineAction("zh3",{
            "power":40,
            "hitType":3,
            "hitx":3,
            "hity":0,
            "hurtTime":400,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("sh1",{
            "power":0,
            "hitType":11,
            "hitx":0,
            "hity":0,
            "hurtTime":1000,
            "hurtType":0,
            "isBreakDef":true
         });
         this.defineAction("sh12",{
            "power":50,
            "hitType":3,
            "hitx":5,
            "hity":0,
            "hurtTime":1000,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("sh2",{
            "power":0,
            "hitType":11,
            "hitx":0,
            "hity":0,
            "hurtTime":1000,
            "hurtType":0,
            "isBreakDef":true
         });
         this.defineAction("sh22",{
            "power":150,
            "hitType":6,
            "hitx":-1,
            "hity":-8,
            "hurtTime":0,
            "hurtType":1,
            "isBreakDef":false
         });
         this.defineAction("bs",{
            "power":250,
            "hitType":9,
            "hitx":0,
            "hity":-10,
            "hurtTime":300,
            "hurtType":1,
            "isBreakDef":false
         });
         this.defineAction("sbs",{
            "power":250,
            "hitType":5,
            "hitx":10,
            "hity":-10,
            "hurtTime":0,
            "hurtType":1,
            "isBreakDef":false
         });
         this.defineAction("sbs0",{
            "power":10,
            "hitType":11,
            "hitx":0,
            "hity":0,
            "hurtTime":2000,
            "hurtType":0,
            "isBreakDef":true
         });
         this.defineAction("sui",{
            "power":250,
            "hitType":8,
            "hitx":5,
            "hity":-5,
            "hurtTime":0,
            "hurtType":1,
            "isBreakDef":false
         });
         this.defineAction("tu",{
            "power":180,
            "hitType":5,
            "hitx":5,
            "hity":-10,
            "hurtTime":0,
            "hurtType":1,
            "isBreakDef":false
         });
         this.defineAction("huo",{
            "power":300,
            "hitType":7,
            "hitx":5,
            "hity":5,
            "hurtTime":0,
            "hurtType":1,
            "isBreakDef":false
         });
         this.defineAction("cbs1",{
            "power":100,
            "hitType":6,
            "hitx":0,
            "hity":0,
            "hurtTime":1000,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("cbs2",{
            "power":10,
            "hitType":1,
            "hitx":3,
            "hity":0,
            "hurtTime":1000,
            "hurtType":0,
            "isBreakDef":true
         });
         this.defineAction("cbs3",{
            "power":10,
            "hitType":1,
            "hitx":-3,
            "hity":0,
            "hurtTime":1000,
            "hurtType":0,
            "isBreakDef":true
         });
         this.defineAction("cbs4",{
            "power":300,
            "hitType":9,
            "hitx":10,
            "hity":0,
            "hurtTime":1000,
            "hurtType":1,
            "isBreakDef":true
         });
         this.defineAction("leiqiebaozha",{
            "power":300,
            "hitType":9,
            "hitx":0,
            "hity":0,
            "hurtTime":5,
            "hurtType":1,
            "isBreakDef":true
         });
         this.$fighter_ctrler.defineHurtSound();
         this.$fighter_ctrler.defineHurtFlySound();
         this.$fighter_ctrler.defineDieSound();
         this.$fighter_ctrler.speed = 12;
         this.$fighter_ctrler.jumpPower = 16;
         this.$fighter_ctrler.heavy = 3;
         this.$fighter_ctrler.defenseType = 1;
         this.$fighter_ctrler.initMc(this.mc);
         this.yh = 0;
      }
   }
}

