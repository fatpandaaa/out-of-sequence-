//
//  IntroScene.m
//  Out of Sequence
//
//  Created by Nur Farazi on 5/7/14.
//  Copyright nur 2014. All rights reserved.
//

#import "MainMenu.h"
#import "GamePlay.h"
#import "Help.h"
#import "creditPage.h"
#import "GameOverLayer.h"
#import "AppDelegate.h"


@implementation MainMenu{
    CCButton *startbtn;
    CCButton *singleBtn;
    CCButton *multiBtn;
    CCButton *fbBtn;
    CCButton *twiterbtn;
    CCButton *settingbtn;
    CCButton *scorebtn;
    CCButton *ratebtn;
    CCButton *removeAdsbtn;
    
    
    
    CCButton *playbtn;
    CCButton *_CreditBtn;
    CCButton *_HelpBtn;
    CCButton *_gameCenter;
    CCSprite *Logo;
    CCSprite *_background;
    NSString *nametheshare;
    float angle;
    float currentAngle;
    BOOL sutter;
}


+ (MainMenu *)scene
{
	return [[self alloc] init];
}



- (id)init
{
    self = [super init];
    if (!self) return(nil);
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"MenuUI.plist"];

    self.userInteractionEnabled = YES;
    [[GameCenterManager sharedManager] setDelegate:self];
    gameCenterController = [[UIViewController alloc] init];
    menus = [[NSMutableArray alloc]init];
    
    [[iRate sharedInstance] logEvent:NO];


    [self Background];
    [self Buttons];
    [self Logo];
    angle=0;
    sutter = NO;
    
//    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
//    [app showBannerView];
    
    //self.scale=0.7;
   	return self;
}

-(void)Logo{
    
    Logo = [CCSprite spriteWithSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"logo.png"]];
    Logo.positionType = CCPositionTypeNormalized;
    Logo.position = ccp(0.5f, 0.88f);
    [self addChild:Logo];
    
}

-(void)Hideaction :(CCButton *)ButtonName{
    
     CCAction *hide=[CCActionHide action];
    [ButtonName runAction:hide];
    
}

-(void)Showaction :(CCButton *)ButtonName{
    
    CCAction *show=[CCActionShow action];
    [ButtonName runAction:show];
    
}




-(void)moveaction :(CGPoint )points :(CCButton *)btnName
{
    CCAction *actionmove = [CCActionSpawn actions:
                            [CCActionEaseBackInOut actionWithAction:[CCActionMoveTo actionWithDuration:1.0
                                                                                        position:points] ],
                                                    [CCActionScaleTo actionWithDuration:1 scale:1.3], nil ];
    [btnName runAction:actionmove];
    
    
}


-(void)movetocenter :(CGPoint )points :(CCButton *)btnName
{
    
    
    CCActionSequence *sequence=[CCActionSequence actions:
                                [CCActionEaseBackIn actionWithAction:[CCActionSpawn actions:
                                                                      [CCActionMoveTo actionWithDuration:0.6
                                                                                            position:points],
                                                                      [CCActionScaleTo actionWithDuration:1
                                                                                                  scale:0.1],
                                                                      nil] ],
                                [CCActionCallFunc actionWithTarget: self selector: @selector(HideButton)],
                                nil];
    [btnName runAction:sequence];
}

-(void)PlayButtonPressCheck{
    
    if (sutter==YES) {
        sutter=NO;
    } else if (sutter==NO){
        
        sutter=YES;
    }
   
    
}


