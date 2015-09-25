//
//  MyCocos2DClass.h
//  Out of Sequence
//
//  Created by Nur Farazi on 5/8/14.
//  Copyright 2014 nur. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameMechanics.h"
#import "MainMenu.h"

#import "cocos2d.h"
#import "cocos2d-ui.h"
#import "PositionFixed.h"
#import "GoldCoin.h"
#import "CCParticleSystem.h"

@interface GamePlay : CCScene <GameMechanicsDelegate> {
    
   
    
        
    GameMechanics *gamemechanic;
    
    NSString *CurrentLevelNameForScore;
    NSString *CurrentLeveNameFoHighScore;
    
    int classicmodereset;
    CCSprite * TimeBar;
    CCLabelTTF *PointText;
    CCSprite * PointBar;
    CCSprite *TaregetBar;
    
    NSTimer *mintimer;
    NSTimer *secondTimer;
    NSTimer *MomentTimer;
    BOOL isPaused;
    int StarNumber;
    
    NSMutableArray *MainArray;
    NSMutableArray *PositionArray;
    NSMutableArray *ButtonArray;
    
    int Score;
    
    BOOL arcade ;
    BOOL classic;
    BOOL zen;
    
    int ComboChecker;
    
    int Point;
    CGPoint touchLocation;
    
    int LevelNumberr;
    
    
    GoldCoin *goldicoin;

}

//@property (nonatomic,readwrite )  NSMutableArray *MainArray;

+ (GamePlay *)scene :(int)LevelNumber;
- (id)initWithLevel :(int)LevelNumber;
-(void)UIBars;

-(void)GoldCoinAction;

@end
