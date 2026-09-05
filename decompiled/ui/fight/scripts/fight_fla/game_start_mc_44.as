package fight_fla
{
   import adobe.utils.*;
   import flash.accessibility.*;
   import flash.desktop.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.globalization.*;
   import flash.media.*;
   import flash.net.*;
   import flash.net.drm.*;
   import flash.printing.*;
   import flash.profiler.*;
   import flash.sampler.*;
   import flash.sensors.*;
   import flash.system.*;
   import flash.text.*;
   import flash.text.engine.*;
   import flash.text.ime.*;
   import flash.ui.*;
   import flash.utils.*;
   import flash.xml.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol194")]
   public dynamic class game_start_mc_44 extends MovieClip
   {
      
      public var nummc:MovieClip;
      
      public var winnermc:MovieClip;
      
      public var $round:int;
      
      public var $perfect:Boolean;
      
      public var $winnerX:Number;
      
      public var $winnerY:Number;
      
      public function game_start_mc_44()
      {
         super();
         addFrameScript(0,this.frame1,26,this.frame27,27,this.frame28,54,this.frame55,57,this.frame58,87,this.frame88,189,this.frame190,199,this.frame200,200,this.frame201,209,this.frame210,262,this.frame263,308,this.frame309);
      }
      
      internal function frame1() : *
      {
         this.$round = 1;
         this.$perfect = false;
         this.$winnerX = 30;
         this.$winnerY = 90;
         stop();
      }
      
      internal function frame27() : *
      {
         if(this.$round < 1)
         {
            this.$round = 1;
         }
         if(this.$round > 5)
         {
            this.$round = 5;
         }
         if(Boolean(this.nummc))
         {
            this.nummc.gotoAndPlay("r" + this.$round);
         }
      }
      
      internal function frame28() : *
      {
         if(Boolean(this.nummc))
         {
            this.nummc.gotoAndPlay("r" + this.$round);
         }
      }
      
      internal function frame55() : *
      {
         dispatchEvent(new Event("fight_in"));
      }
      
      internal function frame58() : *
      {
         dispatchEvent(new Event("fight"));
      }
      
      internal function frame88() : *
      {
         stop();
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      internal function frame190() : *
      {
         stop();
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      internal function frame200() : *
      {
         if(Boolean(this.winnermc))
         {
            this.winnermc.x = this.$winnerX;
            this.winnermc.y = this.$winnerY;
            this.winnermc.isPerfect = this.$perfect;
         }
      }
      
      internal function frame201() : *
      {
         if(Boolean(this.winnermc))
         {
            this.winnermc.x = this.$winnerX;
            this.winnermc.y = this.$winnerY;
            this.winnermc.isPerfect = this.$perfect;
         }
      }
      
      internal function frame210() : *
      {
         stop();
         this.winnermc.addEventListener(Event.COMPLETE,function(param1:Event):void
         {
            dispatchEvent(new Event(Event.COMPLETE));
         },false,0,true);
      }
      
      internal function frame263() : *
      {
         stop();
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      internal function frame309() : *
      {
         stop();
         dispatchEvent(new Event(Event.COMPLETE));
      }
   }
}

