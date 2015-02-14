package;

import flixel.FlxSprite;
import flixel.FlxG;

class Player extends FlxSprite {

    var boxAttach:Bool = false;
    var attachedBox:Box;
    var maxVelX = 300;
    var boxSpeedFactor = 0.5;

    public function new() {

        super();

        loadGraphic("assets/images/player_idle.png");

        drag.x = 2000;
        acceleration.y = 3000;
        maxVelocity.y  = 5000;

    }

    override public function update():Void {

        maxVelocity.x = maxVelX * (boxAttach ? boxSpeedFactor : 1);

        //Move left, right
        if(FlxG.keys.pressed.LEFT) 
            acceleration.x = -2000;
        else if(FlxG.keys.pressed.RIGHT) 
            acceleration.x = 2000;
        else 
            acceleration.x = 0;

        var state = cast(FlxG.state, PlayState);

        //Jump
        if(this.overlapsAt(x, y+1, state.platforms)) {
            if(FlxG.keys.justPressed.UP && !boxAttach) 
                velocity.y = -1000;
        }

        //Move box
        if(boxAttach)
            attachedBox.velocity.x = velocity.x;

        //Attach Box
        if(FlxG.keys.justPressed.SPACE) {
            for(b in state.boxes) {
                //Box to the left
                if(this.overlapsAt(x-20,y,b)) {
                    boxAttach = true;
                    attachedBox = b;
                }
                //Box to the right
                else if(this.overlapsAt(x+20, y, b)) {
                    boxAttach = true;
                    attachedBox = b;
                }

            }
        }

        //Detach Box
        if(FlxG.keys.justReleased.SPACE && boxAttach) {
            boxAttach = false;
            attachedBox.velocity.x = 0;
            attachedBox = null;

        }
        super.update();

    }

}