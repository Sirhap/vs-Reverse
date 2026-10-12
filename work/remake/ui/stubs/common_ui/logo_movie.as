package
{
   import flash.display.MovieClip;

   /**
    * Empty remake stub for UI SymbolClass export.
    * UI=common_ui DefineBinaryData id=225 charId=26 export=logo_movie
    * Purpose: give JPEXS/ASC a named MovieClip subclass so engine scripts can type
    * `:logo_movie` (or keep `:*`). Does NOT embed artwork — nest SWF SymbolClass still owns pixels.
    * Cross-pool: if engine pool != home SWF, resolve via loading (see CROSS-POOL.md).
    */
   public class logo_movie extends MovieClip
   {
      public function logo_movie()
      {
         super();
      }
   }
}
