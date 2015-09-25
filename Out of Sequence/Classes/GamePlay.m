//
//  MyCocos2DClass.m
//  Out of Sequence
//
//  Created by Nur Farazi on 5/8/14.
//  Copyright 2014 nur. All rights reserved.
//

#import "GamePlay.h"
#import "GameOverLayer.h"
#import "appID.h"




@implementation GamePlay
CCSprite *_background;
CCSprite *_Pausebackground;
int NumArray[20];
int NumArray2[20];
int CheckNumber;
CCButton *PauseBtn;
CCSprite *Circle;

CCButton *ResumeBtn;
CCButton *RestartBtn;
CCButton *QuitBtn;
CCLabelTTF *Timer;
CCLabelTTF * Suggetion;
int Minute;
int Seconds;
int Moment;



+ (GamePlay *)scene:(int)LevelNumber
{
	return [[self alloc] initWithLevel:LevelNumber];
}



- (id)initWithLevel:(int)LevelNumber
{
    self = [super init];
    if (!self) return(nil);
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"GameplayUI.plist"];

    CheckNumber=0;
    StarNumber =6;

    self.userInteractionEnabled = YES;


    gamemechanic = [[GameMechanics alloc]init];
    ButtonArray = [[NSMutableArray alloc]init];
  
    
    switch (LevelNumber) {
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
            //[self IceBonusInitialize];
            break;
            
        default:
            break;
    }

    
    
    classic = [[NSUserDefaults standardUserDefaults]boolForKey:ClassicModeBool];
    arcade = [[NSUserDefaults standardUserDefaults] boolForKey:ArcademodeBool];
    zen = [[NSUserDefaults standardUserDefaults] boolForKey:ZenModeBool];
    
    
    classicmodereset = 0;
    
    if (classic) {
        Minute=0;
        Seconds=0;
        Moment = 0;
        [self schedule:@selector(CallNumber:) interval:ClassicModeIntervalTime];
        
        [self schedule:@selector(againCallGameOver:) interval:1.0];
        
    }
    
    if (arcade) {
        [self schedule:@selector(CallNumber:) interval:ArcadeModeIntervalTime];
        Minute=0;
        Seconds=0;
        Moment = 0;
    }
    if (zen) {
        
        [self schedule:@selector(CallNumber:) interval:ZenModeIntervalTime];
        Minute=0;
        Seconds=30;
        Moment = 9;
    }

    ComboChecker = 0;
    Score = 0;
    
    LevelNumberr=LevelNumber;
    
    [self Background];
    [self UIBars];
    [self Buttons];
    [self Showtext];
    [self StartTheGame];
    [self GoldCoinInitialize];
    
    
    [self schedule:@selector(RewarSystemCheck:) interval:20.0];

    [[OALSimpleAudio sharedInstance] playBg:@"Chase.wav" loop:YES];
    
    
   	return self;
}



-(void)GoldCoinInitialize{
    
    int minY = 5;
    int maxY = 30;
    int rangeY = maxY - minY;
    int actualY = (arc4random() % rangeY) + minY;
    
    
//    [self schedule:@selector(addGoldCoin) interval:5];
    
    [self scheduleBlock:^(CCTimer *timer) {
        [self addGoldCoin];
    } delay:actualY];

}


-(void)IceBonusInitialize{
    
    int minY = 5;
    int maxY = 20;
    int rangeY = maxY - minY;
    int actualY = (arc4random() % rangeY) + minY;
    
    
    [self schedule:@selector(IceBonus:) interval:actualY];
    
}



-(void)RewarSystemCheck:(CCTime)dt{
    StarNumber--;
    if (StarNumber==0) {
        [self unschedule:@selector(RewarSystemCheck:)];
    }
}


