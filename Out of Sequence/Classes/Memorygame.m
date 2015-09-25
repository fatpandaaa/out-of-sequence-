//
//  MyCocos2DClass.m
//  Out of Sequence
//
//  Created by Nur Farazi on 7/15/14.
//  Copyright 2014 nur. All rights reserved.
//

#import "Memorygame.h"


@implementation Memorygame

int second;
int Moment;
NSTimer *MomentTimer;
bool isPaused;



+ (Memorygame *)scene
{
	return [[self alloc] init];
}

- (id)init
{
    self = [super init];
    if (!self) return(nil);
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"GameplayUI.plist"];

    gamemechanic = [[GameMechanics alloc]init];

    CurrentNumber =2;
    
    StoreNumberArray = [[NSMutableArray alloc]init];
    [self Background];
    
    [self UIBars];
    [self Showtext];
    [self StartTheGame];

    [self CallNumber];
    [self NewPuzzle];
    
    return self;
    
    
}

-(void)GenerateRandomNumber{
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

NSString *namess[] = {
    @"BlueCircle.png",
    @"GreenCircle.png",
    @"pinkCircle.png",
    @"redcircle.png",
    @"YellowCircle.png"
    
};

-(void)NewPuzzle{
    [self GenerateRandomNumber];
    CurrentNumber++;
    CheckerNumber=0;
    
    for (int i = 0 ; i<=20; i++) {
        [self removeChildByName:[NSString stringWithFormat:@"%d",i]];
    }
    for (int i = 40 ; i<=60; i++) {
        [self removeChildByName:[NSString stringWithFormat:@"%d",i]];
    }
    
    [self GenerateNumberr:CurrentNumber];
    
    
    
}

-(void)CallNumber{
    
    [self removeAll];
    [self GenerateRandomNumber];
    
    
    for (int i = 0 ; i<=19; i++) {
        
        
        PositionFixed *positionnn = [PositionFixed LoadPositionArray];
        CGPoint point = [positionnn getLocation:NumArray2[i]];
        
        NSString *Imagename = namess[arc4random()%5];
        
        
        CCSprite *temp = [CCSprite spriteWithSpriteFrame:[CCSpriteFrame frameWithImageNamed:Imagename]];
        temp.positionType = CCPositionTypeNormalized;
        temp.position = point;
        temp.name =[NSString stringWithFormat:@"%d",(80+i)];
        [self addChild:temp];
   
    }

}
-(void)GenerateNumberr :(int)NumberAmount{
    
    for (int i = 0; i<=NumberAmount; i++) {
        CCButton *NumberS = [CCButton buttonWithTitle:[NSString stringWithFormat:@"%d",i] fontName:@"Helvetica" fontSize:80];
        CCButton *invisibleButton = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"invisible.png"]];
        
        NumberS.positionType = CCPositionTypeNormalized;
        invisibleButton.positionType=CCPositionTypeNormalized;
        
        PositionFixed *positionnn = [PositionFixed LoadPositionArray];
        CGPoint point = [positionnn getLocation:NumArray2[i]];
        
        NumberS.position = point;
        invisibleButton.position=NumberS.position;
        
        invisibleButton.name =[NSString stringWithFormat:@"%d",i];
        NumberS.name=[NSString stringWithFormat:@"%d",(40+i)];
        
        invisibleButton.opacity=0.0;
        
        [self addChild:NumberS z:2];
        [self addChild:invisibleButton z:1];
        
        
        [invisibleButton setTarget:self selector:@selector(CheckForSequence:)];
        
        
        id scaledown  =[CCActionScaleTo actionWithDuration:1 scale:1.6];
        id delay = [CCActionDelay actionWithDuration:3];
        id vanish = [CCActionHide action];
        [NumberS runAction:[CCActionSequence actionWithArray:@[delay,scaledown,vanish]]];
        
    }
    
}





-(void)StartTheGame{
    
        MomentTimer =  [NSTimer scheduledTimerWithTimeInterval:0.1
                                                        target:self
                                                      selector:@selector(timerFired)
                                                      userInfo:nil
                                                       repeats:YES];
}


-(void)timerFired
{
    if (!isPaused) {
        if (second>=0 && Moment >=0) {
            if (Moment<=9) {
                Moment--;
            }
            if (Moment<=0) {
                Moment=9;
                second--;
            }
            [Timer setString:[NSString stringWithFormat:@"%d%@%02d",second,@":",Moment]];
        }
        
    }
}




