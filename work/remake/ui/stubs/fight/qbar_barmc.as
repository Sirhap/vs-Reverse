package
{
   import flash.display.MovieClip;

   /**
    * Empty remake stub for UI SymbolClass export.
    * UI=fight DefineBinaryData id=226 charId=57 export=qbar_barmc
    * Purpose: give JPEXS/ASC a named MovieClip subclass so engine scripts can type
    * `:qbar_barmc` (or keep `:*`). Does NOT embed artwork — nest SWF SymbolClass still owns pixels.
    * Cross-pool: if engine pool != home SWF, resolve via loading (see CROSS-POOL.md).
    */
   public class qbar_barmc extends MovieClip
   {
      public function qbar_barmc()
      {
         super();
      }
   }
}
