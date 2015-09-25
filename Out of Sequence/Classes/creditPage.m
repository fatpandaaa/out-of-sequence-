//
//  MyCocos2DClass.m
//  Out of Sequence
//
//  Created by Nur Farazi on 5/12/14.
//  Copyright 2014 nur. All rights reserved.
//

#import "creditPage.h"
#import "MainMenu.h"


@implementation creditPage
{
    CCSprite *_background;
}
+ (creditPage *)scene
{
	return [[self alloc] init];
}

- (id)init
{
    self = [super init];
    if (!self) return(nil);
    
    CCButton *Backbtn = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"P_Home.png"]];
    Backbtn.positionType = CCPositionTypeNormalized;
    Backbtn.position = ccp(0.9f, 0.1f);
    [Backbtn setTarget:self selector:@selector(BackBtnClick)];
    [self addChild:Backbtn];
    Backbtn.scale=0.5;
    
    
    
    [self Backgrounds];
    [self credittext];
    
    return self;
}
-(void)Backgrounds{
    
    _background = [CCSprite spriteWithImageNamed:@"bg.png"];
    _background.positionType = CCPositionTypeNormalized;
    _background.position = ccp(0.5f, 0.5f);
    [self addChild:_background z:-1];
}
-(void)credittext{
    
    CCSprite *SpText = [CCSprite spriteWithImageNamed:@"creditPage.png"];
    SpText.positionType = CCPositionTypeNormalized;
    SpText.position = ccp(0.5f, 0.5f);
    [self addChild:SpText];
    
    [SpText runAction:[CCActionEaseSineIn actionWithAction:[CCActionFadeIn actionWithDuration:1.0]]];
}
-(void)BackBtnClick{
    
    [[CCDirector sharedDirector] replaceScene:[MainMenu scene]];
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
