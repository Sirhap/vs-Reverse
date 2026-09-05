package fight_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol90")]
   public dynamic class energybar_txt_mc_3 extends MovieClip
   {
      
      public var mc:MovieClip;
      
      public function energybar_txt_mc_3()
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

