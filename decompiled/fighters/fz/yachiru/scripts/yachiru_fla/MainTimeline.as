package yachiru_fla
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
      
      public var atmck:MovieClip;
      
      public var $assisterCtrler:*;
      
      public function MainTimeline()
      {
         super();
         addFrameScript(0,this.frame1,19,this.frame20,35,this.frame36,36,this.frame37,51,this.frame52,57,this.frame58,62,this.frame63,73,this.frame74);
      }
      
      public function setAssistCtrler(param1:*) : void
      {
         this.$assisterCtrler = param1;
         this.defineActions();
      }
      
      public function defineActions() : void
      {
         this.$assisterCtrler.defineAction("atm1",{
            "power":50,
            "hitType":3,
            "hitx":5,
            "hity":-2,
            "hurtTime":700,
            "hurtType":0,
            "isBreakDef":false
         });
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame20() : *
      {
         this.$assisterCtrler.effect.bisha(false);
      }
      
      internal function frame36() : *
      {
         this.$assisterCtrler.effect.endBisha();
      }
      
      internal function frame37() : *
      {
         this.$assisterCtrler.move(20,0);
         this.$assisterCtrler.setHitTarget("atmck","攻击2");
         this.$assisterCtrler.effect.shadow(200,-50,100);
      }
      
      internal function frame52() : *
      {
         this.$assisterCtrler.damping(2,0);
      }
      
      internal function frame58() : *
      {
         this.$assisterCtrler.finish(true);
      }
      
      internal function frame63() : *
      {
         this.$assisterCtrler.effect.shine(9461864);
         this.$assisterCtrler.setDirectToTarget();
         this.$assisterCtrler.move(-10,0);
         this.$assisterCtrler.damping(2,0);
      }
      
      internal function frame74() : *
      {
         this.$assisterCtrler.endAct();
         this.$assisterCtrler.effect.endShadow();
      }
   }
}