-(void)StartTheGame{
    
    
    if (classic || arcade) {
        MomentTimer =  [NSTimer scheduledTimerWithTimeInterval:0.1
                                                        target:self
                                                      selector:@selector(timerFired)
                                                      userInfo:nil
                                                       repeats:YES];

    }
    
    else{
        MomentTimer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                       target:self
                                                     selector:@selector(timerFiredForZen)
                                                     userInfo:nil
                                                      repeats:YES];
    }
}



-(void)timerFiredForZen
{
    if (!isPaused) {
        if (Seconds>=0 && Moment >=0) {
            if (Moment<=9) {
                Moment--;
            }
            if (Moment<=0) {
                Moment=9;
                Seconds--;
            }
            if(Seconds<0 && Moment==9) {
                Seconds =0;
                Moment =0;
                [[CCDirector sharedDirector] resume];
                [[CCDirector sharedDirector] replaceScene:[GameOverLayer scene:Seconds :Moment :StarNumber :LevelNumberr :Score]];
            }

            
            [Timer setString:[NSString stringWithFormat:@"%d%@%02d",Seconds,@":",Moment]];
        }
        
    }
}

-(void)Combo :(NSString*)ComboNumber :(CGPoint)PressedButtonLocation{
    
    CCSprite * one =[CCSprite spriteWithSpriteFrame:[CCSpriteFrame frameWithImageNamed:ComboNumber]];
    one.positionType=CCPositionTypeNormalized;
    one.position=PressedButtonLocation;
    one.scale = 0.2;
    [self addChild:one z:2];
    
    CCAction * scaleup = [CCActionScaleTo actionWithDuration:0.5 scale:1.9];
    CCAction * fadeout = [CCActionFadeOut actionWithDuration:0.5];
    
    [one runAction:[CCActionSequence actionWithArray:@[scaleup,fadeout]]];
  
}


-(void)ComboCheckerAndCall :(CCButton* )PressedButton{
    
    ComboChecker++;
    if (ComboChecker==1) {
        [self Combo:Comboone :PressedButton.position];
        
        [gamemechanic AddScore:1 :CurrentLevelNameForScore :CurrentLeveNameFoHighScore];
        [self schedule:@selector(UpdatePoint:) interval:0.1];
        [self CoinCollect];

    }
    if (ComboChecker==2) {
        [self Combo:Combofive :PressedButton.position];
        [gamemechanic AddScore:5 :CurrentLevelNameForScore :CurrentLeveNameFoHighScore];
        [self schedule:@selector(UpdatePoint:) interval:0.1];
        [self CoinCollect];

    }
    if (ComboChecker==3) {
        [self Combo:Comboten :PressedButton.position];
        [gamemechanic AddScore:10 :CurrentLevelNameForScore :CurrentLeveNameFoHighScore];
        [self schedule:@selector(UpdatePoint:) interval:0.1];
        [self CoinCollect];
    }
    if (ComboChecker==4) {
        [self Combo:Combofifty :PressedButton.position];
        [gamemechanic AddScore:10 :CurrentLevelNameForScore :CurrentLeveNameFoHighScore];
        [self schedule:@selector(UpdatePoint:) interval:0.1];
        [self CoinCollect];

    }
    if (ComboChecker>=4) {
        [self Combo:Combofifty :PressedButton.position];
        [gamemechanic AddScore:50 :CurrentLevelNameForScore :CurrentLeveNameFoHighScore];
        [self schedule:@selector(UpdatePoint:) interval:0.1];
        [self CoinCollect];

    }
    if (ComboChecker>=5) {
        [self Combo:Combohundred :PressedButton.position];
        [gamemechanic AddScore:100 :CurrentLevelNameForScore :CurrentLeveNameFoHighScore];
        [self schedule:@selector(UpdatePoint:) interval:0.2];
        [self CoinCollect];

    }
    
}

-(void)UpdatePoint :(CCTime)dt{
    
    Score = Score+1;
    
    [PointText setString:[NSString stringWithFormat:@"%d",Score]];
    
    if (Score==[gamemechanic GetScore:CurrentLevelNameForScore]) {
        [self StopUpdateAnimation];
    }
}

