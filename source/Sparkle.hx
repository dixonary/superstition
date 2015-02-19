package;

import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxParticle;

class Sparkle extends FlxEmitter {
    
    private var MAX_PARTICLES:Int = 50;

    public function new(X:Float,Y:Float,W:Float=50,H:Float=0, continuous:Bool = false) {

        super();
        x=X;y=Y;

        if(continuous) MAX_PARTICLES = 100;

        makeParticles("assets/images/spark.png", MAX_PARTICLES, 0, false, 0);
        this.setAlpha(1,1,0,0);
        this.setYSpeed(-80,80);
        this.setXSpeed(-80,80);
        width=0;
        height=0;
        start(!continuous,0.6,0.01);

    }
}