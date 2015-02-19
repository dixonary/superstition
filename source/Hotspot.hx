package;

import flixel.FlxSprite;
import flixel.FlxG;

class Hotspot extends FlxSprite {
    
    var callback:Void->Void;
    var complete:Bool = false;
    
    public function new(X:Float,Y:Float, Width:Int, Height:Int, Callback:Void->Void) {
        super(X,Y);

        callback = Callback;

        makeGraphic(Width, Height, 0xaa000000);
    }

    override public function update():Void {
        super.update();
        if(complete) return;

        var state = cast(FlxG.state, PuzzleState);

        if(FlxG.overlap(this, state.player)) {
            callback();
            complete = true;
        }
    }

}