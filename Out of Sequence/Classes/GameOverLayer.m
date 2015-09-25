//
//  MyCocos2DClass.m
//  Out of Sequence
//
//  Created by Nur Farazi on 5/9/14.
//  Copyright 2014 nur. All rights reserved.
//

#import "GameOverLayer.h"
#import "GamePlay.h"




@implementation GameOverLayer
CCLabelTTF * BestTime;
CCLabelTTF * BestTimeText;
CCLabelTTF * BestPoint;
CCLabelTTF * BestPointText;
CCLabelTTF * yourScore;
CCLabelTTF * yourTime;

CCNodeColor *Timebglayer;
CCNodeColor *Pointbglayer;
CCSprite * IconTimer;
CCSprite *IconPoint;



+ (GameOverLayer *)scene:(int)Sec :(int)Moment :(int)RewardStar :(int)LevelNum :(int)Score
{
	return [[self alloc] initWithScore:Sec :Moment :RewardStar :LevelNum :Score];
}

- (id)initWithScore:(int)Sec :(int)Moment :(int)RewardStar :(int)LevelNum :(int)Score 
{
    self = [super init];
    if (!self) return(nil);
    
    gameMechanics = [[GameMechanics alloc]init];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"GameOverUI.plist"];
    
    
    switch (LevelNum) {
        case 0:
            CurrentLevelNameForScore = ClassicModeScore;
            CurrentLeveNameFoHighScore=ClassicModeHighScore;
            break;

        case 1:
            CurrentLevelNameForScore = ArcadeModeScore;
            CurrentLeveNameFoHighScore=ArcadeModeHighScore;
            break;
        case 2:
            CurrentLevelNameForScore = ZenModeScore;
            CurrentLeveNameFoHighScore=ZenModeHighScore;
            break;
            
        default:
            break;
    }
    
    currentsec = Sec;
    currentMoment=Moment;
    
    levelNumber = LevelNum;
    
    [self Background];
    [self Buttons];
    
  
    [self reward:RewardStar];
    [self StarShadow];
    [self UI];
    [self ShowScoreAndTime];
    [self LoadScoresAndTime:Score];
    
    
   
    
    
    
    
   	return self;
}

-(void)UI{
    CCNodeColor *LeftTopLayer = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.4f] width:self.contentSize.width/4 height:self.contentSize.height/7];
    LeftTopLayer.position=ccp(0, self.contentSize.height-LeftTopLayer.contentSize.height/2);
    
    [self addChild:LeftTopLayer];
    
    
    CCNodeColor *RightTopLayer = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.4f] width:self.contentSize.width/4 height:self.contentSize.height/7];
    RightTopLayer.position=ccp(self.contentSize.width-RightTopLayer.contentSize.width, self.contentSize.height-LeftTopLayer.contentSize.height/2);
    [self addChild:RightTopLayer];
    
    
    
    Pointbglayer = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.4f] width:self.contentSize.width * 0.8 height:self.contentSize.height * 0.2];
    
    Pointbglayer.positionType=CCPositionTypeNormalized;
    Pointbglayer.position=ccp( 0.1,0.45);
    [self addChild:Pointbglayer];
    
    
    Timebglayer = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.4f] width:self.contentSize.width * 0.8 height:self.contentSize.height * 0.1];
    
    Timebglayer.positionType=CCPositionTypeNormalized;
    Timebglayer.position=ccp( 0.1,0.31);
    [self addChild:Timebglayer];
    
    
    
    IconPoint =[CCSprite spriteWithSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"diomond.png"]];
    IconPoint.positionType=CCPositionTypeNormalized;
    IconPoint.position=ccp(0.1, 0.55);
    [self addChild:IconPoint];
    
    
    
    IconTimer =[CCSprite spriteWithSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"clock.png"]];
    IconTimer.positionType=CCPositionTypeNormalized;
    IconTimer.position=ccp(0.1, 0.36);
    [self addChild:IconTimer];
    
    
    BestPointText = [CCLabelTTF labelWithString:@"BestPoint" fontName:Fonthelvetica fontSize:
                 (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)? 22 : 10];
    BestPointText.positionType=CCPositionTypeNormalized;
    BestPointText.color=[CCColor colorWithRed:0.35 green:0.85 blue:0.85 alpha:1.0];
    BestPointText.position=ccp(0.1,0.98);
    BestPointText.zOrder=1;
    [self addChild:BestPointText];
    
    
    
    BestTimeText = [CCLabelTTF labelWithString:@"BestTime" fontName:Fonthelvetica fontSize:
                (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)? 22 : 10];
    BestTimeText.positionType=CCPositionTypeNormalized;
    BestTimeText.position=ccp(0.9,0.98);
    BestTimeText.zOrder=1;
    [self addChild:BestTimeText];
    

    

}

