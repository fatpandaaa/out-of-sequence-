//
//  GameMechanics.m
//  Bubble tap
//
//  Created by nur farazi on 1/24/14.
//  Copyright (c) 2013 nur farazi. All rights reserved.
//

#import "GameMechanics.h"

@implementation GameMechanics

@synthesize mainViewDelegate;


- (int) GetScore :(NSString *)LevelNameScore
{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:LevelNameScore] intValue];
}

-(void) setScore:(int)Score :(NSString *)LevelNameScore :(NSString *)LevelNameHighScore
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:Score] forKey:LevelNameScore];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


- (void) MinusScore:(int)Score :(NSString *)LevelNameScore
{
    int currentCredits = [self GetScore :LevelNameScore];
    
    currentCredits -= Score;
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:currentCredits] forKey:LevelNameScore];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


- (void) AddScore:(int)Score :(NSString *)LevelNameScore :(NSString *)LevelNameHighScore
{
    int currentCredits = [self GetScore :LevelNameScore];
    
    currentCredits += Score;
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:currentCredits] forKey:LevelNameScore];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if (Score >[self GetHighScore:LevelNameHighScore]) {
        
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:Score] forKey:LevelNameHighScore];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }

}

-(int)chartboostbecomeactive{
    
   return [[[NSUserDefaults standardUserDefaults] objectForKey:@"Chartboost"] intValue];
    
}

- (void)setchartboostCounting:(int)number
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:number] forKey:@"Chartboost"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void) AddchartboostCounting:(int)number{
    
    int currentnumber = [self chartboostbecomeactive];
    
    currentnumber += number;
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:currentnumber] forKey:@"Chartboost"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}



- (int) GetHighScore :(NSString *)LevelName
{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:LevelName] intValue];
}


-(void)SetHighScore:(int)Score :(NSString *)LevelName
{
    
    if (Score >[self GetHighScore:LevelName]) {

        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:Score] forKey:LevelName];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}

//----------------------------time--------------

- (float) GetTime :(NSString *)LevelName
{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:LevelName] floatValue];
}


-(void) AddTime:(float)Time :(NSString *)LevelNameTime :(NSString *)LevelNameBestTime
{
    
    float currentTime = [self GetTime:LevelNameTime];
    
    currentTime += Time;
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithFloat:currentTime] forKey:LevelNameTime];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if (Time >[self GetBestTime:LevelNameBestTime]) {
        
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithFloat:Time] forKey:LevelNameBestTime];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}


-(float)GetBestTime :(NSString *)LevelNameBestTime{
 
    return [[[NSUserDefaults standardUserDefaults] objectForKey:LevelNameBestTime] floatValue];

}




@end
