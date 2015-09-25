//
//  MyCocos2DClass.h
//  Out of Sequence
//
//  Created by Nur Farazi on 5/7/14.
//  Copyright 2014 nur. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameCenterManager.h"
#import "Social/Social.h"
#import "Accounts/Accounts.h"
#import "CCParticleSystem.h"
#import "LevelSelect.h"
#import "CCParticleSystem.h"
#import "iRate.h"
#import "cocos2d.h"
#import "cocos2d-ui.h"

@interface MainMenu : CCScene <GameCenterManagerDelegate,iRateDelegate>{
    SLComposeViewController *myslcomposeviewcontroler;
    UIViewController *gameCenterController;
    NSMutableArray *menus;
}
+ (MainMenu *)scene;
- (id)init;

@end
