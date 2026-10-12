package
{
   import flash.display.MovieClip;

   /**
    * Empty remake stub for UI SymbolClass export.
    * UI=title DefineBinaryData id=2215 charId=66 export=stg_test
    * Purpose: give JPEXS/ASC a named MovieClip subclass so engine scripts can type
    * `:stg_test` (or keep `:*`). Does NOT embed artwork — nest SWF SymbolClass still owns pixels.
    * Cross-pool: if engine pool != home SWF, resolve via loading (see CROSS-POOL.md).
    */
   public class stg_test extends MovieClip
   {
      public function stg_test()
      {
         super();
      }
   }
}
