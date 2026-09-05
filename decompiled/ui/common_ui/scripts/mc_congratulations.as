package
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol25")]
   public dynamic class mc_congratulations extends MovieClip
   {
      
      public function mc_congratulations()
      {
         super();
         addFrameScript(49,this.frame50);
      }
      
      internal function frame50() : *
      {
         stop();
         dispatchEvent(new Event(Event.COMPLETE));
      }
   }
}

