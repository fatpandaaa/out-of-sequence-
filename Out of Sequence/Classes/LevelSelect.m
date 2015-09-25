//
//  MyCocos2DClass.m
//  Out of Sequence
//
//  Created by Nur Farazi on 5/12/14.
//  Copyright 2014 nur. All rights reserved.
//

#import "LevelSelect.h"
#import "Help.h"


@implementation LevelSelect
{
    CCSprite *_background;
}
+ (LevelSelect *)scene
{
	return [[self alloc] init];
}

- (id)init
{
    self = [super init];
    if (!self) return(nil);
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"MenuUI.plist"];
    [self setBoolValuse];
    [self Background];
    [self buttons];
    [self Logo];
    
    return self;
}

-(void)buttons{
    
    float SPeed1 = 0.8;
    float SPeed2 = 1.2;
    float SPeed3 = 1.7;

    
    CCButton *classic = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame
                                                                   frameWithImageNamed:@"Classic.png"]];
    classic.positionType = CCPositionTypeNormalized;
    classic.position = ccp(0.2f, .7f);
    classic.scale=0.1;
    [classic setTarget:self selector:@selector(ClassicbtnClick)];
    [self addChild:classic];
    
    
    
    CCButton *arcade = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame
                                                                  frameWithImageNamed:@"arcade.png"]];
    arcade.positionType = CCPositionTypeNormalized;
    arcade.position = ccp(0.5f, .7f);
    arcade.scale=0.1;
    [arcade setTarget:self selector:@selector(arcadebtnClick)];
    [self addChild:arcade];
    
    
    
    CCButton *zen = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame
                                                               frameWithImageNamed:@"zen.png"]];
    zen.positionType = CCPositionTypeNormalized;
    zen.position = ccp(0.8f, 0.7f);
    zen.scale=0.1;
    [zen setTarget:self selector:@selector(zenBtnClick)];
    [self addChild:zen];
    
    
    
    CCButton *compare = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame
                                                                   frameWithImageNamed:@"infinity.png"]];
    compare.positionType = CCPositionTypeNormalized;
    compare.position = ccp(0.35f, .5f);
    compare.scale=0.1;
    [compare setTarget:self selector:@selector(compareBtnClick)];
    [self addChild:compare];
    
    
    
    CCButton *memory = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame
                                                                  frameWithImageNamed:@"memory.png"]];
    memory.positionType = CCPositionTypeNormalized;
    memory.position = ccp(0.65f,.5f);
    memory.scale=0.1;
    [memory setTarget:self selector:@selector(memoryBtnClick)];
    [self addChild:memory];
    
    
    
    CCButton *BackBtn = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"backbtnlevel.png"]];
    BackBtn.positionType = CCPositionTypeNormalized;
    BackBtn.position = ccp(0.5f, 0.3f);
    BackBtn.scale=0.8;
    [BackBtn setTarget:self selector:@selector(BackBtnClick)];
    [self addChild:BackBtn];
    
    
    [classic runAction:[CCActionEaseElasticInOut actionWithAction:[CCActionScaleTo actionWithDuration:SPeed1 scale:1]]];
    [arcade runAction:[CCActionEaseElasticInOut actionWithAction:[CCActionScaleTo actionWithDuration:SPeed1 scale:1]]];
    [zen runAction:[CCActionEaseElasticInOut actionWithAction:[CCActionScaleTo actionWithDuration:SPeed1 scale:1]]];
    [compare runAction:[CCActionEaseElasticInOut actionWithAction:[CCActionScaleTo actionWithDuration:SPeed2 scale:1]]];
    [memory runAction:[CCActionEaseElasticInOut actionWithAction:[CCActionScaleTo actionWithDuration:SPeed2 scale:1]]];
    [BackBtn runAction:[CCActionEaseElasticInOut actionWithAction:[CCActionScaleTo actionWithDuration:SPeed3 scale:1]]];

}
-(void)setBoolValuse{
    
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:ClassicModeBool];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:ArcademodeBool];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:ZenModeBool];
    
}


-(void)ClassicbtnClick{
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:ClassicModeBool];

    [[CCDirector sharedDirector] replaceScene:[GamePlay scene:0] withTransition:[CCTransition transitionMoveInWithDirection:CCTransitionDirectionDown duration:0.2]];
    
    
}
-(void)arcadebtnClick{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:ArcademodeBool];

    [[CCDirector sharedDirector] replaceScene:[GamePlay scene:1] withTransition:[CCTransition transitionMoveInWithDirection:CCTransitionDirectionDown duration:0.2]];
    
    
}
-(void)zenBtnClick{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:ZenModeBool];

    [[CCDirector sharedDirector] replaceScene:[GamePlay scene:2] withTransition:[CCTransition transitionMoveInWithDirection:CCTransitionDirectionDown duration:0.2]];
    
}
-(void)compareBtnClick{
    //[[NSUserDefaults standardUserDefaults] setBool:YES forKey:ZenModeBool];
    
    [[CCDirector sharedDirector] replaceScene:[Infinity scene] withTransition:[CCTransition transitionMoveInWithDirection:CCTransitionDirectionDown duration:0.2]];
    
}
-(void)memoryBtnClick{
    
    [[CCDirector sharedDirector] replaceScene:[Memorygame scene] withTransition:[CCTransition transitionMoveInWithDirection:CCTransitionDirectionDown duration:0.2]];
    
}

-(void)BackBtnClick{
    [[CCDirector sharedDirector] replaceScene:[MainMenu scene] withTransition:[CCTransition transitionMoveInWithDirection:CCTransitionDirectionRight duration:0.2]];

    
}
-(void)Background{
    
    _background = [CCSprite spriteWithImageNamed:@"menubg.jpg"];
    _background.positionType = CCPositionTypeNormalized;
    _background.position = ccp(0.5f, 0.5f);
    [self addChild:_background z:-1];
}

-(void)Logo{
    
    CCSprite *Logo =[CCSprite spriteWithSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"logo.png"]];
    Logo.positionType = CCPositionTypeNormalized;
    Logo.position = ccp(0.5f, 0.88f);
    [self addChild:Logo];
    
}


-(void)dealloc
{
    
}

- (void)onEnter
{
    [super onEnter];
    
}

- (void)onExit
{
    CCLOG(@"Exit");
    
    [super onExit];
}


@end