-(void)Buttons{
   

    CCButton *MoreBtnbtn = [CCButton buttonWithTitle:@""
                                         spriteFrame:[CCSpriteFrame frameWithImageNamed:@"BtnMoreGames.png"]];
    MoreBtnbtn.position = ccp(self.contentSize.width-MoreBtnbtn.contentSize.width/3 ,
                              self.contentSize.height-MoreBtnbtn.contentSize.height*0.301);
    [MoreBtnbtn setTarget:self selector:@selector(MorebtnClick)];
    CCActionRepeatForever *blink = [CCActionRepeatForever actionWithAction:[CCActionSequence actions:[CCActionScaleTo actionWithDuration:0.5 scaleX:1 scaleY:1], [CCActionScaleTo actionWithDuration:0.5 scaleX:0.9 scaleY:0.9],nil]];
    [MoreBtnbtn runAction:blink];
    [self addChild:MoreBtnbtn];
    
    
    startbtn = [CCButton buttonWithTitle:@""
                             spriteFrame:[CCSpriteFrame frameWithImageNamed:@"btnStart.png"]];
    startbtn.position = ccp(self.contentSize.width / 2, self.contentSize.height *0.5);
    [startbtn setTarget:self selector:@selector(StartBtnpress)];
    [self addChild:startbtn z:1];
    
    
    
    singleBtn = [CCButton buttonWithTitle:@""
                             spriteFrame:[CCSpriteFrame frameWithImageNamed:@"single.png"]];
    singleBtn.position = startbtn.position;
    [singleBtn setTarget:self selector:@selector(singleBtnaction)];
    singleBtn.scale=0.1;
    [self addChild:singleBtn z:0];
 
    
    multiBtn = [CCButton buttonWithTitle:@""
                             spriteFrame:[CCSpriteFrame frameWithImageNamed:@"Multi.png"]];
    multiBtn.position = startbtn.position;
    multiBtn.scale=0.1;
    [self addChild:multiBtn z:0];
    
    
    fbBtn = [CCButton buttonWithTitle:@""
                             spriteFrame:[CCSpriteFrame frameWithImageNamed:@"fb.png"]];
    fbBtn.position = startbtn.position;
    [fbBtn setTarget:self selector:@selector(fbBtnaction)];
    fbBtn.scale=0.1;
    [self addChild:fbBtn z:0];
   
    
    twiterbtn = [CCButton buttonWithTitle:@""
                             spriteFrame:[CCSpriteFrame frameWithImageNamed:@"twitter.png"]];
    twiterbtn.position = startbtn.position;
    twiterbtn.scale=0.1;
    [twiterbtn setTarget:self selector:@selector(TwitterBtnaction)];
    [self addChild:twiterbtn z:0];
    
    
    settingbtn = [CCButton buttonWithTitle:@""
                             spriteFrame:[CCSpriteFrame frameWithImageNamed:@"settings.png"]];
    settingbtn.position = startbtn.position;
    settingbtn.scale=0.1;
    [self addChild:settingbtn z:0];
    
    scorebtn = [CCButton buttonWithTitle:@""
                             spriteFrame:[CCSpriteFrame frameWithImageNamed:@"BestScore.png"]];
    scorebtn.position = startbtn.position;
    [scorebtn setTarget:self selector:@selector(Gamecenterbtnaction)];
    scorebtn.scale=0.1;
    [self addChild:scorebtn z:0];
    

    
    ratebtn = [CCButton buttonWithTitle:@""
                             spriteFrame:[CCSpriteFrame frameWithImageNamed:@"Ratebtn.png"]];
    ratebtn.position = startbtn.position;
    [ratebtn setTarget:self selector:@selector(RateBtnaction)];
    ratebtn.scale=0.1;
    [self addChild:ratebtn z:0];
    
    
    removeAdsbtn = [CCButton buttonWithTitle:@""
                             spriteFrame:[CCSpriteFrame frameWithImageNamed:@"RemoveAds.png"]];
    removeAdsbtn.position = startbtn.position;
    removeAdsbtn.scale=0.1;
    [self addChild:removeAdsbtn z:0];
   
    
    [menus addObject:singleBtn];
    [menus addObject:ratebtn];
    [menus addObject:multiBtn];
    [menus addObject:twiterbtn];
    [menus addObject:fbBtn];
    [menus addObject:settingbtn];
    [menus addObject:removeAdsbtn];
    [menus addObject:scorebtn];
    
    
    
    [self HideButton];
 
}
-(void)StartBtnpress{
    
    [self PlayButtonPressCheck];
    
    if (sutter) {
        
        [self ShowButton];
        
        
        for (int i =0; i<=7; i++) {
            
            CCButton *temp = menus[i];
            
            currentAngle = currentAngle+45;
            
            CGPoint direction = ccp(cos(currentAngle * M_PI / 180) *self.contentSize.width*0.3, sin(currentAngle * M_PI / 180) *self.contentSize.height*0.23);
            
            CGPoint new = ccpAdd(startbtn.position, direction);
            
            [self moveaction:new :temp];
            
        }
            
        

        
    } else{
        
        for (int i =0; i<=7; i++) {
            
            
            CCButton *temp = menus[i];
        
            
            [self  movetocenter:startbtn.position :temp];
            
        }

    }
    
    
}


-(void)HideButton{
    

    [self Hideaction:singleBtn];
    [self Hideaction:multiBtn];
    [self Hideaction:fbBtn];
    [self Hideaction:twiterbtn];
    [self Hideaction:settingbtn];
    [self Hideaction:scorebtn];
    [self Hideaction:ratebtn];
    [self Hideaction:removeAdsbtn];
}

