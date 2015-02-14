package;

import flixel.FlxSprite;
import flixel.FlxG;

class Player extends FlxSprite {

    public function new() {

        super();

        makeGraphic(69, 114, 0xff000000);

        this.drag.x = 2000;
        this.acceleration.y = 3000;
        this.maxVelocity.x = 300;
        this.maxVelocity.y = 5000;

    }

    override public function update():Void {
        if(FlxG.keys.pressed.LEFT) 
            acceleration.x = -2000;
        else if(FlxG.keys.pressed.RIGHT) 
            acceleration.x = 2000;
        else 
            acceleration.x = 0;

        var state = cast(FlxG.state, PlayState);

        if(this.overlapsAt(x, y+1, state.platforms)) {
            makeGraphic(cast width, cast height, 0xff00ff00);
            //Jump
            if(FlxG.keys.justPressed.UP) 
                velocity.y = -1000;
        }
        else {
            makeGraphic(cast width, cast height, 0xffff0000);
        }

        super.update();

    }

}