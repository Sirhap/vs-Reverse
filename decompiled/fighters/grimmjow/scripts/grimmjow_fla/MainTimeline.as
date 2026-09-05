package grimmjow_fla
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
      
      public function MainTimeline()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2);
      }
      
      public function setFighterCtrler(param1:*) : void
      {
         this.$fighter_ctrler = param1;
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
         this.$fighter_ctrler.defineAction("tk",{
            "power":40,
            "hitType":3,
            "hitx":2,
            "hity":-5,
            "hurtTime":400,
            "hurtType":0,
            "isBreakDef":false
         });
         this.$fighter_ctrler.defineAction("tz",{
            "power":70,
            "hitType":3,
            "hitx":5,
            "hity":15,
            "hurtTime":300,
            "hurtType":1,
            "isBreakDef":false
         });
         this.$fighter_ctrler.defineAction("k1",{
            "power":30,
            "hitType":2,
            "hitx":1,
            "hity":0,
            "hurtTime":300,
            "hurtType":0,
            "isBreakDef":false
         });
         this.$fighter_ctrler.defineAction("k2",{
            "power":30,
            "hitType":2,
            "hitx":3,
            "hity":0,
            "hurtTime":300,
            "hurtType":0,
            "isBreakDef":false
         });
         this.$fighter_ctrler.defineAction("k3",{
            "power":50,
            "hitType":3,
            "hitx":6,
            "hity":0,
            "hurtTime":400,
            "hurtType":0,
            "isBreakDef":false
         });
         this.$fighter_ctrler.defineAction("k4",{
            "power":70,
            "hitType":6,
            "hitx":6,
            "hity":-8,
            "hurtTime":500,
            "hurtType":0,
            "isBreakDef":false
         });
         this.$fighter_ctrler.defineAction("kj1",{
            "power":15,
            "hitType":1,
            "hitx":1,
            "hity":0,
            "hurtTime":300,
            "hurtType":0,
            "isBreakDef":false
         });
         this.$fighter_ctrler.defineAction("kj2",{
            "power":120,
            "hitType":6,
            "hitx":2,
            "hity":-5,
            "hurtTime":0,
            "hurtType":1,
            "isBreakDef":false
         });
         this.$fighter_ctrler.defineAction("zh1",{
            "power":120,
            "hitType":5,
            "hitx":10,
            "hity":0,
            "hurtTime":0,
            "hurtType":1,
            "isBreakDef":false
         });
         this.$fighter_ctrler.defineAction("zh2",{
            "power":100,
            "hitType":5,
            "hitx":10,
            "hity":-5,
            "hurtTime":0,
            "hurtType":1,
            "isBreakDef":true
         });
         this.$fighter_ctrler.defineAction("zh31",{
            "power":20,
            "hitType":2,
            "hitx":0,
            "hity":0,
            "hurtTime":500,
            "hurtType":0,
            "isBreakDef":false
         });
         this.$fighter_ctrler.defineAction("zh3",{
            "power":80,
            "hitType":6,
            "hitx":5,
            "hity":15,
            "hurtTime":0,
            "hurtType":1,
            "isBreakDef":false
         });
         this.$fighter_ctrler.defineAction("sh1",{
            "power":10,
            "hitType":11,
            "hitx":0,
            "hity":0,
            "hurtTime":1000,
            "hurtType":0,
            "isBreakDef":true
         });
         this.$fighter_ctrler.defineAction("sh12",{
            "power":50,
            "hitType":3,
            "hitx":6,
            "hity":0,
            "hurtTime":1000,
            "hurtType":0,
            "isBreakDef":false
         });
         this.$fighter_ctrler.defineAction("sh2",{
            "power":10,
            "hitType":11,
            "hitx":0,
            "hity":0,
            "hurtTime":1000,
            "hurtType":0,
            "isBreakDef":true
         });
         this.$fighter_ctrler.defineAction("sh22",{
            "power":150,
            "hitType":6,
            "hitx":5,
            "hity":10,
            "hurtTime":0,
            "hurtType":1,
            "isBreakDef":false
         });
         this.$fighter_ctrler.defineAction("bs",{
            "power":300,
            "hitType":5,
            "hitx":10,
            "hity":0,
            "hurtTime":0,
            "hurtType":1,
            "isBreakDef":false
         });
         this.$fighter_ctrler.defineAction("kbs",{
            "power":20,
            "hitType":1,
            "hitx":8,
            "hity":8,
            "hurtTime":500,
            "hurtType":0,
            "isBreakDef":false
         });
         this.$fighter_ctrler.defineAction("kbs1",{
            "power":200,
            "hitType":5,
            "hitx":8,
            "hity":-4,
            "hurtTime":0,
            "hurtType":1,
            "isBreakDef":false
         });
         this.$fighter_ctrler.defineAction("cbs1",{
            "power":30,
            "hitType":4,
            "hitx":0,
            "hity":20,
            "hurtTime":1000,
            "hurtType":0,
            "isBreakDef":false
         });
         this.$fighter_ctrler.defineAction("cbs",{
            "power":150,
            "hitType":5,
            "hitx":0,
            "hity":0,
            "hurtTime":1000,
            "hurtType":0,
            "isBreakDef":false
         });
         this.$fighter_ctrler.defineAction("cbs2",{
            "power":30,
            "hitType":4,
            "hitx":0,
            "hity":-1,
            "hurtTime":1000,
            "hurtType":0,
            "isBreakDef":false
         });
         this.$fighter_ctrler.defineAction("cbs3",{
            "power":30,
            "hitType":4,
            "hitx":10,
            "hity":-5,
            "hurtTime":0,
            "hurtType":1,
            "isBreakDef":false
         });
         this.$fighter_ctrler.defineBishaFace("葛力姆乔1",bsface1);
         this.$fighter_ctrler.defineBishaFace("葛力姆乔2",bsface2);
         this.$fighter_ctrler.defineBishaFace("葛力姆乔3",bsface3);
         this.$fighter_ctrler.defineHurtSound(snd_hurt4,snd_hurt3);
         this.$fighter_ctrler.defineHurtFlySound(snd_hurt1,snd_hurt2);
         this.$fighter_ctrler.defineDieSound(snd_die);
         this.$fighter_ctrler.speed = 12;
         this.$fighter_ctrler.jumpPower = 15;
         this.$fighter_ctrler.heavy = 3;
         this.$fighter_ctrler.initMc(this.mc);
      }
   }
}

