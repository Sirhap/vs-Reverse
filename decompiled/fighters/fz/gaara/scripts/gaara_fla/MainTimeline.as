package gaara_fla
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
         addFrameScript(0,this.frame1,15,this.frame16,37,this.frame38,43,this.frame44);
      }
      
      public function setAssistCtrler(param1:*) : void
      {
         this.$assisterCtrler = param1;
         this.defineActions();
      }
      
      public function defineActions() : void
      {
         this.$assisterCtrler.defineAction("atm1",{
            "power":50,
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
      
      internal function frame16() : *
      {
         this.$assisterCtrler.effect.bisha(false);
      }
      
      internal function frame38() : *
      {
         this.$assisterCtrler.effect.endBisha();
      }
      
      internal function frame44() : *
      {
         this.$assisterCtrler.effect.shine(9461816);
         this.$assisterCtrler.addAttacker("atmmc",{
            "x":{
               "moveToTarget":true,
               "offset":0
            },
            "applyG":false
         });
      }
   }
}

