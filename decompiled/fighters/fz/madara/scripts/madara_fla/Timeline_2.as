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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol45")]
   public dynamic class Timeline_2 extends MovieClip
   {
      
      public var atm1:MovieClip;
      
      public var atm2:MovieClip;
      
      public var atm3:MovieClip;
      
      public var $attacker_ctrler:*;
      
      public function Timeline_2()
      {
         super();
         addFrameScript(0,this.frame1,11,this.frame12,34,this.frame35);
      }
      
      public function setAttackerCtrler(param1:*) : void
      {
         this.$attacker_ctrler = param1;
      }
      
      internal function frame1() : *
      {
      }
      
      internal function frame12() : *
      {
         if(!this.$attacker_ctrler.justHit("atm1"))
         {
            this.$attacker_ctrler.gotoAndPlay("miss");
         }
      }
      
      internal function frame35() : *
      {
         this.$attacker_ctrler.removeSelf();
      }
   }
}

