package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.group.FlxSpriteGroup;

class Player extends FlxSpriteGroup {

    var boxAttach:Bool = false;
    var attachedBox:Box;
    var maxVelX = 300;
    var boxSpeedFactor = 0.5;

    public var body:FlxSprite;
    var arm:FlxSprite;
    var arm_offset:Float = 0;
    var arm_swing_count:Int = 0;
    public var inControl:Bool = true;

    public function new() {

        super();

        body = new FlxSprite();
        body.loadGraphic("assets/images/player_walk.png", true, 69, 114, true);
        body.animation.add("rightwalk", [for (i in 0 ... 8) i], 18, true);
        body.animation.add("rightstay", [0], 1, true);
        body.animation.add("idle", [8], 1, true);
        body.animation.add("half", [9], 1, true);
        body.animation.add("ded", [10], 1, true);
        body.animation.play("idle");

        body.pixelPerfectRender = false;
        body.antialiasing = true;

        body.width -= 14;
        body.offset.x += 7;


        body.drag.x = 2000;
        add(body);

        arm = new FlxSprite();
        arm.loadGraphic("assets/images/player_arm.png", false);
        arm.origin.set(5,5);
        add(arm);

    }

    override public function update():Void {
        super.update();

        if(body.velocity.x > 0) {
            body.flipX = false;
            arm.visible = true;
            body.animation.play("rightwalk");
        }
        else if(body.velocity.x < 0) {
            body.flipX = true;
            arm.visible = true;
            body.animation.play("rightwalk");
        }
        else {
            if(inControl)
            body.animation.play("idle", true);
            arm_swing_count = 0;
            arm.visible = boxAttach;
        }

        //Gravity
        body.acceleration.y = 3000;

        body.maxVelocity.x = maxVelX * (boxAttach ? boxSpeedFactor : 1);

        if(inControl) {
            //Move left, right
            if(FlxG.keys.pressed.LEFT) 
                body.acceleration.x = -2000;
            else if(FlxG.keys.pressed.RIGHT) 
                body.acceleration.x = 2000;
            else 
                body.acceleration.x = 0;
        }
        else 
            body.acceleration.x = 0;

        var state = cast(FlxG.state, PuzzleState);

        //Jump
        if(body.overlapsAt(body.x, body.y+2, state.platforms)
            || body.overlapsAt(body.x, body.y+2, state.boxes)) {
            if(FlxG.keys.justPressed.UP && !boxAttach && inControl) {
                body.velocity.y = -1000;
                body.y -= 1;
                trace("BOING");
            } 
        }

        //Detach Box
        if(boxAttach && (FlxG.keys.justReleased.SPACE
            || Math.abs(attachedBox.y-body.y) > 70)) {
            boxAttach = false;
            attachedBox.velocity.x = 0;
            attachedBox = null;
        }

        //Move box
        if(boxAttach) {
            attachedBox.velocity.x = body.velocity.x;
            body.flipX = (attachedBox.x < body.x);
            if(body.velocity.x == 0)
                body.animation.play("rightstay", true);
        }

        var touchingGround = body.overlapsAt(body.x,body.y+2,state.platforms)
                          || body.overlapsAt(body.x, body.y+2, state.boxes);
        //Attach Box
        for(b in state.boxes) {
            //Box to the side
            if(body.overlapsAt(body.x,body.y+4,b)) {
                body.y -= 0.01;
                body.velocity.y = Math.min(0,body.velocity.y);
                body.acceleration.y = Math.min(0,body.acceleration.y);
            }
            if(body.overlapsAt(body.x-4,body.y-4,b)) {
                body.x = b.x + b.width;
                if(!boxAttach) {
                    body.velocity.x = Math.max(0,body.velocity.x);
                    body.acceleration.x = Math.max(0,body.acceleration.x);
                }
                if(FlxG.keys.justPressed.SPACE && touchingGround) {
                    boxAttach = true;
                    attachedBox = b;
                }
            }
            if(body.overlapsAt(body.x+4,body.y-4,b)) {
                body.x = b.x - body.width;
                if(!boxAttach) {
                    body.velocity.x = Math.min(0,body.velocity.x);
                    body.acceleration.x = Math.min(0,body.acceleration.x);
                }
                if(FlxG.keys.justPressed.SPACE && touchingGround) {
                    boxAttach = true;
                    attachedBox = b;
                }
            }
        }

        // ARM STUFF

        if(boxAttach)
            sort(flixel.util.FlxSort.byY, flixel.util.FlxSort.DESCENDING);
        else
            sort(flixel.util.FlxSort.byY, flixel.util.FlxSort.ASCENDING); 
        

        arm.angle = boxAttach ? -90 : 0;
        if(body.velocity.x != 0 && !boxAttach) {
            arm_swing_count++;
            arm.angle += Math.sin(Math.round(arm_swing_count/8)*1.2) * 20; 
        }
        arm_offset = !boxAttach ? (body.flipX ? 2 : -2) : (body.flipX ? -25*body.scale.x : 15*body.scale.x);
        arm.flipX = body.flipX;
        arm.x = body.x + 22*body.scale.x + arm_offset;
        arm.y = body.y + 65*body.scale.x;

    }

    public function setPos(X,Y) {
        body.x = X;
        body.y = Y;
    }
}