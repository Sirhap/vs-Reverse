package harribel_fla
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
         addFrameScript(0,this.frame1,15,this.frame16,29,this.frame30,31,this.frame32,32,this.frame33,42,this.frame43,54,this.frame55);
      }
      
      public function setAssistCtrler(param1:*) : void
      {
         this.$assisterCtrler = param1;
         this.defineActions();
      }
      
      public function defineActions() : void
      {
         this.$assisterCtrler.defineAction("atm1",{
            "power":110,
            "hitType":5,
            "hitx":10,
            "hity":0,
            "hurtTime":500,
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
      
      internal function frame30() : *
      {
         this.$assisterCtrler.effect.endBisha();
      }
      
      internal function frame32() : *
      {
         this.$assisterCtrler.move(30,0);
      }
      
      internal function frame33() : *
      {
         this.$assisterCtrler.effect.shine(9461864);
      }
      
      internal function frame43() : *
      {
         this.$assisterCtrler.damping(3,0);
      }
      
      internal function frame55() : *
      {
         this.$assisterCtrler.endAct();
      }
   }
}

