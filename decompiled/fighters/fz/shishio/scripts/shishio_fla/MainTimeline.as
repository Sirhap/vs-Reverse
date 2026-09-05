package shishio_fla
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
      
      public var atm1:MovieClip;
      
      public var atm2:MovieClip;
      
      public var atm3:MovieClip;
      
      public var ckmc:MovieClip;
      
      public var $assisterCtrler:*;
      
      public function MainTimeline()
      {
         super();
         addFrameScript(0,this.frame1,15,this.frame16,34,this.frame35,35,this.frame36,54,this.frame55,56,this.frame57,59,this.frame60,65,this.frame66,80,this.frame81,95,this.frame96);
      }
      
      public function setAssistCtrler(param1:*) : void
      {
         this.$assisterCtrler = param1;
         this.defineActions();
      }
      
      public function defineActions() : void
      {
         this.$assisterCtrler.defineAction("atm1",{
            "power":10,
            "hitType":11,
            "hitx":0,
            "hity":0,
            "hurtTime":500,
            "hurtType":0,
            "isBreakDef":true
         });
         this.$assisterCtrler.defineAction("atm3",{
            "power":50,
            "hitType":1,
            "hitx":0,
            "hity":0,
            "hurtTime":500,
            "hurtType":0,
            "isBreakDef":false
         });
         this.$assisterCtrler.defineAction("atm2",{
            "power":50,
            "hitType":7,
            "hitx":15,
            "hity":0,
            "hurtTime":0,
            "hurtType":1,
            "isBreakDef":false
         });
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame16() : *
      {
         this.$assisterCtrler.effect.bisha(false);
      }
      
      internal function frame35() : *
      {
         this.$assisterCtrler.effect.endBisha();
      }
      
      internal function frame36() : *
      {
         this.$assisterCtrler.effect.dash();
         this.$assisterCtrler.move(15,0);
         this.$assisterCtrler.setHitTarget("ckmc","攻击2");
         this.$assisterCtrler.effect.shadow(0,0,200);
      }
      
      internal function frame55() : *
      {
         this.$assisterCtrler.effect.endShadow();
      }
      
      internal function frame57() : *
      {
         this.$assisterCtrler.endAct();
      }
      
      internal function frame60() : *
      {
         this.$assisterCtrler.move(0,0);
         this.$assisterCtrler.finish();
      }
      
      internal function frame66() : *
      {
         this.$assisterCtrler.effect.shine(9461864);
         this.$assisterCtrler.move(0,0);
         this.$assisterCtrler.effect.endShadow();
      }
      
      internal function frame81() : *
      {
         this.$assisterCtrler.effect.shine(16281600);
      }
      
      internal function frame96() : *
      {
         this.$assisterCtrler.endAct();
      }
   }
}

