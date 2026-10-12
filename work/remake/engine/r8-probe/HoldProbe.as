package {
  import flash.display.Sprite;
  import flash.display.StageAlign;
  import flash.display.StageScaleMode;
  import flash.events.Event;
  import flash.external.ExternalInterface;
  import flash.text.TextField;
  import flash.text.TextFormat;

  /**
   * R8 EI probe — NOT sample/main.swf.
   * Registers ExternalInterface.addCallback("setHold", ...) so Ruffle/JS can call it.
   * Mirrors ServiceHold: isReady + passthrough names; stores mock as Object.
   */
  public class HoldProbe extends Sprite {
    private var _hold:Object = null;
    private var _status:TextField;
    private var _callLog:Array = [];

    public function HoldProbe() {
      if (stage) init();
      else addEventListener(Event.ADDED_TO_STAGE, onAdded);
    }

    private function onAdded(e:Event):void {
      removeEventListener(Event.ADDED_TO_STAGE, onAdded);
      init();
    }

    private function init():void {
      stage.align = StageAlign.TOP_LEFT;
      stage.scaleMode = StageScaleMode.NO_SCALE;
      _status = new TextField();
      _status.width = 780;
      _status.height = 580;
      _status.multiline = true;
      _status.wordWrap = true;
      _status.defaultTextFormat = new TextFormat("_sans", 14, 0x00FF88);
      addChild(_status);
      paint("HoldProbe boot; EI.available=" + ExternalInterface.available);

      if (ExternalInterface.available) {
        try {
          ExternalInterface.addCallback("setHold", setHold);
          ExternalInterface.addCallback("isReady", isReady);
          ExternalInterface.addCallback("getHoldType", getHoldType);
          ExternalInterface.addCallback("getHoldMethods", getHoldMethods);
          ExternalInterface.addCallback("getCallLog", getCallLog);
          ExternalInterface.addCallback("showGameList", showGameList);
          ExternalInterface.addCallback("showSort", showSort);
          ExternalInterface.addCallback("showRefer", showRefer);
          ExternalInterface.addCallback("changeScore", changeScore);
          ExternalInterface.addCallback("showLogPanel", showLogPanel);
          ExternalInterface.addCallback("userLogOut", userLogOut);
          ExternalInterface.addCallback("renderTime", renderTime);
          ExternalInterface.addCallback("probePing", probePing);
          paint("EI callbacks registered: setHold,isReady,passthru…");
          try {
            ExternalInterface.call("window.__R8_EI_PROBE_READY__", true);
          } catch (e1:Error) {
            // page may not have handler yet
          }
        } catch (e:Error) {
          paint("EI register FAIL: " + e.message);
        }
      } else {
        paint("ExternalInterface NOT available");
      }
    }

    private function paint(msg:String):void {
      if (_status) {
        _status.appendText(msg + "\n");
      }
      trace(msg);
    }

    /** Page injects mock via player.setHold(mock) — same name as timeline.setHold. */
    public function setHold(h:Object):Boolean {
      _hold = h;
      _callLog.push({ method: "setHold", t: new Date().time, holdNull: h == null });
      paint("setHold called; isReady=" + (h != null) + " type=" + typeof h);
      try {
        ExternalInterface.call("window.__R8_EI_ON_SETHOLD__", h != null);
      } catch (e:Error) {}
      return h != null;
    }

    public function isReady():Boolean {
      return _hold != null;
    }

    public function getHoldType():String {
      if (_hold == null) return "null";
      return typeof _hold;
    }

    public function getHoldMethods():Array {
      var out:Array = [];
      if (_hold == null) return out;
      // EI marshals JS object → AS Object; enumerable keys only (functions usually dropped)
      for (var k:String in _hold) {
        out.push(k + ":" + typeof _hold[k]);
      }
      return out;
    }

    public function getCallLog():Array {
      return _callLog.slice();
    }

    public function probePing():String {
      return "R8-EI-PROBE-OK";
    }

    private function passthru(name:String, args:Array = null):void {
      _callLog.push({ method: name, t: new Date().time, args: args || [] });
      paint("passthru " + name);
      // Notify page so JS-side mock can log if EI dropped functions
      try {
        ExternalInterface.call("window.__R8_EI_PASSTHRU__", name, args);
      } catch (e:Error) {}
      // Best-effort: if mock still has callable (unlikely via EI), invoke
      if (_hold != null && _hold[name] is Function) {
        var f:Function = _hold[name] as Function;
        if (args && args.length) f.apply(_hold, args);
        else f.apply(_hold);
      }
    }

    public function showGameList():void { passthru("showGameList"); }
    public function showSort():void { passthru("showSort"); }
    public function showRefer(score:Number = 0):void { passthru("showRefer", [score]); }
    public function changeScore(n:Number = 0):void { passthru("changeScore", [n]); }
    public function showLogPanel():void { passthru("showLogPanel"); }
    public function userLogOut():void { passthru("userLogOut"); }
    public function renderTime():void { passthru("renderTime"); }
  }
}
