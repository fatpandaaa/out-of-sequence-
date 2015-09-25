//
//  MyCocos2DClass.m
//  Out of Sequence
//
//  Created by Nur Farazi on 5/12/14.
//  Copyright 2014 nur. All rights reserved.
//

#import "Help.h"


@implementation Help
{
    CCSprite *_background;
}
+ (Help *)scene
{
	return [[self alloc] init];
}

- (id)init
{
    self = [super init];
    if (!self) return(nil);
    
    CCButton *Backbtn = [CCButton buttonWithTitle:@"Click here to Skip The Tutorial" fontName:@"Helvetica" fontSize:(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)? 80 : 40];
    Backbtn.positionType = CCPositionTypeNormalized;
    Backbtn.position = ccp(0.5f, 0.08f);
    Backbtn.hitAreaExpansion=100.0;
    [Backbtn setTarget:self selector:@selector(PlayBtnClick)];
    [self addChild:Backbtn];
    Backbtn.scale=0.5;

    

    [self Background];
    [self credittext];
    
    return self;
}

-(void)PlayBtnClick{
    //[[CCDirector sharedDirector] replaceScene:[GamePlay scene]];
}
-(void)Background{
    
    _background = [CCSprite spriteWithImageNamed:@"bg.png"];
    _background.positionType = CCPositionTypeNormalized;
    _background.position = ccp(0.5f, 0.5f);
    [self addChild:_background z:-1];
}
-(void)credittext{
    
    CCSprite *SpText = [CCSprite spriteWithImageNamed:@"helpp.png"];
    SpText.positionType = CCPositionTypeNormalized;
    SpText.position = ccp(0.5f, 0.5f);
    [self addChild:SpText];
    SpText.scale=0.4;
    
    [SpText runAction:[CCActionEaseSineIn actionWithAction:[CCActionScaleTo actionWithDuration:0.8 scale:0.8]]];
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
