package
{
   import flash.display.MovieClip;

   /**
    * Empty remake stub for UI SymbolClass export.
    * UI=fight DefineBinaryData id=226 charId=101 export=energy_bar
    * Purpose: give JPEXS/ASC a named MovieClip subclass so engine scripts can type
    * `:energy_bar` (or keep `:*`). Does NOT embed artwork — nest SWF SymbolClass still owns pixels.
    * Cross-pool: if engine pool != home SWF, resolve via loading (see CROSS-POOL.md).
    */
   public class energy_bar extends MovieClip
   {
      public function energy_bar()
      {
         super();
      }
   }
}
