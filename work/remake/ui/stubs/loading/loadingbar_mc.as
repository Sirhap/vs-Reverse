package
{
   import flash.display.MovieClip;

   /**
    * Empty remake stub for UI SymbolClass export.
    * UI=loading DefineBinaryData id=229 charId=98 export=loadingbar_mc
    * Purpose: give JPEXS/ASC a named MovieClip subclass so engine scripts can type
    * `:loadingbar_mc` (or keep `:*`). Does NOT embed artwork — nest SWF SymbolClass still owns pixels.
    * Cross-pool: if engine pool != home SWF, resolve via loading (see CROSS-POOL.md).
    */
   public class loadingbar_mc extends MovieClip
   {
      public function loadingbar_mc()
      {
         super();
      }
   }
}
