package obito_fla
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol142")]
   public dynamic class 元件37_6 extends MovieClip
   {
      
      public var zh31atm:MovieClip;
      
      public var zh32atm:MovieClip;
      
      public var $attacker_ctrler:*;
      
      public function 元件37_6()
      {
         super();
         addFrameScript(0,this.frame1,58,this.frame59);
      }
      
      public function setAttackerCtrler(param1:*) : void
      {
         this.$attacker_ctrler = param1;
      }
      
      internal function frame1() : *
      {
      }
      
      internal function frame59() : *
      {
         if(this.$attacker_ctrler.owner_fighter_ctrler.target)
         {
            this.$attacker_ctrler.owner_fighter_ctrler.target.visible = true;
         }
      }
   }
}

