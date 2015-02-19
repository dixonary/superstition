package puzzles;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.tweens.FlxTween;

class InsideHut extends PuzzleState {

    var pentagram:FlxSprite;

    override function create():Void {

        super.create();

        bgLayer.add(bg = new Background("assets/images/insidehut.png", 2.5));
        add(new Background("assets/images/hutpot.png", 2.5));

        //Shelves
        platforms.add(new Platform(595,195,340,13));
        platforms.add(new Platform(900,314,220,13));

        boxes.add(new Box(600, 140));

        //Floor
        platforms.add(new Platform(bg.x, bg.y+bg.height-10, cast bg.width, 10));

        //Walls
        platforms.add(new Platform(bg.x-100, bg.y-90, cast bg.width+100, 10));
        platforms.add(new Platform(bg.x-10, bg.y, 10, cast bg.height));
        platforms.add(new Platform(bg.x+bg.width, bg.y, 10, cast bg.height));

        var witch = new Witch(150, 0, 5, 1);
        witch.y = bg.y + bg.height - witch.height - 10;
        add(witch);


        add(new Hotspot(700, 0, 10, 100, function() {
            //Pentagram
            pentagram = new FlxSprite(0,0, "assets/images/spell.png");
            pentagram.scale.set(2,2);
            pentagram.alpha = 0.9;
            pentagram.centerOrigin();
            pentagram.updateHitbox();
            pentagram.x = witch.x+(witch.width-pentagram.width)/2;
            pentagram.y = witch.y-80;

            FlxTween.tween(pentagram.scale,{x:1.75, y:1.75}, 0.6, {type:FlxTween.PINGPONG, ease:flixel.tweens.FlxEase.sineInOut});

            add(pentagram);
        }));

        //Exit scene
        add(new Hotspot(bg.x+bg.width-10, bg.y+bg.height-10, 10, 10, function() {
            Reg.playerSpawnX = 150;
            Reg.playerSpawnY = 300;
            FlxG.switchState(new Swamp());
        }));

    }

}