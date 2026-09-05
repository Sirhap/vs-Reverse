package juggo_fla
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol213")]
   public dynamic class Symbol1_10 extends MovieClip
   {
      
      public var zh21atm:MovieClip;
      
      public var zh2atm:MovieClip;
      
      public var $attacker_ctrler:*;
      
      public function Symbol1_10()
      {
         super();
         addFrameScript(0,this.frame1,15,this.frame16,55,this.frame56);
      }
      
      public function setAttackerCtrler(param1:*) : void
      {
         this.$attacker_ctrler = param1;
      }
      
      internal function frame1() : *
      {
      }
      
      internal function frame16() : *
      {
         if(Boolean(this.$attacker_ctrler.justHit("zh2")) && Boolean(this.$attacker_ctrler.owner_mc_ctrler))
         {
            this.$attacker_ctrler.owner_mc_ctrler.gotoAndPlay("招22");
         }
         else
         {
            this.$attacker_ctrler.gotoAndPlay("miss");
         }
      }
      
      internal function frame56() : *
      {
         this.$attacker_ctrler.removeSelf();
      }
   }
}

