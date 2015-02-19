package;

import flixel.FlxSprite;
import flixel.FlxG;

class Witch extends FlxSprite {

    public function new(X,Y,Scale, Frame):Void {
        super();

        loadGraphic("assets/images/witch.png", true, 34, 53);

        frame = framesData.frames[Frame];

        scale.set(Scale,Scale);
        centerOffsets();
        updateHitbox();
        x = X;
        y = Y;

        acceleration.y = 1000;
    }

    override public function update():Void {
        super.update();

        FlxG.collide(this, (cast(FlxG.state, PuzzleState)).platforms);

    }

    public function setFrame(Frame) {
        frame = framesData.frames[Frame];
    }

}