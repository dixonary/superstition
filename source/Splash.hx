package;

import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxParticle;

class Splash extends FlxEmitter {
    
    private static inline var MAX_PARTICLES:Int = 50;

    public function new(X,Y,W=50,H=0) {

        super();
        x=X;y=Y;

        makeParticles("assets/images/waterParticle.png", MAX_PARTICLES, 0, false, 0);
        this.setAlpha(1,1,0,0);
        this.setYSpeed(-80,80);
        this.setXSpeed(-80,80);
        width=W;
        height=H;
        start(true,0.6);

    }
}