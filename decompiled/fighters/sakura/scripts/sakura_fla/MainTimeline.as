package sakura_fla
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
            "power":40,
            "hitType":2,
            "hitx":4,
            "hity":8,
            "hurtTime":500,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("tz1",{
            "power":10,
            "hitType":2,
            "hitx":6,
            "hity":8,
            "hurtTime":500,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("tz",{
            "power":100,
            "hitType":3,
            "hitx":10,
            "hity":-5,
            "hurtTime":500,
            "hurtType":1,
            "isBreakDef":false
         });
         this.defineAction("k1",{
            "power":30,
            "hitType":2,
            "hitx":3,
            "hity":0,
            "hurtTime":300,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("k2",{
            "power":40,
            "hitType":2,
            "hitx":5,
            "hity":0,
            "hurtTime":400,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("k3",{
            "power":60,
            "hitType":3,
            "hitx":5,
            "hity":0,
            "hurtTime":600,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("kj1",{
            "power":30,
            "hitType":2,
            "hitx":10,
            "hity":0,
            "hurtTime":500,
            "hurtType":0,
            "isBreakDef":true
         });
         this.defineAction("kj11",{
            "power":80,
            "hitType":3,
            "hitx":9,
            "hity":-3,
            "hurtTime":0,
            "hurtType":1,
            "isBreakDef":false
         });
         this.defineAction("kj21",{
            "power":30,
            "hitType":2,
            "hitx":6,
            "hity":-1,
            "hurtTime":400,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("kj2",{
            "power":60,
            "hitType":3,
            "hitx":4,
            "hity":-5,
            "hurtTime":500,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("zh1",{
            "power":30,
            "hitType":1,
            "hitx":3,
            "hity":0,
            "hurtTime":500,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("zh12",{
            "power":30,
            "hitType":6,
            "hitx":3,
            "hity":0,
            "hurtTime":500,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("zh2",{
            "power":60,
            "hitType":3,
            "hitx":7,
            "hity":-8,
            "hurtTime":700,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("zh3",{
            "power":130,
            "hitType":6,
            "hitx":5,
            "hity":-5,
            "hurtTime":500,
            "hurtType":1,
            "isBreakDef":false
         });
         this.defineAction("zh31",{
            "power":130,
            "hitType":6,
            "hitx":5,
            "hity":-5,
            "hurtTime":500,
            "hurtType":1,
            "isBreakDef":false
         });
         this.defineAction("zh32",{
            "power":130,
            "hitType":6,
            "hitx":5,
            "hity":-5,
            "hurtTime":500,
            "hurtType":1,
            "isBreakDef":false
         });
         this.defineAction("bs",{
            "power":200,
            "hitType":5,
            "hitx":10,
            "hity":-4,
            "hurtTime":0,
            "hurtType":1,
            "isBreakDef":true
         });
         this.defineAction("bs1",{
            "power":30,
            "hitType":4,
            "hitx":0,
            "hity":0,
            "hurtTime":500,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("sbs2",{
            "power":10,
            "hitType":2,
            "hitx":0,
            "hity":10,
            "hurtTime":500,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("sbs",{
            "power":200,
            "hitType":3,
            "hitx":10,
            "hity":0,
            "hurtTime":0,
            "hurtType":1,
            "isBreakDef":false
         });
         this.defineAction("kbs2",{
            "power":10,
            "hitType":2,
            "hitx":0,
            "hity":10,
            "hurtTime":500,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("kbs",{
            "power":250,
            "hitType":3,
            "hitx":10,
            "hity":0,
            "hurtTime":0,
            "hurtType":1,
            "isBreakDef":false
         });
         this.defineAction("cbs1",{
            "power":30,
            "hitType":2,
            "hitx":0,
            "hity":-0.1,
            "hurtTime":1000,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("cbs2",{
            "power":50,
            "hitType":3,
            "hitx":0,
            "hity":0,
            "hurtTime":1000,
            "hurtType":0,
            "isBreakDef":true
         });
         this.defineAction("cbs",{
            "power":100,
            "hitType":3,
            "hitx":20,
            "hity":-2,
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
            "power":150,
            "hitType":3,
            "hitx":10,
            "hity":10,
            "hurtTime":0,
            "hurtType":1,
            "isBreakDef":false
         });
         this.$fighter_ctrler.defineBishaFace("樱1",bsface1);
         this.$fighter_ctrler.defineBishaFace("樱2",bsface1);
         this.$fighter_ctrler.speed = 6;
         this.$fighter_ctrler.jumpPower = 15;
         this.$fighter_ctrler.heavy = 2;
         this.$fighter_ctrler.defenseType = 1;
         this.$fighter_ctrler.initMc(this.mc);
      }
   }
}

