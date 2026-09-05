package ino_fla
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
         addFrameScript(0,this.frame1,19,this.frame20,35,this.frame36,40,this.frame41,44,this.frame45,55,this.frame56);
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
            "hitType":5,
            "hitx":0,
            "hity":0,
            "hurtTime":2000,
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
      
      internal function frame41() : *
      {
         this.$assisterCtrler.effect.shine();
      }
      
      internal function frame45() : *
      {
         this.$assisterCtrler.effect.shine(9461816);
      }
      
      internal function frame56() : *
      {
         this.$assisterCtrler.endAct();
      }
   }
}

