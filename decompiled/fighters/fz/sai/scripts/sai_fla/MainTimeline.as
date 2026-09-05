package sai_fla
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
      
      public var atmmc:MovieClip;
      
      public var $assisterCtrler:*;
      
      public function MainTimeline()
      {
         super();
         addFrameScript(0,this.frame1,14,this.frame15,29,this.frame30,31,this.frame32,32,this.frame33,53,this.frame54);
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
            "hitType":4,
            "hitx":0,
            "hity":-5,
            "hurtTime":800,
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
         this.$assisterCtrler.getOwner().getBuffCtrl().speedUp(5,5);
      }
      
      internal function frame30() : *
      {
         this.$assisterCtrler.effect.endBisha();
      }
      
      internal function frame32() : *
      {
         this.$assisterCtrler.addAttacker("atmmc",{
            "x":{
               "moveToTarget":true,
               "offset":0
            },
            "applyG":false
         });
      }
      
      internal function frame33() : *
      {
         this.$assisterCtrler.effect.shine(0);
      }
      
      internal function frame54() : *
      {
         this.$assisterCtrler.endAct();
      }
   }
}

