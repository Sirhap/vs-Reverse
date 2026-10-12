package
{
   import flash.display.MovieClip;

   /**
    * Empty remake stub for UI SymbolClass export.
    * UI=fight DefineBinaryData id=226 charId=124 export=winmc
    * Purpose: give JPEXS/ASC a named MovieClip subclass so engine scripts can type
    * `:winmc` (or keep `:*`). Does NOT embed artwork — nest SWF SymbolClass still owns pixels.
    * Cross-pool: if engine pool != home SWF, resolve via loading (see CROSS-POOL.md).
    */
   public class winmc extends MovieClip
   {
      public function winmc()
      {
         super();
      }
   }
}
