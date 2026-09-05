package hinata_fla
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
      
      public var $assisterCtrler:*;
      
      public function MainTimeline()
      {
         super();
         addFrameScript(0,this.frame1,12,this.frame13,27,this.frame28,29,this.frame30,48,this.frame49);
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
            "hitType":4,
            "hitx":5,
            "hity":0,
            "hurtTime":1000,
            "hurtType":0,
            "isBreakDef":true
         });
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame13() : *
      {
         this.$assisterCtrler.effect.bisha(false);
      }
      
      internal function frame28() : *
      {
         this.$assisterCtrler.effect.endBisha();
         this.$assisterCtrler.move(5,0);
         this.$assisterCtrler.damping(0.5,0);
      }
      
      internal function frame30() : *
      {
         this.$assisterCtrler.effect.shine();
      }
      
      internal function frame49() : *
      {
         this.$assisterCtrler.endAct();
      }
   }
}