-(void)StopUpdateAnimation{
    [self unschedule:@selector(UpdatePoint:)];
}



-(void)timerFired
{
    if (!isPaused) {
        if (Seconds>=0 && Moment >=0) {
            if (Moment>=0) {
                Moment+=1;
            }
            if (Moment>9) {
                Moment=0;
                Seconds+=1;
            }
            [Timer setString:[NSString stringWithFormat:@"%d%@%02d",Seconds,@":",Moment]];
        }
    }
}

-(void)againCallGameOver :(CCTime)dt
{

    classicmodereset++;
    
    if (classicmodereset==ClassicModeIntervalTime) {
        
        id end = [CCActionCallBlock actionWithBlock:^{
            [[CCDirector sharedDirector] replaceScene:[GameOverLayer scene:Seconds :Moment :StarNumber :LevelNumberr :Score] withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:0.5f]];
        }];
        
        [self runAction:end];
    }
}

-(void)Background{
    
    _background = [CCSprite spriteWithImageNamed:@"bg.png"];
    _background.positionType = CCPositionTypeNormalized;
    _background.position = ccp(0.5f, 0.5f);
    [self addChild:_background z:-1];
}


-(void)CreateRandomCircle{
    int Range = 20;
    int random;
    int checker[Range];
    
    for(int i = 0 ; i < Range ; i++)
    {
        checker[i] = 0;
    }
    for(int i = 0 ; i < Range ; i++)
        
    {
        random = arc4random() % Range;
        
        while(checker[random] == 1)
            
        {
            random = arc4random() % Range;
        }
        checker[random] = 1;
        
        NumArray2 [i]=random;
    }
}

-(void)Showtext{
    
    Suggetion=[CCLabelTTF labelWithString:@"0" fontName:Fonthelvetica fontSize:(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)? 40 : 18];
    Suggetion.position=ccp(PointBar.position.x,PointBar.position.y);
    [self addChild:Suggetion z:1];
    
    
    Timer=[CCLabelTTF labelWithString:@"" fontName:Fonthelvetica fontSize:(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)? 40 : 20];

    if ([ [ UIScreen mainScreen ] bounds ].size.height ==568 ) {
        
        Timer.position=ccp(PointBar.position.x+PointBar.contentSize.width/3.1,PointBar.position.y);
    }
    else{
        Timer.position=ccp(PointBar.position.x+PointBar.contentSize.width/2.8,PointBar.position.y);

    }

    Timer.color=[CCColor colorWithRed:1 green:1 blue:0.8 alpha:1];
    [self addChild:Timer z:1];
    
    
    PointText=[CCLabelTTF labelWithString:@"0" fontName:Fonthelvetica fontSize:(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)? 40 : 20];
    PointText.position=ccp(PointBar.position.x-PointBar.contentSize.width/3.5,PointBar.position.y);
    PointText.color=[CCColor colorWithRed:1 green:1 blue:1 alpha:1.0];
    [self addChild:PointText z:1];
    
}

NSString *names[] = {
    @"BlueCircle.png",
    @"GreenCircle.png",
    @"pinkCircle.png",
    @"redcircle.png",
    @"YellowCircle.png"
    
};

