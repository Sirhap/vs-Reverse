package kakashi_fla
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol518")]
   public dynamic class Timeline_11 extends MovieClip
   {
      
      public var cbsatm:MovieClip;
      
      public var cbs1atm:MovieClip;
      
      public var $attacker_ctrler:*;
      
      public var isHit:Boolean;
      
      public var hitTarget:*;
      
      public var target:*;
      
      public function Timeline_11()
      {
         super();
         addFrameScript(0,this.frame1,36,this.frame37,40,this.frame41,54,this.frame55);
      }
      
      public function setAttackerCtrler(param1:*) : void
      {
         this.$attacker_ctrler = param1;
      }
      
      internal function frame1() : *
      {
         this.isHit = false;
      }
      
      internal function frame37() : *
      {
         if(this.$attacker_ctrler.justHit("cbs1"))
         {
            this.target = this.$attacker_ctrler.owner_fighter_ctrler.getTargetSP();
            if(this.target)
            {
               this.hitTarget = this.target;
               this.target.isApplyG = false;
               this.target.getDisplay().visible = false;
               this.isHit = true;
            }
         }
      }
      
      internal function frame41() : *
      {
         if(!this.isHit)
         {
            this.$attacker_ctrler.removeSelf();
         }
      }
      
      internal function frame55() : *
      {
         if(this.hitTarget)
         {
            this.target.getDisplay().visible = true;
            this.target.isApplyG = true;
         }
      }
   }
}

