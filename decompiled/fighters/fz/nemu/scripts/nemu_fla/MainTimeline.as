package nemu_fla
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
      
      public var ckm:MovieClip;
      
      public var $assisterCtrler:*;
      
      public function MainTimeline()
      {
         super();
         addFrameScript(0,this.frame1,14,this.frame15,30,this.frame31,31,this.frame32,50,this.frame51,56,this.frame57,64,this.frame65,71,this.frame72,74,this.frame75,81,this.frame82,92,this.frame93);
      }
      
      public function setAssistCtrler(param1:*) : void
      {
         this.$assisterCtrler = param1;
         this.defineActions();
      }
      
      public function defineActions() : void
      {
         this.$assisterCtrler.defineAction("atm1",{
            "power":20,
            "hitType":2,
            "hitx":3,
            "hity":0,
            "hurtTime":500,
            "hurtType":0,
            "isBreakDef":false
         });
         this.$assisterCtrler.defineAction("atm2",{
            "power":40,
            "hitType":3,
            "hitx":10,
            "hity":0,
            "hurtTime":500,
            "hurtType":0,
            "isBreakDef":true
         });
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame15() : *
      {
         this.$assisterCtrler.effect.bisha(false);
      }
      
      internal function frame31() : *
      {
         this.$assisterCtrler.effect.endBisha();
      }
      
      internal function frame32() : *
      {
         this.$assisterCtrler.move(20,0);
         this.$assisterCtrler.setHitTarget("ckm","攻击2");
         this.$assisterCtrler.effect.shadow(100,-50,100);
      }
      
      internal function frame51() : *
      {
         this.$assisterCtrler.effect.shine(9461864);
         this.$assisterCtrler.move(5,0);
         this.$assisterCtrler.damping(1,0);
      }
      
      internal function frame57() : *
      {
         this.$assisterCtrler.move(5,0);
         this.$assisterCtrler.damping(1,0);
      }
      
      internal function frame65() : *
      {
         this.$assisterCtrler.justHit("atm1","attack2",false);
      }
      
      internal function frame72() : *
      {
         this.$assisterCtrler.finish(true);
      }
      
      internal function frame75() : *
      {
         this.$assisterCtrler.move(13,0);
         this.$assisterCtrler.damping(0.5,0);
      }
      
      internal function frame82() : *
      {
         this.$assisterCtrler.setDirectToTarget();
         this.$assisterCtrler.effect.endShadow();
      }
      
      internal function frame93() : *
      {
         this.$assisterCtrler.endAct();
      }
   }
}