-(void)CallNumber:(CCTime)dt{
    
    ComboChecker=0;
    [self removeAll];
    [self CreateRandomCircle];
    
    
    for (int i = 0 ; i<=19; i++) {
        
        CCButton *Circle = [CCButton buttonWithTitle:[NSString stringWithFormat:@"%d",i] fontName:@"Helvetica" fontSize:(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)? Ipadfontsize : IphoneFontSize];
        Circle.positionType = CCPositionTypeNormalized;
        [self addChild:Circle z:1];
        Circle.name =[NSString stringWithFormat:@"%d",i];

        [Circle runAction:[CCActionEaseBounceOut actionWithAction:[CCActionScaleTo actionWithDuration:0.7 scale:1.0]]];
        
        [ButtonArray addObject:Circle];
    
        
        PositionFixed *positionnn = [PositionFixed LoadPositionArray];
        CGPoint point = [positionnn getLocation:NumArray2[i]];
        
        
        Circle.position = point;
        
        NSString *Imagename = names[arc4random()%5];
        

        CCSprite *temp = [CCSprite spriteWithSpriteFrame:[CCSpriteFrame frameWithImageNamed:Imagename]];
        temp.positionType = CCPositionTypeNormalized;
        temp.position = point;
        temp.name =[NSString stringWithFormat:@"%d",(20+i)];
        [self addChild:temp];
    
        
        [Circle setTarget:self selector:@selector(AllCheckForTouch:)];
    }

}
- (void)AllCheckForTouch:(id)sender{
    
    CCButton *buttonPressed = (CCButton*)sender;
    
  
    
    if ([[buttonPressed name] isEqualToString:[NSString stringWithFormat:@"%d",CheckNumber]]) {
        
        [buttonPressed removeFromParent];
        [self IncreaseCheckNumber];
        [self ParticleExplotion:buttonPressed.position];
        [self ComboCheckerAndCall:buttonPressed];
        
        classicmodereset=0;
        } else{
            [buttonPressed runAction:[CCActionSequence actions:[CCActionScaleTo actionWithDuration:0.1 scale:1.2f],[CCActionScaleTo actionWithDuration:0.1 scale:1.0f], nil]];
        }

}



-(void)addGoldCoin{
    
    int i = arc4random()%20;
    
    
    PositionFixed *positionnn = [PositionFixed LoadPositionArray];
    
    CGPoint point = [positionnn getLocation:i];
    
    goldicoin = [GoldCoin newtonSphereWithLetter];
    goldicoin.positionType=CCPositionTypeNormalized;
    goldicoin.position = point;
    goldicoin.name=@"GoldC";
    
    [self addChild:goldicoin z:32];

    
    
}


-(void)GoldCoinAction{
    
    CCActionMoveTo *move = [CCActionMoveTo actionWithDuration:2 position:ccp(0.1,0.9)];
    CCActionRemove *remove = [CCActionRemove action];

    
    [goldicoin runAction:[CCActionSequence actions:move, remove, nil]];
    
    [gamemechanic AddScore:500 :CurrentLevelNameForScore :CurrentLeveNameFoHighScore];
    [self schedule:@selector(UpdatePoint:) interval:0.1];
}

-(void)removeAll{
    for (int i = 0 ; i<=40; i++) {
        [self removeChildByName:[NSString stringWithFormat:@"%d",i]];
    }
    
}
-(void)IncreaseCheckNumber{
    CheckNumber+=1;
    [Suggetion setString:[NSString stringWithFormat:@"%d",CheckNumber]];
    
    if (CheckNumber>=19) {
        [MomentTimer invalidate];
        [[CCDirector sharedDirector] replaceScene:[GameOverLayer scene:Seconds :Moment :StarNumber :LevelNumberr :Score] withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:0.5f]];
    }
}

-(void)UIBars{
    
        PointBar = [CCSprite spriteWithSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"bar.png"]];
        PointBar.position = ccp(self.contentSize.width/2,self.contentSize.height-PointBar.contentSize.height/2);
        [self addChild:PointBar z:0];

    if ([ [ UIScreen mainScreen ] bounds ].size.height ==568 ) {
        
        PointBar.scale=0.84;
       
        
        }
    else{
        
    }

    
    
    
 
    
}
-(void)SoundWrong{
    
    [[OALSimpleAudio sharedInstance] playEffect:@"Wrong.mp3"];
}

