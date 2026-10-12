package
{
   import flash.display.MovieClip;

   /**
    * Empty remake stub for UI SymbolClass export.
    * UI=fight DefineBinaryData id=226 charId=72 export=qbar_facemc
    * Purpose: give JPEXS/ASC a named MovieClip subclass so engine scripts can type
    * `:qbar_facemc` (or keep `:*`). Does NOT embed artwork — nest SWF SymbolClass still owns pixels.
    * Cross-pool: if engine pool != home SWF, resolve via loading (see CROSS-POOL.md).
    */
   public class qbar_facemc extends MovieClip
   {
      public function qbar_facemc()
      {
         super();
      }
   }
}