-(void)ShowButton{
    
    
    [self Showaction:singleBtn];
    [self Showaction:multiBtn];
    [self Showaction:fbBtn];
    [self Showaction:twiterbtn];
    [self Showaction:settingbtn];
    [self Showaction:scorebtn];
    [self Showaction:ratebtn];
    [self Showaction:removeAdsbtn];
}

-(void)Background{
    
    _background = [CCSprite spriteWithImageNamed:@"menubg.jpg"];
    _background.positionType = CCPositionTypeNormalized;
    _background.position = ccp(0.5f, 0.5f);
    [self addChild:_background z:-1];
}

-(void)singleBtnaction{
    
    
    [[CCDirector sharedDirector] replaceScene:[LevelSelect scene] withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:0.2f]];
   
}
-(void)button_1_action{
    
    
     [[CCDirector sharedDirector] replaceScene:[creditPage scene]];

    
}

-(void)MorebtnClick{
    
}
-(void)ParticleExplotion :(CGPoint)Touchlocation{
    CCParticleExplosion  *blast = [[CCParticleExplosion alloc] initWithTotalParticles:100];
    blast.texture = [CCTexture textureWithFile:@"Star.png"];
    blast.positionType=CCPositionTypeNormalized;
    blast.position=Touchlocation;
    blast.speed=350.0;
    blast.speedVar=40.0;
    blast.life=2.0;
    blast.startSize=5.0;
    blast.startSizeVar=80.0;
    blast.startSpin=0.0;
    blast.endSize=10.0;
    blast.duration=0.5;
    blast.angle = 100.0f;
    blast.lifeVar=3.0;
    blast.gravity = ccp(0,-50);
    blast.blendAdditive=NO;
    
    blast.autoRemoveOnFinish=NO;
    
    [self addChild:blast];

}


-(void)TwitterBtnaction{
    
     [self share:SLServiceTypeTwitter :2];
}
-(void)fbBtnaction{
     [self share:SLServiceTypeFacebook :1];
}

-(void)Gamecenterbtnaction{
    [[CCDirector sharedDirector].view addSubview:gameCenterController.view];
    
    [[GameCenterManager sharedManager] presentLeaderboardsOnViewController:gameCenterController];
    
}
-(void)RateBtnaction{
    [[iRate sharedInstance] promptIfNetworkAvailable];


}

- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController {
    
    
    [gameCenterController dismissViewControllerAnimated:YES completion:nil];
}

- (void)gameCenterManager:(GameCenterManager *)manager authenticateUser:(UIViewController *)gameCenterLoginController {
    
    [gameCenterController presentViewController:gameCenterLoginController animated:YES completion:^{
        NSLog(@"Finished Presenting Authentication Controller");
    }];
}

-(void)dealloc
{
    
}


- (void) share:(NSString *)media :(int)namenum
{
    
    
    //UIViewController *app = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:media];
    
    [controller setInitialText:[NSString stringWithFormat:@"Play Out Of Sequence if you can"]];
    [controller addImage:[UIImage imageNamed:@"forfacebook.png"]];
    
    //[controller addURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/dot-swipe/id823831696?ls=1&mt=8"]];
    
    
    [[CCDirector sharedDirector].view addSubview:controller.view];
    
    [controller setCompletionHandler:^(SLComposeViewControllerResult result){
        
        //[[app navController] dismissModalViewControllerAnimated:YES];
        
        NSString *outout = [[NSString alloc] init];
        
        switch (result) {
            case SLComposeViewControllerResultCancelled:
                outout = @"Post Cancelled";
                break;
            case SLComposeViewControllerResultDone:
                outout = @"Post Done";
                
            default:
                break;
        }
        switch (namenum) {
            case 1:
                nametheshare=[NSString stringWithFormat:@"Facebook"];
                break;
            case 2:
                nametheshare=[NSString stringWithFormat:@"Twitter"];
                break;
                
                
            default:
                break;
        }
        
        UIAlertView *myalertView = [[UIAlertView alloc]initWithTitle:nametheshare message:outout delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [myalertView show];
    }];
}

-(void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    
    CGPoint touchLocation = [touch locationInNode:self];

    [self ParticleExplotion:touchLocation];
}

-(void)Soundbtn{
    
    [[OALSimpleAudio sharedInstance] playEffect:@"first button play.mp3"];
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
