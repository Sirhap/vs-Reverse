package obito_fla
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
         addFrameScript(0,this.frame1,12,this.frame13,27,this.frame28,38,this.frame39,39,this.frame40,45,this.frame46,63,this.frame64);
      }
      
      public function setAssistCtrler(param1:*) : void
      {
         this.$assisterCtrler = param1;
         this.defineActions();
      }
      
      public function defineActions() : void
      {
         this.$assisterCtrler.defineAction("atm1",{
            "power":100,
            "hitType":7,
            "hitx":5,
            "hity":5,
            "hurtTime":700,
            "hurtType":0,
            "isBreakDef":false
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
      }
      
      internal function frame39() : *
      {
         this.$assisterCtrler.moveToTarget(30,-20,true);
         this.$assisterCtrler.move(-1,-1);
      }
      
      internal function frame40() : *
      {
         this.$assisterCtrler.effect.slowDown(0.5);
      }
      
      internal function frame46() : *
      {
         this.$assisterCtrler.move(-5,-5);
         this.$assisterCtrler.damping(0.1,0.1);
      }
      
      internal function frame64() : *
      {
         this.$assisterCtrler.endAct();
      }
   }
}

