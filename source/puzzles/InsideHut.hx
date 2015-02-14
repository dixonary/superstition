package puzzles;

import flixel.FlxG;

class InsideHut extends PuzzleState {

    override function create():Void {

        super.create();

        bgLayer.add(bg = new Background("assets/images/insidehut.png", 2.5));
        add(new Background("assets/images/hutpot.png", 2.5));

        //Shelves
        platforms.add(new Platform(595,195,340,13));
        platforms.add(new Platform(900,314,220,13));

        //Floor
        platforms.add(new Platform(bg.x, bg.y+bg.height-10, cast bg.width, 10));

        //Walls
        platforms.add(new Platform(bg.x-100, bg.y-100, cast bg.width+100, 10));
        platforms.add(new Platform(bg.x-10, bg.y, 10, cast bg.height));
        platforms.add(new Platform(bg.x+bg.width, bg.y, 10, cast bg.height));

        player.setPos(1050,200);

    }

}