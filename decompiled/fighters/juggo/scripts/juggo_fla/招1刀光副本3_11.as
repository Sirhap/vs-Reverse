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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol220")]
   public dynamic class 招1刀光副本3_11 extends MovieClip
   {
      
      public var hitmc:MovieClip;
      
      public var zh22atm:MovieClip;
      
      public var $attacker_ctrler:*;
      
      public var tu:*;
      
      public function 招1刀光副本3_11()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2,4,this.frame5,5,this.frame6);
      }
      
      public function setAttackerCtrler(param1:*) : void
      {
         this.$attacker_ctrler = param1;
      }
      
      internal function frame1() : *
      {
      }
      
      internal function frame2() : *
      {
         this.$attacker_ctrler.move(30,0);
         this.$attacker_ctrler.setHitTarget("hitmc","hit");
         this.$attacker_ctrler.setCrossMap(true);
      }
      
      internal function frame5() : *
      {
         this.$attacker_ctrler.stop();
      }
      
      internal function frame6() : *
      {
         if(this.$attacker_ctrler.owner_mc_ctrler)
         {
            this.tu = this.$attacker_ctrler.owner_mc_ctrler.getAttacker("tu");
            if(this.tu)
            {
               this.tu.gotoAndPlay("bow");
            }
         }
         this.$attacker_ctrler.move(0,0);
      }
   }
}