- (void)CheckForSequence:(id)sender{
    
    CCButton *buttonPressed = (CCButton*)sender;
    
    if ([[buttonPressed name] isEqualToString:[NSString stringWithFormat:@"%d",CurrentNumber]]) {
        [self NewPuzzle];
        
    }
    
    
    if ([[buttonPressed name] isEqualToString:[NSString stringWithFormat:@"%d",CheckerNumber]]) {
        CheckerNumber++;
        [self ParticleExplotion:buttonPressed.position];
        [self ComboCheckerAndCall:buttonPressed];
        NSLog(@"hoyse");
    }
    else{
        [buttonPressed runAction:[CCActionSequence actions:[CCActionScaleTo actionWithDuration:0.1 scale:1.2f],[CCActionScaleTo actionWithDuration:0.1 scale:1.0f], nil]];
    }
}

-(void)Showtext{
    
       
    Timer=[CCLabelTTF labelWithString:@"" fontName:Fonthelvetica fontSize:(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)? 40 : 20];
    
    Timer.position=ccp(PointBar.position.x+PointBar.contentSize.width/2.7,PointBar.position.y);
    Timer.color=[CCColor colorWithRed:1 green:1 blue:0.8 alpha:1];
    [self addChild:Timer z:1];
    
    
    PointText=[CCLabelTTF labelWithString:@"0" fontName:Fonthelvetica fontSize:(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)? 40 : 20];
    PointText.position=ccp(PointBar.position.x-PointBar.contentSize.width/3.5,PointBar.position.y);
    PointText.color=[CCColor colorWithRed:1 green:1 blue:1 alpha:1.0];
    [self addChild:PointText z:1];
    
}


-(void)CoinCollect{
    CCParticleSystem *fire = [CCParticleSystem particleWithFile:@"CoinCollectAtBar.plist"];
    fire.particlePositionType = CCParticleSystemPositionTypeFree;
    
    fire.position = PointText.position;
    [self addChild:fire];
}

//----------------------------------------------------------


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
        
//[gamemechanic AddScore:1 :CurrentLevelNameForScore :CurrentLeveNameFoHighScore];
        [self UpdatePoint];
        [self CoinCollect];
        
    }
    if (ComboChecker==2) {
        [self Combo:Combofive :PressedButton.position];
        //[gamemechanic AddScore:5 :CurrentLevelNameForScore :CurrentLeveNameFoHighScore];
        [self UpdatePoint];
        [self CoinCollect];
        
    }
    if (ComboChecker==3) {
        [self Combo:Comboten :PressedButton.position];
        //[gamemechanic AddScore:10 :CurrentLevelNameForScore :CurrentLeveNameFoHighScore];
        [self UpdatePoint];
        [self CoinCollect];
    }
    if (ComboChecker==4) {
        [self Combo:Combofifty :PressedButton.position];
        //[gamemechanic AddScore:10 :CurrentLevelNameForScore :CurrentLeveNameFoHighScore];
        [self UpdatePoint];
        [self CoinCollect];
        
    }
    if (ComboChecker>=4) {
        [self Combo:Combofifty :PressedButton.position];
        //[gamemechanic AddScore:50 :CurrentLevelNameForScore :CurrentLeveNameFoHighScore];
        [self UpdatePoint];
        [self CoinCollect];
        
    }
    if (ComboChecker>=5) {
        [self Combo:Combohundred :PressedButton.position];
        //[gamemechanic AddScore:100 :CurrentLevelNameForScore :CurrentLeveNameFoHighScore];
        [self UpdatePoint];
        [self CoinCollect];
        
    }
    
}

-(void)UpdatePoint{
    
    //[PointText setString:[NSString stringWithFormat:@"%d",[gamemechanic GetScore:CurrentLevelNameForScore]]];
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

//---------------------------------------------------------------------------





-(void)removeAll{
    for (int i = 80 ; i<=100; i++) {
        [self removeChildByName:[NSString stringWithFormat:@"%d",i]];
    }
    
}

-(void)Background{
    
    CCSprite *_background = [CCSprite spriteWithImageNamed:@"bg.png"];
    _background.positionType = CCPositionTypeNormalized;
    _background.position = ccp(0.5f, 0.5f);
    [self addChild:_background z:-1];
}


-(void)UIBars{
    PointBar = [CCSprite spriteWithSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"bar.png"]];
    PointBar.position = ccp(PointBar.contentSize.width/2,self.contentSize.height-PointBar.contentSize.height/2);
    [self addChild:PointBar z:0];
    
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
