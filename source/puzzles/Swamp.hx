package puzzles;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxTimer;
import flixel.tweens.FlxTween;

class Swamp extends PuzzleState {

    var cat:FlxSprite;
    var cat2:FlxSprite;
    var catPlatform:Platform;
    var witch:Witch;
    var catspot:Hotspot;

    override function create():Void {

        super.create();

        bgLayer.add(bg = new Background("assets/images/swamp.png"));

        //Floor
        platforms.add(new Platform(bg.x, bg.y+bg.height-10, cast bg.width, 10));

        //Path
        platforms.add(new Platform(-10,0,10,FlxG.height));
        platforms.add(new Platform(140, 0, 10, FlxG.height));
        platforms.add(new Platform(140, 440, 30, 10));
        platforms.add(new Platform(160, 460, 30, 10));
        platforms.add(new Platform(180, 480, 30, 10));
        platforms.add(new Platform(200, 500, 30, 10));
        platforms.add(new Platform(220, 520, 30, 10));
        platforms.add(new Platform(240, 540, 30, 10));
        platforms.add(new Platform(260, 560, 400, 10));
        platforms.add(new Platform(700, 520, 40, 10));
        platforms.add(new Platform(740, 480, 520, 10));

        //Tree
        platforms.add(new Platform(850, 320,60,10));
        platforms.add(new Platform(700, 180,60,10));

        add(new Hotspot(bg.x+bg.width-10, bg.y+bg.height-10, 10, 10, function() {
            FlxG.resetGame();
        }));

        cat = new FlxSprite(0,0,"assets/images/cat.png");
        add(cat);
        cat.scale.x = cat.scale.y = 3;
        cat.centerOffsets();
        cat.updateHitbox();
        cat.x = FlxG.width-cat.width-10;
        cat.y = 480-cat.height;
        cat.flipX = true;

        cat2 = new FlxSprite(0,0,"assets/images/cat_wet.png");
        add(cat2);
        cat2.scale.x = cat2.scale.y = 3;
        cat2.centerOffsets();
        cat2.updateHitbox();
        cat2.x = FlxG.width-cat.width-10;
        cat2.y = 480-cat.height;
        cat2.flipX = true;
        cat2.alpha=0;

        //Cat platform
        platforms.add(catPlatform = new Platform(cat.x - 10, 0, 10, FlxG.height));

        player.scale.x = player.scale.y = 0.8;
        player.body.centerOffsets();
        player.body.updateHitbox();
        player.body.x = Reg.playerSpawnX;
        player.body.y = Reg.playerSpawnY;

        //Swamp wet
        add(new Hotspot(580,0,10,300,function(){
            trace("Hi");
            player.inControl = false;
            var p = new Platform(570,510,100,10);
            var h = new Hotspot(570, 500,100,10,function(){
                //Voodoo splash
                add(new Splash(560,490));
                //Cat splash
                add(new Splash(cat.x, cat.y, cast cat.width, cast cat.height));
                FlxTween.tween(cat2, {alpha:1}, 0.75);

                player.body.animation.play("half");
            });

            platforms.add(new Platform(300,0,10,FlxG.height));

            //Get out of the water
            new FlxTimer(3,function(_){
                add(new Splash(560,490));
                player.velocity.y = -1000;
                player.body.animation.play("idle");
                FlxTween.tween(
                    player.body, {x:450}, 0.6, {complete:function(_){
                        player.inControl = true;
                        player.velocity.y = 0;
                    }});
                h.kill();
                p.kill();
            }, 1);

            //Witch appears
            new FlxTimer(5, function(_){
                
                witch=new Witch(150, 300, 2, 0);
                add(witch);
                add(new Smoke(witch.x, witch.y, witch.width, witch.height));

                //One second delay
                new FlxTimer(1, function(_) {
                    var s;
                    // Cat sign
                    add(s = new Sign(witch.x+witch.width, witch.y-50, "catface", false));
                    new FlxTimer(1, function(_){s.kill();});

                    // ! sign
                    new FlxTimer(1.5, function(_){
                        add(s = new Sign(witch.x+witch.width, witch.y-50, "questionmark", false));
                        new FlxTimer(1, function(_){s.kill();});
                    });
                });
                //Witch disappears the cat
                new FlxTimer(4.5, function(_) {
                    witch.setFrame(2);
                    add(new Sparkle(witch.x+50, witch.y+20));

                    new FlxTimer(1, function(_) {
                        cat.visible = false;
                        cat2.visible = false;
                        add(new Smoke(cat.x, cat.y, cat.width, cat.height));
                        catspot.kill();
                        catPlatform.kill();
                    });

                    new FlxTimer(2, function(_) {
                        witch.setFrame(0);
                    });
                });

            });
            
            platforms.add(p);
            add(h);

        }));

        //Next scene
        add(new Hotspot(FlxG.width-10, 0, 10, FlxG.height, function() {
            Reg.playerSpawnX = 0;
            Reg.playerSpawnY = 300;
            FlxG.switchState(new SwampTwo());
        }));

        //No entry cat!
        add(catspot = new Hotspot(cat.x-100, cat.y, 10,cast cat.height, function() {
            var s;
            add(s=new Sign(cat.x-70, cat.y-40, "stop",true));
            new FlxTimer(3, function(_){s.kill();});
        }));

    }

}