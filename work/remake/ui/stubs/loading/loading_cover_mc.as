package
{
   import flash.display.MovieClip;

   /**
    * Empty remake stub for UI SymbolClass export.
    * UI=loading DefineBinaryData id=229 charId=106 export=loading_cover_mc
    * Purpose: give JPEXS/ASC a named MovieClip subclass so engine scripts can type
    * `:loading_cover_mc` (or keep `:*`). Does NOT embed artwork — nest SWF SymbolClass still owns pixels.
    * Cross-pool: if engine pool != home SWF, resolve via loading (see CROSS-POOL.md).
    */
   public class loading_cover_mc extends MovieClip
   {
      public function loading_cover_mc()
      {
         super();
      }
   }
}