-(void)StarShadow{
    
    for (int i=0; i<5; i++)
    {
        
        CCSprite *StarShadow =[CCSprite spriteWithSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Starbelow.png"]];
        StarShadow.positionType=CCPositionTypeNormalized;
        StarShadow.position =ccp((0.2f)+(0.15f*i),0.75f);
        StarShadow.zOrder=0;
        
        [self addChild:StarShadow];
    }
    
}


-(void)reward:(int)Star
{
    if (Star>0)
    {
        for (int i=0; i<Star; i++)
        {
            
            CCSprite *RewardingStar  =[CCSprite spriteWithSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"starGlow.png"]];
            RewardingStar.positionType=CCPositionTypeNormalized;
            RewardingStar.position =ccp(self.contentSize.width+RewardingStar.contentSize.width, self.contentSize.height*0.752);
            RewardingStar.zOrder=1;
            [self addChild:RewardingStar];
            
            id delay=[ CCActionDelay actionWithDuration:0.2*i];
            id moveto= [CCActionMoveTo actionWithDuration:0.2 position:ccp((0.2f)+(0.15f*i),0.75f)];
            [RewardingStar runAction:[CCActionSequence actions:delay,moveto, nil]];
            
            //----------------------------
            
            CCParticleSystem *flare = [CCParticleSystem particleWithFile:@"GameOverStar.plist"];
            flare.particlePositionType = CCParticleSystemPositionTypeFree;
            flare.positionType=CCPositionTypeNormalized;
            
            flare.position = ccp((0.2f)+(0.15f*i),0.75f);
            [self addChild:flare z:10];
            //----------------------------

        }
    }
}

-(void)Buttons{
    
    
    float bottomLayerHeight = 0.2;
    
    CCButton *Replybtn = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"retry.png"]];
    Replybtn.position = ccp(self.contentSize.width-Replybtn.contentSize.width/2, self.contentSize.height*bottomLayerHeight);
    [Replybtn setTarget:self selector:@selector(onRetryClicked)];
    [self addChild:Replybtn];
    
    
    Sharebtn = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"ShareBtn.png"]];
    Sharebtn.positionType = CCPositionTypeNormalized;
    Sharebtn.position = ccp(0.5f, bottomLayerHeight);
    [Sharebtn setTarget:self selector:@selector(ShareBtnClick)];
    [self addChild:Sharebtn];
    
    
    
    twitterbtn = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"Twitter.png"]];
    twitterbtn.positionType = CCPositionTypeNormalized;
    twitterbtn.position = ccp(0.6f, bottomLayerHeight);
    twitterbtn.scale=0.001;
    [twitterbtn setTarget:self selector:@selector(TwitterClicked)];
    [self addChild:twitterbtn];
    
    
    
    fbbtn = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"Fb.png"]];
    fbbtn.positionType = CCPositionTypeNormalized;
    fbbtn.position = ccp(0.4f, bottomLayerHeight);
    fbbtn.scale=0.001;

    [fbbtn setTarget:self selector:@selector(FBClicked)];
    [self addChild:fbbtn];
    
    
    
    CCButton *Homebtn = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"home.png"]];

    Homebtn.position = ccp(Homebtn.contentSize.width/2, self.contentSize.height*bottomLayerHeight);
    [Homebtn setTarget:self selector:@selector(homeClicked)];
    [self addChild:Homebtn];
}


