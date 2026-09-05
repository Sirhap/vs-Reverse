package orihime_fla
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
      
      public var main:MovieClip;
      
      public var $assisterCtrler:*;
      
      public function MainTimeline()
      {
         super();
         addFrameScript(0,this.frame1,10,this.frame11,20,this.frame21,24,this.frame25,47,this.frame48,49,this.frame50,51,this.frame52,53,this.frame54,55,this.frame56,57,this.frame58,59,this.frame60,61,this.frame62,63,this.frame64,65,this.frame66,67,this.frame68,70,this.frame71);
      }
      
      public function setAssistCtrler(param1:*) : void
      {
         this.$assisterCtrler = param1;
         this.defineActions();
      }
      
      public function defineActions() : void
      {
         this.$assisterCtrler.defineAction("atm1",{
            "power":0,
            "hitType":0,
            "hitx":0,
            "hity":0,
            "hurtTime":0,
            "hurtType":0,
            "isBreakDef":false
         });
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame11() : *
      {
         this.$assisterCtrler.move(6);
      }
      
      internal function frame21() : *
      {
         this.$assisterCtrler.move(0);
      }
      
      internal function frame25() : *
      {
         this.$assisterCtrler.effect.bisha(false);
      }
      
      internal function frame48() : *
      {
         this.$assisterCtrler.effect.endBisha();
      }
      
      internal function frame50() : *
      {
         if(this.$assisterCtrler.checkHitOwner("main"))
         {
            this.$assisterCtrler.getOwner().addHp(10);
         }
      }
      
      internal function frame52() : *
      {
         if(this.$assisterCtrler.checkHitOwner("main"))
         {
            this.$assisterCtrler.getOwner().addHp(10);
         }
      }
      
      internal function frame54() : *
      {
         if(this.$assisterCtrler.checkHitOwner("main"))
         {
            this.$assisterCtrler.getOwner().addHp(10);
         }
      }
      
      internal function frame56() : *
      {
         if(this.$assisterCtrler.checkHitOwner("main"))
         {
            this.$assisterCtrler.getOwner().addHp(10);
         }
      }
      
      internal function frame58() : *
      {
         if(this.$assisterCtrler.checkHitOwner("main"))
         {
            this.$assisterCtrler.getOwner().addHp(10);
         }
      }
      
      internal function frame60() : *
      {
         if(this.$assisterCtrler.checkHitOwner("main"))
         {
            this.$assisterCtrler.getOwner().addHp(10);
         }
      }
      
      internal function frame62() : *
      {
         if(this.$assisterCtrler.checkHitOwner("main"))
         {
            this.$assisterCtrler.getOwner().addHp(10);
         }
      }
      
      internal function frame64() : *
      {
         if(this.$assisterCtrler.checkHitOwner("main"))
         {
            this.$assisterCtrler.getOwner().addHp(10);
         }
      }
      
      internal function frame66() : *
      {
         if(this.$assisterCtrler.checkHitOwner("main"))
         {
            this.$assisterCtrler.getOwner().addHp(10);
         }
      }
      
      internal function frame68() : *
      {
         if(this.$assisterCtrler.checkHitOwner("main"))
         {
            this.$assisterCtrler.getOwner().addHp(10);
         }
      }
      
      internal function frame71() : *
      {
         this.$assisterCtrler.endAct();
      }
   }
}

