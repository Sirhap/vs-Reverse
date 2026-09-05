package kenpachi_fla
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
         addFrameScript(0,this.frame1,15,this.frame16,54,this.frame55,64,this.frame65,80,this.frame81);
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
            "hitType":5,
            "hitx":15,
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
      
      internal function frame16() : *
      {
         this.$assisterCtrler.effect.bisha(false);
      }
      
      internal function frame55() : *
      {
         this.$assisterCtrler.effect.endBisha();
      }
      
      internal function frame65() : *
      {
         this.$assisterCtrler.move(10,0);
         this.$assisterCtrler.damping(1,0);
      }
      
      internal function frame81() : *
      {
         this.$assisterCtrler.endAct();
      }
   }
}

