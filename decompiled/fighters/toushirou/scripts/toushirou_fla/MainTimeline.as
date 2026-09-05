package toushirou_fla
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
            "power":40,
            "hitType":1,
            "hitx":5,
            "hity":0,
            "hurtTime":400,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("tz",{
            "power":100,
            "hitType":8,
            "hitx":5,
            "hity":5,
            "hurtTime":500,
            "hurtType":1,
            "isBreakDef":false
         });
         this.defineAction("tz1",{
            "power":100,
            "hitType":8,
            "hitx":5,
            "hity":5,
            "hurtTime":500,
            "hurtType":1,
            "isBreakDef":false
         });
         this.defineAction("tz2",{
            "power":100,
            "hitType":8,
            "hitx":5,
            "hity":5,
            "hurtTime":0,
            "hurtType":1,
            "isBreakDef":false
         });
         this.defineAction("k1",{
            "power":30,
            "hitType":1,
            "hitx":2,
            "hity":0,
            "hurtTime":300,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("k2",{
            "power":40,
            "hitType":1,
            "hitx":3,
            "hity":0,
            "hurtTime":500,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("k3",{
            "power":70,
            "hitType":6,
            "hitx":5,
            "hity":-5,
            "hurtTime":400,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("kj1",{
            "power":100,
            "hitType":5,
            "hitx":8,
            "hity":-4,
            "hurtTime":0,
            "hurtType":1,
            "isBreakDef":false
         });
         this.defineAction("kj21",{
            "power":50,
            "hitType":1,
            "hitx":3,
            "hity":0,
            "hurtTime":300,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("kj2",{
            "power":70,
            "hitType":8,
            "hitx":5,
            "hity":0,
            "hurtTime":0,
            "hurtType":1,
            "isBreakDef":false
         });
         this.defineAction("zh1",{
            "power":25,
            "hitType":4,
            "hitx":5,
            "hity":0,
            "hurtTime":200,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("zh12",{
            "power":25,
            "hitType":4,
            "hitx":5,
            "hity":0,
            "hurtTime":200,
            "hurtType":1,
            "isBreakDef":false
         });
         this.defineAction("zh2",{
            "power":50,
            "hitType":8,
            "hitx":2,
            "hity":0,
            "hurtTime":1000,
            "hurtType":0,
            "isBreakDef":true
         });
         this.defineAction("zh3",{
            "power":40,
            "hitType":4,
            "hitx":6,
            "hity":-7,
            "hurtTime":500,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("bs",{
            "power":50,
            "hitType":4,
            "hitx":15,
            "hity":0,
            "hurtTime":400,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("bs2",{
            "power":100,
            "hitType":5,
            "hitx":20,
            "hity":0,
            "hurtTime":0,
            "hurtType":1,
            "isBreakDef":false
         });
         this.defineAction("sbs1",{
            "power":50,
            "hitType":6,
            "hitx":10,
            "hity":-3,
            "hurtTime":500,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("sbs2",{
            "power":50,
            "hitType":1,
            "hitx":10,
            "hity":-3,
            "hurtTime":500,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("sbs",{
            "power":50,
            "hitType":1,
            "hitx":10,
            "hity":-3,
            "hurtTime":0,
            "hurtType":1,
            "isBreakDef":false
         });
         this.defineAction("cbs1",{
            "power":10,
            "hitType":4,
            "hitx":0,
            "hity":0,
            "hurtTime":1000,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("cbs",{
            "power":300,
            "hitType":5,
            "hitx":0,
            "hity":-10,
            "hurtTime":0,
            "hurtType":1,
            "isBreakDef":true
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
            "hitx":10,
            "hity":-10,
            "hurtTime":0,
            "hurtType":1,
            "isBreakDef":false
         });
         this.$fighter_ctrler.defineBishaFace("日番谷1",bsface1);
         this.$fighter_ctrler.defineBishaFace("日番谷2",bsface2);
         this.$fighter_ctrler.defineBishaFace("日番谷3",bsface3);
         this.$fighter_ctrler.defineHurtSound(snd_hurt1);
         this.$fighter_ctrler.defineHurtFlySound(snd_hurt2);
         this.$fighter_ctrler.defineDieSound(snd_hurt2);
         this.$fighter_ctrler.speed = 8;
         this.$fighter_ctrler.jumpPower = 16;
         this.$fighter_ctrler.heavy = 2;
         this.$fighter_ctrler.defenseType = 0;
         this.$fighter_ctrler.initMc(this.mc);
      }
      
      internal function frame3() : *
      {
         if(!this.$fighter_ctrler)
         {
            return;
         }
         this.defineAction("tk",{
            "power":30,
            "hitType":1,
            "hitx":0,
            "hity":3,
            "hurtTime":400,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("tz",{
            "power":80,
            "hitType":5,
            "hitx":10,
            "hity":10,
            "hurtTime":0,
            "hurtType":1,
            "isBreakDef":false
         });
         this.defineAction("k1",{
            "power":30,
            "hitType":1,
            "hitx":3,
            "hity":0,
            "hurtTime":400,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("k2",{
            "power":40,
            "hitType":1,
            "hitx":4,
            "hity":0,
            "hurtTime":400,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("k3",{
            "power":50,
            "hitType":6,
            "hitx":7,
            "hity":-7,
            "hurtTime":500,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("kj1",{
            "power":80,
            "hitType":6,
            "hitx":10,
            "hity":0,
            "hurtTime":0,
            "hurtType":1,
            "isBreakDef":true
         });
         this.defineAction("kj21",{
            "power":50,
            "hitType":6,
            "hitx":5,
            "hity":-10,
            "hurtTime":600,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("kj2",{
            "power":100,
            "hitType":5,
            "hitx":10,
            "hity":10,
            "hurtTime":0,
            "hurtType":1,
            "isBreakDef":false
         });
         this.defineAction("zh1",{
            "power":80,
            "hitType":6,
            "hitx":0,
            "hity":-6,
            "hurtTime":300,
            "hurtType":1,
            "isBreakDef":false
         });
         this.defineAction("zh21",{
            "power":30,
            "hitType":6,
            "hitx":10,
            "hity":-3,
            "hurtTime":500,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("zh22",{
            "power":30,
            "hitType":1,
            "hitx":10,
            "hity":-3,
            "hurtTime":500,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("zh2",{
            "power":30,
            "hitType":1,
            "hitx":10,
            "hity":-3,
            "hurtTime":0,
            "hurtType":1,
            "isBreakDef":false
         });
         this.defineAction("zh3",{
            "power":40,
            "hitType":4,
            "hitx":5,
            "hity":-7,
            "hurtTime":500,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("bs",{
            "power":50,
            "hitType":8,
            "hitx":0,
            "hity":0,
            "hurtTime":1000,
            "hurtType":0,
            "isBreakDef":true
         });
         this.defineAction("bs1",{
            "power":200,
            "hitType":5,
            "hitx":20,
            "hity":0,
            "hurtTime":0,
            "hurtType":1,
            "isBreakDef":true
         });
         this.defineAction("sbs",{
            "power":320,
            "hitType":6,
            "hitx":3,
            "hity":-8,
            "hurtTime":0,
            "hurtType":1,
            "isBreakDef":false
         });
         this.defineAction("cbs1",{
            "power":10,
            "hitType":4,
            "hitx":0,
            "hity":10,
            "hurtTime":0,
            "hurtType":0,
            "isBreakDef":false
         });
         this.defineAction("cbs",{
            "power":400,
            "hitType":5,
            "hitx":20,
            "hity":0,
            "hurtTime":0,
            "hurtType":1,
            "isBreakDef":false
         });
         this.defineAction("cbs3",{
            "power":10,
            "hitType":4,
            "hitx":0,
            "hity":-1,
            "hurtTime":5000,
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
            "hitType":6,
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
            "hitType":5,
            "hitx":20,
            "hity":0,
            "hurtTime":0,
            "hurtType":1,
            "isBreakDef":false
         });
         this.$fighter_ctrler.defineBishaFace("日番谷1",bsface1);
         this.$fighter_ctrler.defineBishaFace("日番谷2",bsface2);
         this.$fighter_ctrler.defineBishaFace("日番谷3",bsface3);
         this.$fighter_ctrler.defineHurtSound(snd_hurt1);
         this.$fighter_ctrler.defineHurtFlySound(snd_hurt2);
         this.$fighter_ctrler.defineDieSound(snd_hurt2);
         this.$fighter_ctrler.speed = 10;
         this.$fighter_ctrler.jumpPower = 18;
         this.$fighter_ctrler.heavy = 4;
         this.$fighter_ctrler.defenseType = 0;
         this.$fighter_ctrler.initMc(this.mc);
      }
   }
}

