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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol352")]
   public dynamic class Timeline_9 extends MovieClip
   {
      
      public var bsatm:MovieClip;
      
      public var bs1atm:MovieClip;
      
      public var $attacker_ctrler:*;
      
      public var fighterCtrler:*;
      
      public function Timeline_9()
      {
         super();
         addFrameScript(0,this.frame1,16,this.frame17,61,this.frame62,80,this.frame81,85,this.frame86);
      }
      
      public function setAttackerCtrler(param1:*) : void
      {
         this.$attacker_ctrler = param1;
      }
      
      internal function frame1() : *
      {
      }
      
      internal function frame17() : *
      {
      }
      
      internal function frame62() : *
      {
         this.$attacker_ctrler.removeSelf();
      }
      
      internal function frame81() : *
      {
         this.$attacker_ctrler.stop();
      }
      
      internal function frame86() : *
      {
         this.fighterCtrler = this.$attacker_ctrler.owner_fighter_ctrler;
         if(this.fighterCtrler)
         {
            if(this.fighterCtrler.target)
            {
               this.fighterCtrler.target.visible = true;
            }
         }
      }
   }
}

