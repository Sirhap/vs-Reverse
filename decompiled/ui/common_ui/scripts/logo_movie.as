package
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol26")]
   public dynamic class logo_movie extends MovieClip
   {
      
      public function logo_movie()
      {
         super();
         addFrameScript(0,this.frame1,65,this.frame66);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame66() : *
      {
         stop();
         dispatchEvent(new Event(Event.COMPLETE));
      }
   }
}

