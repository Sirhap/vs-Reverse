package kon_fla
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
         addFrameScript(0,this.frame1,14,this.frame15,29,this.frame30,66,this.frame67,68,this.frame69);
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
            "hitType":2,
            "hitx":1,
            "hity":0,
            "hurtTime":300,
            "hurtType":0,
            "isBreakDef":false
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
      
      internal function frame30() : *
      {
         this.$assisterCtrler.effect.endBisha();
      }
      
      internal function frame67() : *
      {
         this.$assisterCtrler.endAct();
      }
      
      internal function frame69() : *
      {
         this.$assisterCtrler.getOwner().getBuffCtrl().attackUp(0.3,5);
      }
   }
}

