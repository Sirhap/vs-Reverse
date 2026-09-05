package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol106")]
   public dynamic class select_item_mc extends MovieClip
   {
      
      public var mc:MovieClip;
      
      public function select_item_mc()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      internal function frame1() : *
      {
         stop();
      }
   }
}

