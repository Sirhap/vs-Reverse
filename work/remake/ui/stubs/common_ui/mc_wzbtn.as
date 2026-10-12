package
{
   import flash.display.MovieClip;

   /**
    * Empty remake stub for UI SymbolClass export.
    * UI=common_ui DefineBinaryData id=225 charId=14 export=mc_wzbtn
    * Purpose: give JPEXS/ASC a named MovieClip subclass so engine scripts can type
    * `:mc_wzbtn` (or keep `:*`). Does NOT embed artwork — nest SWF SymbolClass still owns pixels.
    * Cross-pool: if engine pool != home SWF, resolve via loading (see CROSS-POOL.md).
    */
   public class mc_wzbtn extends MovieClip
   {
      public function mc_wzbtn()
      {
         super();
      }
   }
}
