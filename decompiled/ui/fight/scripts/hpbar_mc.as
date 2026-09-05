package
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol136")]
   public dynamic class hpbar_mc extends MovieClip
   {
      
      public var bar1:hpbar_barmc;
      
      public var bar2:hpbar_barmc;
      
      public var energy1:energy_bar;
      
      public var energy2:energy_bar;
      
      public var face1:hpbar_facegroup;
      
      public var face2:hpbar_facegroup;
      
      public var scoremc:score_mc;
      
      public var timemc:time_mc;
      
      public var win_p1:winmc;
      
      public var win_p2:winmc;
      
      public function hpbar_mc()
      {
         super();
         addFrameScript(0,this.frame1,24,this.frame25,45,this.frame46);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame25() : *
      {
         stop();
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      internal function frame46() : *
      {
         stop();
         dispatchEvent(new Event(Event.COMPLETE));
      }
   }
}

