package
{
   import flash.display.MovieClip;

   /**
    * Empty remake stub for UI SymbolClass export.
    * UI=fight DefineBinaryData id=226 charId=100 export=energybar_barmc
    * Purpose: give JPEXS/ASC a named MovieClip subclass so engine scripts can type
    * `:energybar_barmc` (or keep `:*`). Does NOT embed artwork — nest SWF SymbolClass still owns pixels.
    * Cross-pool: if engine pool != home SWF, resolve via loading (see CROSS-POOL.md).
    */
   public class energybar_barmc extends MovieClip
   {
      public function energybar_barmc()
      {
         super();
      }
   }
}
