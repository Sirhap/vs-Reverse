package
{
   import flash.display.MovieClip;

   /**
    * Empty remake stub for UI SymbolClass export.
    * UI=fight DefineBinaryData id=226 charId=244 export=bsface_mc
    * Purpose: give JPEXS/ASC a named MovieClip subclass so engine scripts can type
    * `:bsface_mc` (or keep `:*`). Does NOT embed artwork — nest SWF SymbolClass still owns pixels.
    * Cross-pool: if engine pool != home SWF, resolve via loading (see CROSS-POOL.md).
    */
   public class bsface_mc extends MovieClip
   {
      public function bsface_mc()
      {
         super();
      }
   }
}
