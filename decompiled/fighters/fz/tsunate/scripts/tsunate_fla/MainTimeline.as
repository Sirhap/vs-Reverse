package tsunate_fla
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
      
      public var main:MovieClip;
      
      public var $assisterCtrler:*;
      
      public function MainTimeline()
      {
         super();
         addFrameScript(0,this.frame1,6,this.frame7,9,this.frame10,12,this.frame13,15,this.frame16,18,this.frame19,21,this.frame22,24,this.frame25,27,this.frame28,38,this.frame39,44,this.frame45,59,this.frame60);
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
            "hitx":15,
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
      
      internal function frame7() : *
      {
         if(this.$assisterCtrler.checkHitOwner("main"))
         {
            this.$assisterCtrler.getOwner().addHp(5);
         }
      }
      
      internal function frame10() : *
      {
         if(this.$assisterCtrler.checkHitOwner("main"))
         {
            this.$assisterCtrler.getOwner().addHp(5);
         }
      }
      
      internal function frame13() : *
      {
         if(this.$assisterCtrler.checkHitOwner("main"))
         {
            this.$assisterCtrler.getOwner().addHp(5);
         }
      }
      
      internal function frame16() : *
      {
         if(this.$assisterCtrler.checkHitOwner("main"))
         {
            this.$assisterCtrler.getOwner().addHp(5);
         }
      }
      
      internal function frame19() : *
      {
         if(this.$assisterCtrler.checkHitOwner("main"))
         {
            this.$assisterCtrler.getOwner().addHp(5);
         }
      }
      
      internal function frame22() : *
      {
         if(this.$assisterCtrler.checkHitOwner("main"))
         {
            this.$assisterCtrler.getOwner().addHp(5);
         }
      }
      
      internal function frame25() : *
      {
         if(this.$assisterCtrler.checkHitOwner("main"))
         {
            this.$assisterCtrler.getOwner().addHp(5);
         }
      }
      
      internal function frame28() : *
      {
         if(this.$assisterCtrler.checkHitOwner("main"))
         {
            this.$assisterCtrler.getOwner().addHp(5);
         }
      }
      
      internal function frame39() : *
      {
         this.$assisterCtrler.moveToTarget(-50,null,false);
      }
      
      internal function frame45() : *
      {
         this.$assisterCtrler.move(10,0);
         this.$assisterCtrler.damping(1,0);
      }
      
      internal function frame60() : *
      {
         this.$assisterCtrler.endAct();
      }
   }
}

