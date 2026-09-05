package
{
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class LOADING_Icon extends Sprite
   {
      
      private var bar_container:Sprite;
      
      public var bar:DisplayObject;
      
      public var label_txt:TextField;
      
      public var m_progress:Number;
      
      private var image_class:Class;
      
      private var image:Bitmap;
      
      private var default_bar_shape:Shape;
      
      public var BAR_HEIGHT:Number = 7;
      
      public var DISTANCE_BAR_TEXT:Number = 3;
      
      public var BAR_COLOR:uint = 14540253;
      
      public var BAR_ALPHA:Number = 0.7;
      
      public var BAR_COLOR_BG:uint = 11184810;
      
      public var BAR_ALPHA_BG:Number = 0.3;
      
      public function LOADING_Icon(param1:Class = null)
      {
         super();
         image_class = param1;
         m_progress = 0;
         image = new image_class();
         image.smoothing = true;
         addChild(image);
         label_txt = new TextField();
         var _loc2_:TextFormat = label_txt.defaultTextFormat;
         _loc2_.font = "Microsoft YaHei,Microsoft YaHei UI";
         _loc2_.size = 20;
         _loc2_.color = 14540253;
         _loc2_.align = "center";
         label_txt.defaultTextFormat = _loc2_;
         label_txt.autoSize = "center";
         label_txt.selectable = false;
         addChild(label_txt);
         bar_container = new Sprite();
         addChild(bar_container);
         default_bar_shape = new Shape();
         bar = default_bar_shape;
         bar_container.addChild(bar);
         bar.scaleX = 0;
         bar.visible = false;
         label_txt.visible = false;
         addEventListener("addedToStage",onAdded);
      }
      
      private function onAdded(param1:Event) : void
      {
         stage.addEventListener("resize",onResize);
         addEventListener("removedFromStage",onRemove);
         update();
      }
      
      public function get align() : String
      {
         return "auto";
      }
      
      private function onRemove(param1:Event) : void
      {
         stage.removeEventListener("resize",onResize);
      }
      
      private function onResize(param1:Event) : void
      {
         update();
      }
      
      private function update() : void
      {
         var _loc5_:Number = stage.stageWidth;
         var _loc4_:Number = stage.stageHeight;
         image.x = (_loc5_ - image.width) / 2;
         image.y = (_loc4_ - image.height) / 2;
         bar_container.graphics.clear();
         default_bar_shape.graphics.clear();
         var _loc3_:Number = Math.min(image.width,_loc5_ - 10 * 2);
         bar_container.graphics.beginFill(BAR_COLOR_BG,BAR_ALPHA_BG);
         bar_container.graphics.drawRect(0,0,_loc3_,BAR_HEIGHT);
         bar_container.graphics.endFill();
         default_bar_shape.graphics.beginFill(BAR_COLOR,BAR_ALPHA);
         default_bar_shape.graphics.drawRect(0,0,_loc3_,BAR_HEIGHT);
         default_bar_shape.graphics.endFill();
         label_txt.scaleX = label_txt.scaleY = 1;
         if(image.width > 20 && image.width < label_txt.width)
         {
            label_txt.scaleX = label_txt.scaleY = image.width / label_txt.width;
         }
         bar_container.x = (_loc5_ - _loc3_) / 2;
         label_txt.x = (_loc5_ - label_txt.width) / 2;
         var _loc1_:Number = image.height + image.y + 6;
         if(_loc1_ + 10 + BAR_HEIGHT > _loc4_)
         {
            bar_container.y = _loc4_ - (10 + BAR_HEIGHT);
         }
         else
         {
            bar_container.y = _loc1_;
         }
         label_txt.y = bar_container.y + BAR_HEIGHT + DISTANCE_BAR_TEXT;
         if(label_txt.y + label_txt.height > _loc4_)
         {
            label_txt.y = bar_container.y - label_txt.height - DISTANCE_BAR_TEXT;
         }
      }
      
      public function get progress() : Number
      {
         return m_progress;
      }
      
      public function set progress(param1:Number) : void
      {
         m_progress = param1;
         bar.scaleX = m_progress;
         bar.visible = true;
      }
      
      public function get label() : String
      {
         return label_txt.text;
      }
      
      public function set label(param1:String) : void
      {
         label_txt.text = param1;
         label_txt.visible = true;
         update();
      }
   }
}

