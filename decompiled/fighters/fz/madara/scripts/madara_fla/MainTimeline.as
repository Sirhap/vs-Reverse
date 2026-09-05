package madara_fla
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
      
      public var smc:MovieClip;
      
      public var $assisterCtrler:*;
      
      public function MainTimeline()
      {
         super();
         addFrameScript(0,this.frame1,14,this.frame15,30,this.frame31,35,this.frame36,36,this.frame37,65,this.frame66);
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
            "hitType":3,
            "hitx":0,
            "hity":0,
            "hurtTime":1000,
            "hurtType":0,
            "isBreakDef":true
         });
         this.$assisterCtrler.defineAction("atm2",{
            "power":10,
            "hitType":4,
            "hitx":0,
            "hity":0,
            "hurtTime":1000,
            "hurtType":0,
            "isBreakDef":false
         });
         this.$assisterCtrler.defineAction("atm3",{
            "power":100,
            "hitType":7,
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
      
      internal function frame15() : *
      {
         this.$assisterCtrler.effect.bisha(false);
      }
      
      internal function frame31() : *
      {
         this.$assisterCtrler.effect.endBisha();
      }
      
      internal function frame36() : *
      {
         this.$assisterCtrler.addAttacker("smc",{
            "x":{
               "moveToTarget":true,
               "offset":-20
            },
            "applyG":false
         });
      }
      
      internal function frame37() : *
      {
         this.$assisterCtrler.effect.shine(9461864);
      }
      
      internal function frame66() : *
      {
         this.$assisterCtrler.endAct();
      }
   }
}