-(void)Buttons {
    
    PauseBtn = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"PauseBtn.png"]];
    PauseBtn.positionType = CCPositionTypeNormalized;
    PauseBtn.position = ccp(0.95f, 0.91f);
    PauseBtn.scale=0.6;
    [PauseBtn setTarget:self selector:@selector(PauseAction)];
    [self addChild:PauseBtn];
    PauseBtn.visible=YES;
    
    
    ResumeBtn = [CCButton buttonWithTitle:@""
                              spriteFrame:[CCSpriteFrame frameWithImageNamed:@"PauseResume.png"]];
    ResumeBtn.positionType = CCPositionTypeNormalized;
    ResumeBtn.position = ccp(0.5,0.7);
    [ResumeBtn setTarget:self selector:@selector(ResumeAction)];
    
    
    
    RestartBtn = [CCButton buttonWithTitle:@""
                               spriteFrame:[CCSpriteFrame frameWithImageNamed:@"PauseRestart.png"]];
    RestartBtn.positionType = CCPositionTypeNormalized;
    RestartBtn.position = ccp(0.5,0.5);
    [RestartBtn setTarget:self selector:@selector(Restartgame)];
    
    
    
    QuitBtn = [CCButton buttonWithTitle:@""
                            spriteFrame:[CCSpriteFrame frameWithImageNamed:@"pauseMenu.png"]];
    QuitBtn.positionType = CCPositionTypeNormalized;
    QuitBtn.position = ccp(0.5,0.3);
    [QuitBtn setTarget:self selector:@selector(Quitegame)];
    
    
    _Pausebackground = [CCSprite spriteWithImageNamed:@"menubg.jpg"];
    _Pausebackground.positionType = CCPositionTypeNormalized;
    _Pausebackground.position = ccp(0.5,0.5);
    
    
}

-(void)PauseAction{
    
    [MomentTimer invalidate];
    PauseBtn.visible=NO;
    [self addChild: ResumeBtn z:2];
    [self addChild: RestartBtn z:2];
    [self addChild:QuitBtn z:2];
    [self addChild:_Pausebackground z:1];
    [[CCDirector sharedDirector] pause];
    
}

-(void)CoinCollect{
    CCParticleSystem *fire = [CCParticleSystem particleWithFile:@"CoinCollectAtBar.plist"];
    fire.particlePositionType = CCParticleSystemPositionTypeFree;
    
    fire.position = PointText.position;
    [self addChild:fire];
}

-(void)ParticleExplotion :(CGPoint)Touchlocation{
    CCParticleExplosion  *blast = [[CCParticleExplosion alloc] initWithTotalParticles:100];
    blast.texture = [CCTexture textureWithFile:@"Star.png"];
    blast.positionType=CCPositionTypeNormalized;
    blast.position=Touchlocation;
    blast.speed=350.0;
    blast.life=1.0;
    blast.startSize=50.0;
    blast.startSpin=200.0;
    blast.endSize=0.0;
    blast.duration=0.2;
    blast.angle = 100.0f;
    blast.lifeVar=3.0;
    blast.gravity = ccp(0,0);
    blast.blendAdditive=YES;
    
    blast.autoRemoveOnFinish=NO;
    
    [self addChild:blast];
    
}

-(void)ResumeAction{
    PauseBtn.visible=YES;
    [self StartTheGame];
    [RestartBtn removeFromParent];
    [ResumeBtn removeFromParent];
    [QuitBtn removeFromParent];
    [_Pausebackground removeFromParent];
    [[CCDirector sharedDirector] resume];
    
}



-(void)Restartgame{
    [[CCDirector sharedDirector] resume];
    [[CCDirector sharedDirector] replaceScene:[GamePlay scene:LevelNumberr] withTransition:[CCTransition transitionFadeWithDuration:0.3]];
}
-(void)Quitegame{
    [[CCDirector sharedDirector] resume];
    [[CCDirector sharedDirector] replaceScene:[MainMenu scene] withTransition:[CCTransition transitionFadeWithDuration:0.3]];
}
- (void)onEnter
{
    [super onEnter];
}
- (void)onExit
{
    
    [MomentTimer invalidate];
    [super onExit];
}

@end
