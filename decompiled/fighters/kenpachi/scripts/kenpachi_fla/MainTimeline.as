package kenpachi_fla
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
            "power":70,
            "hitType":6,
            "hitx":0,
            "hity":15,
            "hurtTime":500,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("tz",{
            "power":130,
            "hitType":5,
            "hitx":10,
            "hity":0,
            "hurtTime":0,
            "hurtType":1,
            "isBreakDef":false
         });
         this.defineAction("tz1",{
            "power":20,
            "hitType":4,
            "hitx":0,
            "hity":30,
            "hurtTime":300,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("k1",{
            "power":40,
            "hitType":1,
            "hitx":3,
            "hity":0,
            "hurtTime":200,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("k2",{
            "power":40,
            "hitType":1,
            "hitx":4,
            "hity":0,
            "hurtTime":300,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("k3",{
            "power":70,
            "hitType":6,
            "hitx":4,
            "hity":-6,
            "hurtTime":500,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("kj11",{
            "power":40,
            "hitType":1,
            "hitx":6,
            "hity":0,
            "hurtTime":400,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("kj1",{
            "power":60,
            "hitType":7,
            "hitx":10,
            "hity":0,
            "hurtTime":0,
            "hurtType":1,
            "isBreakDef":true
         });
         this.defineAction("kj2",{
            "power":70,
            "hitType":6,
            "hitx":1,
            "hity":0,
            "hurtTime":500,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("kj21",{
            "power":70,
            "hitType":6,
            "hitx":5,
            "hity":-8,
            "hurtTime":500,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("zh1",{
            "power":120,
            "hitType":5,
            "hitx":20,
            "hity":0,
            "hurtTime":500,
            "hurtType":1,
            "isBreakDef":false
         });
         this.defineAction("zh2",{
            "power":200,
            "hitType":9,
            "hitx":10,
            "hity":-5,
            "hurtTime":500,
            "hurtType":1,
            "isBreakDef":true
         });
         this.defineAction("zh3",{
            "power":130,
            "hitType":9,
            "hitx":12,
            "hity":-6,
            "hurtTime":0,
            "hurtType":1,
            "isBreakDef":false
         });
         this.defineAction("bs1",{
            "power":100,
            "hitType":6,
            "hitx":20,
            "hity":0,
            "hurtTime":1000,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("bs",{
            "power":100,
            "hitType":5,
            "hitx":20,
            "hity":0,
            "hurtTime":0,
            "hurtType":1,
            "isBreakDef":true
         });
         this.defineAction("sbs1",{
            "power":20,
            "hitType":1,
            "hitx":1,
            "hity":-1,
            "hurtTime":300,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("sbs",{
            "power":40,
            "hitType":5,
            "hitx":10,
            "hity":0,
            "hurtTime":0,
            "hurtType":1,
            "isBreakDef":false
         });
         this.defineAction("cbs1",{
            "power":40,
            "hitType":6,
            "hitx":6,
            "hity":0,
            "hurtTime":1000,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("cbs2",{
            "power":20,
            "hitType":1,
            "hitx":4,
            "hity":0,
            "hurtTime":2000,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("cbs3",{
            "power":40,
            "hitType":6,
            "hitx":2,
            "hity":-4,
            "hurtTime":1000,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("cbs4",{
            "power":10,
            "hitType":1,
            "hitx":1,
            "hity":-0.2,
            "hurtTime":1000,
            "hurtType":0,
            "isBreakDef":true
         });
         this.defineAction("cbs5",{
            "power":20,
            "hitType":2,
            "hitx":3,
            "hity":-3,
            "hurtTime":1000,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("cbs",{
            "power":60,
            "hitType":7,
            "hitx":15,
            "hity":-15,
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
            "power":30,
            "hitType":1,
            "hitx":0,
            "hity":0,
            "hurtTime":1000,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("sh23",{
            "power":100,
            "hitType":5,
            "hitx":15,
            "hity":-5,
            "hurtTime":0,
            "hurtType":1,
            "isBreakDef":false
         });
         this.$fighter_ctrler.defineBishaFace("剑八1",bsface1);
         this.$fighter_ctrler.defineBishaFace("剑八2",bsface2);
         this.$fighter_ctrler.defineHurtSound(snd_hurt1);
         this.$fighter_ctrler.defineHurtFlySound(snd_hurt1);
         this.$fighter_ctrler.defineDieSound(snd_hurt1);
         this.$fighter_ctrler.speed = 10;
         this.$fighter_ctrler.jumpPower = 16;
         this.$fighter_ctrler.heavy = 5;
         this.$fighter_ctrler.defenseType = 0;
         this.$fighter_ctrler.initMc(this.mc);
      }
   }
}

