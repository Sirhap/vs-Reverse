package yin_fla
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
         addFrameScript(0,this.frame1,12,this.frame13,39,this.frame40,42,this.frame43,54,this.frame55);
      }
      
      public function setAssistCtrler(param1:*) : void
      {
         this.$assisterCtrler = param1;
         this.defineActions();
      }
      
      public function defineActions() : void
      {
         this.$assisterCtrler.defineAction("atm1",{
            "power":150,
            "hitType":5,
            "hitx":10,
            "hity":0,
            "hurtTime":0,
            "hurtType":1,
            "isBreakDef":true
         });
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame13() : *
      {
         this.$assisterCtrler.effect.bisha();
      }
      
      internal function frame40() : *
      {
         this.$assisterCtrler.effect.endBisha();
      }
      
      internal function frame43() : *
      {
         this.$assisterCtrler.effect.shine();
         this.$assisterCtrler.effect.shine(1069248);
      }
      
      internal function frame55() : *
      {
         this.$assisterCtrler.endAct();
      }
   }
}

