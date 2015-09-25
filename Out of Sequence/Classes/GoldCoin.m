//
//  GoldCoin.m
//  Out of Sequence
//
//  Created by Nur Farazi on 7/18/14.
//  Copyright 2014 nur. All rights reserved.
//

#import "GoldCoin.h"
#import "GamePlay.h"


@implementation GoldCoin{
    CCParticleSystem *_fire;
}

+ (instancetype)newtonSphereWithLetter;
{
    return([[GoldCoin alloc] init]);
}


- (instancetype)init
{
    
    self = [super init];
    if (!self) return(nil);
    
    
    
    _GCOin = [CCSprite spriteWithSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"GoldCoin.png"]];
    _GCOin.scale=0.1;
    [self addChild:_GCOin z:1];
    
    
    
    self.userInteractionEnabled = YES;
    
    
    
    _fire = [CCParticleSystem particleWithFile:@"goldcoilsparticle.plist"];
    _fire.particlePositionType = CCParticleSystemPositionTypeFree;
    
    _fire.position = ccp(0, 0);
    
    
    
    float particleScale = ParticleScale * [CCDirector sharedDirector].viewSize.width / 1000;
    _fire.startSize *= particleScale;
    _fire.startSizeVar *= particleScale;
    _fire.endSize *= particleScale;
    _fire.endSizeVar *= particleScale;
    _fire.gravity = ccpMult(_fire.gravity, particleScale);
    _fire.posVar = ccpMult(_fire.posVar, particleScale);
    
    
    [self addChild:_fire];
    
    
    [self BouncyEffect:_GCOin :_fire];
    
    
    return(self);
}

-(void)BouncyEffect :(CCSprite *)Imagename :(CCParticleSystem *)Particlesystem{
    
    CCActionScaleTo *ScaleUp = [CCActionEaseBounceOut actionWithAction:[CCActionScaleTo actionWithDuration:0.5 scale:1.0]];
    
    CCActionDelay *delay = [CCActionDelay actionWithDuration:2.0];
    CCActionScaleTo *scaledown=[CCActionScaleTo actionWithDuration:0.2 scale:0.1];
    CCActionRemove *removeThe = [CCActionRemove action];
    CCActionCallBlock *StopParticle = [CCActionCallBlock actionWithBlock:^{
        [Particlesystem stopSystem];
    }];
    
    
    [Imagename runAction:[CCActionSequence actionWithArray:@[ScaleUp,delay,scaledown,removeThe,StopParticle]]];
    
}

- (BOOL)hitTestWithWorldPos:(CGPoint)pos
{
    CGPoint nodePos = [self convertToNodeSpace:pos];
    
    float distance = ccpLength(nodePos);
    return(distance < _GCOin.contentSize.width * 0.5);
}

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    //CGPoint parentPos = [_parent convertToNodeSpace:touch.locationInWorld];
    
    GamePlay *gameplay = [[GamePlay alloc]init];
    
    [gameplay GoldCoinAction];
    
}

- (void)update:(CCTime)delta
{
    _fire.rotation = -self.rotation;
}

@end
