package soifon_fla
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
         addFrameScript(0,this.frame1,15,this.frame16,44,this.frame45,48,this.frame49,75,this.frame76);
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
            "hitType":7,
            "hitx":15,
            "hity":-8,
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
      
      internal function frame45() : *
      {
         this.$assisterCtrler.effect.endBisha();
      }
      
      internal function frame49() : *
      {
         this.$assisterCtrler.effect.shine();
         this.$assisterCtrler.fire("atm1",{
            "x":{
               "start":0,
               "add":2,
               "max":50
            },
            "hits":1,
            "hold":5,
            "hp":300
         });
      }
      
      internal function frame76() : *
      {
         this.$assisterCtrler.endAct();
      }
   }
}

