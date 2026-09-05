package tsuchikage_fla
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
      
      public var atm2:MovieClip;
      
      public var atm3:MovieClip;
      
      public var $assisterCtrler:*;
      
      public function MainTimeline()
      {
         super();
         addFrameScript(0,this.frame1,15,this.frame16,29,this.frame30,32,this.frame33,35,this.frame36,61,this.frame62);
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
            "hitType":2,
            "hitx":5,
            "hity":0,
            "hurtTime":500,
            "hurtType":0,
            "isBreakDef":false
         });
         this.$assisterCtrler.defineAction("atm2",{
            "power":50,
            "hitType":1,
            "hitx":10,
            "hity":0,
            "hurtTime":500,
            "hurtType":0,
            "isBreakDef":false
         });
         this.$assisterCtrler.defineAction("atm3",{
            "power":100,
            "hitType":3,
            "hitx":10,
            "hity":0,
            "hurtTime":0,
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
      
      internal function frame33() : *
      {
         this.$assisterCtrler.getOwner().getBuffCtrl().defenseUp(0.3,5);
      }
      
      internal function frame36() : *
      {
         this.$assisterCtrler.effect.shine(9461816);
      }
      
      internal function frame62() : *
      {
         this.$assisterCtrler.endAct();
      }
   }
}