-(void)LoadScoresAndTime :(int)ScoreLoad {
    
    
    
    [yourScore setString:[NSString stringWithFormat:@"%d",[gameMechanics GetScore:CurrentLevelNameForScore]]];
    [yourTime setString:[NSString stringWithFormat:@"%d:%d",currentsec,currentMoment]];

    [BestTime setString:[NSString stringWithFormat:@"%d:%d",currentsec,currentsec]];
    
    [BestPoint setString:[NSString stringWithFormat:@"%d",[gameMechanics GetHighScore:CurrentLeveNameFoHighScore]]];
    
    float tempmoment  = currentMoment/100;
    float two = currentsec+tempmoment;
    
    
    NSLog(@"two   %f",two);
    
    
}
-(void)ShareBtnClick{
    [Sharebtn runAction:[CCActionHide action]];
    float Actiontime = 0.3;
    
    id FLipx = [CCActionFadeIn actionWithDuration:Actiontime];
    id scale=[CCActionScaleTo actionWithDuration:Actiontime scale:0.5];
    id FLipx2 = [CCActionFadeIn actionWithDuration:Actiontime];
    id scale2=[CCActionScaleTo actionWithDuration:Actiontime scale:0.5];
    [twitterbtn runAction:[CCActionSpawn actionWithArray:@[FLipx,scale]]];
    [fbbtn runAction:[CCActionSpawn actionWithArray:@[FLipx2,scale2]]];
    
}

-(void)ShowScoreAndTime{
    
    CCLabelTTF *yourScoreText = [CCLabelTTF labelWithString:@"Your Point" fontName:Fonthelvetica fontSize:(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)? 25 : 14];
    yourScoreText.positionType=CCPositionTypeNormalized;
    yourScoreText.position=ccp(0.5,0.62);
    yourScoreText.color=[CCColor colorWithRed:0.3 green:0.8 blue:0.8 alpha:1.0];
    [self addChild:yourScoreText];
    
    
    
    
    yourScore = [CCLabelTTF labelWithString:@"123" fontName:Fonthelvetica fontSize:(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)? 140 : 80];
    yourScore.positionType=CCPositionTypeNormalized;
    yourScore.position=ccp(0.5,0.54);
    yourScore.color=[CCColor colorWithRed:0.3 green:0.8 blue:0.8 alpha:1.0];
    [self addChild:yourScore];
    
    
    yourTime = [CCLabelTTF labelWithString:@"your Time" fontName:Fonthelvetica fontSize:(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)? 35 : 20];
    yourTime.positionType=CCPositionTypeNormalized;
    yourTime.position=ccp(0.5,0.35);
    [self addChild:yourTime];
    
    
    
    BestPoint = [CCLabelTTF labelWithString:@"300" fontName:Fonthelvetica fontSize:(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)? 40 : 20];
    BestPoint.positionType=CCPositionTypeNormalized;
    BestPoint.position=ccp(0.1,0.95);
    BestPoint.color=[CCColor colorWithRed:0.4 green:0.8 blue:0.8 alpha:1.0];
    [self addChild:BestPoint];
    
    
    BestTime = [CCLabelTTF labelWithString:@"300" fontName:Fonthelvetica fontSize:
                (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)? 40 : 20];
    BestTime.positionType=CCPositionTypeNormalized;
    BestTime.position=ccp(0.9,0.95);
    [self addChild:BestTime];


}


-(void)onRetryClicked{
    
    [[CCDirector sharedDirector] replaceScene:[GamePlay scene:levelNumber]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:0.4f]];
    
}


-(void)homeClicked
{
    
    [[CCDirector sharedDirector] replaceScene:[MainMenu scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionDown duration:0.4f]];
    
}
-(void)Background{
    
   CCSprite *_background = [CCSprite spriteWithImageNamed:@"menubg.jpg"];
    _background.positionType = CCPositionTypeNormalized;
    _background.position = ccp(0.5f, 0.5f);
    [self addChild:_background z:-1];
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
    
    [super onExit];
}


@end
