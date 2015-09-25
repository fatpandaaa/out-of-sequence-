//
//  GameMechanics.m
//  Bubble tap
//
//  Created by nur farazi on 1/24/14.
//  Copyright (c) 2013 nur farazi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "appID.h"

@protocol GameMechanicsDelegate <NSObject>

//@property (nonatomic, retain) NSDictionary *config;

@end

@interface GameMechanics : NSObject{
    
    id <GameMechanicsDelegate> mainViewDelegate;
 
    
}

-(int)chartboostbecomeactive;
- (void) setchartboostCounting:(int)number;
- (void) AddchartboostCounting:(int)number;






-(void) setScore :(int)Score :(NSString *)LevelNameScore :(NSString *)LevelNameHighScore;
- (int) GetScore :(NSString *)LevelNameScore;


- (void) MinusScore:(int)Score :(NSString *)LevelNameScore;
- (void) AddScore:(int)Score :(NSString *)LevelNameScore :(NSString *)LevelNameHighScore;



-(void) SetHighScore:(int)Score :(NSString *)LevelNameHighScoreScore;
-(int) GetHighScore :(NSString *)LevelNameHighScore;



- (float) GetTime :(NSString *)LevelName;
-(void) AddTime:(float)Time :(NSString *)LevelNameTime :(NSString *)LevelNameBestTime;
-(float)GetBestTime :(NSString *)LevelNameBestTime;


@property (nonatomic, retain) id <GameMechanicsDelegate> mainViewDelegate;

@end
