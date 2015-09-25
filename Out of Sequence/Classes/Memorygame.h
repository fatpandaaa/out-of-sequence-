//
//  MyCocos2DClass.h
//  Out of Sequence
//
//  Created by Nur Farazi on 7/15/14.
//  Copyright 2014 nur. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "cocos2d.h"
#import "cocos2d-ui.h"
#import "GameMechanics.h"
#import "PositionFixed.h"

@interface Memorygame : CCScene {
    NSMutableArray *PositionArray;
    
    int NumArray2[20];
    
    
    NSString *CurrentLevelNameForScore;
    NSString *CurrentLeveNameFoHighScore;
    
    GameMechanics *gamemechanic;
    
    NSMutableArray *StoreNumberArray;
    int CurrentNumber ;
    int ComboChecker;
    int CheckNumber;

    CCLabelTTF *Timer;
    CCLabelTTF *PointText;
    CCSprite * PointBar;



    int CheckerNumber;

}
+ (Memorygame *)scene;
- (id)init;

@end
