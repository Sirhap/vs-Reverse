package loading_fla
{
   import flash.display.MovieClip;

   /**
    * Empty remake stub for UI SymbolClass export.
    * UI=loading DefineBinaryData id=229 charId=0 export=loading_fla.MainTimeline
    * Purpose: give JPEXS/ASC a named MovieClip subclass so engine scripts can type
    * `:MainTimeline` (or keep `:*`). Does NOT embed artwork — nest SWF SymbolClass still owns pixels.
    * Cross-pool: if engine pool != home SWF, resolve via loading (see CROSS-POOL.md).
    */
   public class MainTimeline extends MovieClip
   {
      public function MainTimeline()
      {
         super();
      }
   }
}
