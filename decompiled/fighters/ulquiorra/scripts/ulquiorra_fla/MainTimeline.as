package ulquiorra_fla
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
      
      public function MainTimeline()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2,2,this.frame3);
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
            "power":70,
            "hitType":6,
            "hitx":3,
            "hity":1,
            "hurtTime":500,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("tz",{
            "power":130,
            "hitType":5,
            "hitx":5,
            "hity":10,
            "hurtTime":0,
            "hurtType":1,
            "isBreakDef":false
         });
         this.defineAction("k1",{
            "power":20,
            "hitType":2,
            "hitx":5,
            "hity":0,
            "hurtTime":300,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("k2",{
            "power":30,
            "hitType":1,
            "hitx":5,
            "hity":0,
            "hurtTime":300,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("k3",{
            "power":70,
            "hitType":3,
            "hitx":8,
            "hity":0,
            "hurtTime":700,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("kj1",{
            "power":80,
            "hitType":1,
            "hitx":10,
            "hity":-5,
            "hurtTime":600,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("kj12",{
            "power":100,
            "hitType":5,
            "hitx":10,
            "hity":-5,
            "hurtTime":0,
            "hurtType":1,
            "isBreakDef":false
         });
         this.defineAction("kj2",{
            "power":100,
            "hitType":6,
            "hitx":8,
            "hity":-10,
            "hurtTime":600,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("zh1",{
            "power":100,
            "hitType":5,
            "hitx":10,
            "hity":0,
            "hurtTime":0,
            "hurtType":1,
            "isBreakDef":false
         });
         this.defineAction("zh2",{
            "power":40,
            "hitType":4,
            "hitx":5,
            "hity":-7,
            "hurtTime":800,
            "hurtType":0,
            "isBreakDef":true
         });
         this.defineAction("zh3",{
            "power":120,
            "hitType":5,
            "hitx":10,
            "hity":-8,
            "hurtTime":0,
            "hurtType":1,
            "isBreakDef":false
         });
         this.defineAction("bs",{
            "power":280,
            "hitType":5,
            "hitx":25,
            "hity":0,
            "hurtTime":0,
            "hurtType":1,
            "isBreakDef":false
         });
         this.defineAction("sbs",{
            "power":10,
            "hitType":1,
            "hitx":13,
            "hity":-13,
            "hurtTime":500,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("sbs1",{
            "power":200,
            "hitType":5,
            "hitx":20,
            "hity":5,
            "hurtTime":0,
            "hurtType":1,
            "isBreakDef":false
         });
         this.defineAction("kbs",{
            "power":10,
            "hitType":1,
            "hitx":13,
            "hity":13,
            "hurtTime":500,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("kbs1",{
            "power":250,
            "hitType":5,
            "hitx":20,
            "hity":5,
            "hurtTime":0,
            "hurtType":1,
            "isBreakDef":false
         });
         this.defineAction("cbs1",{
            "power":150,
            "hitType":5,
            "hitx":30,
            "hity":-10,
            "hurtTime":0,
            "hurtType":1,
            "isBreakDef":true
         });
         this.defineAction("cbs",{
            "power":50,
            "hitType":4,
            "hitx":10,
            "hity":-0.1,
            "hurtTime":1000,
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
            "hitType":0,
            "hitx":-7,
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
            "hitType":5,
            "hitx":15,
            "hity":0,
            "hurtTime":0,
            "hurtType":1,
            "isBreakDef":false
         });
         this.$fighter_ctrler.defineBishaFace("小乌1",bsface1);
         this.$fighter_ctrler.speed = 12;
         this.$fighter_ctrler.jumpPower = 15;
         this.$fighter_ctrler.heavy = 2;
         this.$fighter_ctrler.defenseType = 1;
         this.$fighter_ctrler.initMc(this.mc);
      }
      
      internal function frame3() : *
      {
         if(!this.$fighter_ctrler)
         {
            return;
         }
         this.defineAction("tk",{
            "power":80,
            "hitType":5,
            "hitx":6,
            "hity":0,
            "hurtTime":500,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("tz",{
            "power":120,
            "hitType":5,
            "hitx":10,
            "hity":7,
            "hurtTime":0,
            "hurtType":1,
            "isBreakDef":false
         });
         this.defineAction("k1",{
            "power":30,
            "hitType":1,
            "hitx":4,
            "hity":0,
            "hurtTime":300,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("k2",{
            "power":30,
            "hitType":1,
            "hitx":3,
            "hity":0,
            "hurtTime":300,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("k3",{
            "power":60,
            "hitType":6,
            "hitx":5,
            "hity":0,
            "hurtTime":500,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("k4",{
            "power":100,
            "hitType":5,
            "hitx":15,
            "hity":0,
            "hurtTime":0,
            "hurtType":1,
            "isBreakDef":false
         });
         this.defineAction("kj1",{
            "power":160,
            "hitType":5,
            "hitx":15,
            "hity":0,
            "hurtTime":0,
            "hurtType":1,
            "isBreakDef":true
         });
         this.defineAction("kj21",{
            "power":40,
            "hitType":1,
            "hitx":0,
            "hity":-18,
            "hurtTime":600,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("kj22",{
            "power":30,
            "hitType":1,
            "hitx":0,
            "hity":-1,
            "hurtTime":500,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("kj2",{
            "power":130,
            "hitType":7,
            "hitx":10,
            "hity":10,
            "hurtTime":0,
            "hurtType":1,
            "isBreakDef":false
         });
         this.defineAction("zh1",{
            "power":150,
            "hitType":5,
            "hitx":10,
            "hity":0,
            "hurtTime":0,
            "hurtType":1,
            "isBreakDef":false
         });
         this.defineAction("zh2",{
            "power":100,
            "hitType":6,
            "hitx":10,
            "hity":-10,
            "hurtTime":700,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("zh3",{
            "power":160,
            "hitType":6,
            "hitx":10,
            "hity":-7,
            "hurtTime":0,
            "hurtType":1,
            "isBreakDef":false
         });
         this.defineAction("bs1",{
            "power":40,
            "hitType":4,
            "hitx":5,
            "hity":0,
            "hurtTime":500,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("bs",{
            "power":50,
            "hitType":5,
            "hitx":15,
            "hity":0,
            "hurtTime":0,
            "hurtType":1,
            "isBreakDef":false
         });
         this.defineAction("sbs",{
            "power":260,
            "hitType":5,
            "hitx":5,
            "hity":-10,
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
            "power":100,
            "hitType":6,
            "hitx":0,
            "hity":-1,
            "hurtTime":1000,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("cbs",{
            "power":300,
            "hitType":5,
            "hitx":20,
            "hity":0,
            "hurtTime":0,
            "hurtType":1,
            "isBreakDef":true
         });
         this.defineAction("kbs1",{
            "power":20,
            "hitType":2,
            "hitx":0,
            "hity":10,
            "hurtTime":400,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("kbs",{
            "power":250,
            "hitType":5,
            "hitx":15,
            "hity":10,
            "hurtTime":0,
            "hurtType":1,
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
            "hitType":6,
            "hitx":-7,
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
            "hitx":2,
            "hity":-5,
            "hurtTime":0,
            "hurtType":1,
            "isBreakDef":false
         });
         this.$fighter_ctrler.defineBishaFace("小乌1",bsface1);
         this.$fighter_ctrler.speed = 14;
         this.$fighter_ctrler.jumpPower = 16;
         this.$fighter_ctrler.heavy = 2;
         this.$fighter_ctrler.defenseType = 0;
         this.$fighter_ctrler.initMc(this.mc);
      }
   }
}

