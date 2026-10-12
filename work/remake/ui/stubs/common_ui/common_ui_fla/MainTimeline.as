package common_ui_fla
{
   import flash.display.MovieClip;

   /**
    * Empty remake stub for UI SymbolClass export.
    * UI=common_ui DefineBinaryData id=225 charId=0 export=common_ui_fla.MainTimeline
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
