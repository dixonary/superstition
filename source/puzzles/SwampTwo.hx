package puzzles;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxTimer;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

class SwampTwo extends PuzzleState {
    
    var witch:Witch;
    var twig:flixel.FlxSprite;

    override public function create() {

        super.create();

        bgLayer.add(bg = new Background("assets/images/Boxswamp.png")); 

        platforms.add(new Platform(0, 550, 800, 10));
        platforms.add(new Platform(-10, 0, 10, FlxG.height));

        add(new Hotspot(500, 0, 10, FlxG.width, function() {
            witch = new Witch(0, 330, 4, 0);
            add(witch);
            add(new Smoke(witch.x, witch.y, witch.width, witch.height));

            //Stop player moving
            new FlxTimer(0.2, function(_) {
                //player.velocity.x = 0;
                player.body.animation.play("idle", true);
            });
            player.inControl = false;

            platforms.add(new Platform(300, 0, 10, FlxG.height));

            new FlxTimer(1, function(_) {
                var s;
                // Stop sign
                add(s = new Sign(witch.x+witch.width-10, witch.y-20, "stop", false));
                new FlxTimer(1, function(_){s.kill();});

                // ! sign
                new FlxTimer(1.5, function(_){
                    add(s = new Sign(witch.x+witch.width-10, witch.y-20, "questionmark", false));
                    new FlxTimer(1, function(_){s.kill();player.inControl=true;});
                });
            });
        }));

        //Spikes
        add(new Hotspot(850, 550,200,10,function(){
            player.inControl = false;
            witch.setFrame(2);
            new FlxTimer(0.2, function(_) {
                //Voodoo splash
                add(new Fluff(850, 580, 200, 10));

                player.body.animation.play("ded", true);
                new FlxTimer(0.1, function(_) {
                    player.body.animation.play("ded", true);
                });
                
                new FlxTimer(0.5, function(_){
                    add(new BloodSplash(witch.x, witch.y, witch.width, cast witch.height));
                    new FlxTimer(0.5, function(_) {
                        add(new BloodSplash(witch.x, witch.y, witch.width, cast witch.height));
                    });
                    new FlxTimer(1, function(_) {
                        add(new BloodSplash(witch.x, witch.y, witch.width, cast witch.height));
                    });
                    var witch2 = new Witch(witch.x, witch.y, witch.scale.x, 3);
                    witch2.alpha = 0.1;
                    add(witch2);
                    FlxTween.tween(witch2, {alpha:1}, 2);

                    new FlxTimer(3, function(_) {
                        add(new Smoke(witch.x, witch.y, witch.width, witch.height));
                        add(new Smoke(witch.x, witch.y, witch.width, witch.height));
                        witch.visible = false;
                        witch2.visible = false;
                    });

                    new FlxTimer(5, function(_) {
                        var top = new FlxSprite();
                        top.makeGraphic(FlxG.width, FlxG.height, 0xff000000);
                        top.y = -FlxG.height;
                        add(top);
                        var bottom = new FlxSprite();
                        add(bottom);
                        bottom.makeGraphic(FlxG.width, FlxG.height, 0xff000000);
                        bottom.y = FlxG.height;
                        FlxTween.tween(top, {y:600-FlxG.height}, 3, {ease:FlxEase.quadOut});
                        FlxTween.tween(bottom, {y:600}, 3, {ease:FlxEase.quadOut, complete:function(_){
                            Reg.toFin= true;
                            FlxG.resetGame();
                        }});
                    });

                });
            });
        }));

        //Spikes platform
        platforms.add(new Platform(800, 650, 300, 10));  

        //branch
        add(twig = new Background("assets/images/branch.png"));

        //Branch hotspot
        add(new Hotspot(700,0,10, FlxG.height, function(){
            witch.setFrame(2);
            player.inControl = false;
            //Stop player moving
            new FlxTimer(0.2, function(_) {
                //player.velocity.x = 0;
                player.body.animation.play("idle", true);
            });

            new FlxTimer(0.5, function(_) {
                var s;
                add(s=new Sparkle(witch.x+witch.width+10, witch.y+30, true));
                FlxTween.tween(s, {x:850}, 1.0, {complete:function(_){s.kill();}});
            });
            new FlxTimer(1.5, function(_) {
                FlxTween.tween(twig, {angle:100, y:twig.y+1000, x:twig.x+100}, 3, {ease:FlxEase.quadIn});
                witch.setFrame(0);
            });
            new FlxTimer(3.0, function(_) {
                var s;
                add(s=new Sign(witch.x+witch.width-10, witch.y-20, "pain", false));
                new FlxTimer(1.5, function(_) {s.kill();player.inControl=true;});
            });
        }));

        var k;
        add(k=new FlxSprite());
        k.y = bg.height+bg.y;
        k.makeGraphic(FlxG.width, 1000, 0xff000000, true);

    }

}