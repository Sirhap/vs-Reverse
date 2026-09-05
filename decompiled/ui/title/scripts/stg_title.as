package
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol64")]
   public dynamic class stg_title extends MovieClip
   {
      
      public var btnct:MovieClip;
      
      public var logo_mc:MovieClip;
      
      public function stg_title()
      {
         super();
         addFrameScript(49,this.frame50,74,this.frame75);
      }
      
      internal function frame50() : *
      {
         stop();
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      internal function frame75() : *
      {
         stop();
         dispatchEvent(new Event(Event.COMPLETE));
      }
   }
}

