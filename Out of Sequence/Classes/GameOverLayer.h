//
//  MyCocos2DClass.h
//  Out of Sequence
//
//  Created by Nur Farazi on 5/9/14.
//  Copyright 2014 nur. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "appID.h"
#import "cocos2d.h"
#import "cocos2d-ui.h"
#import "GameMechanics.h"
#import "CCParticleSystem.h"


@interface GameOverLayer : CCScene <GameMechanicsDelegate>{
    CCButton *twitterbtn;
    CCButton *fbbtn;
    CCButton *Sharebtn;
    GameMechanics *gameMechanics;
    
    int levelNumber;
    int currentsec;
    int currentMoment;
    NSString *CurrentLevelNameForScore;
    NSString *CurrentLeveNameFoHighScore;
    
}
+ (GameOverLayer *)scene:(int)Sec :(int)Moment :(int)RewardStar :(int)LevelNum :(int)Score ;
- (id)initWithScore:(int)Sec :(int)Moment :(int)RewardStar :(int)LevelNum :(int)Score  ;
@end
