//
//  AppDelegate.h
//  Out of Sequence
//
//  Created by Nur Farazi on 5/7/14.
//  Copyright nur 2014. All rights reserved.
//
// -----------------------------------------------------------------------

#import "cocos2d.h"
#import "iRate.h"
#import "appID.h"
#import "GameCenterManager.h"
//#import "Chartboost.h"
//#import "GADBannerView.h"

typedef enum _bannerType
{
    kBanner_Portrait_Top,
    kBanner_Portrait_Bottom,
    kBanner_Landscape_Top,
    kBanner_Landscape_Bottom,
}CocosBannerType;

@interface AppDelegate : CCAppDelegate {
    CocosBannerType mBannerType;
    //GADBannerView *mBannerView;
    float on_x, on_y, off_x, off_y;
    //Chartboost *cb;
    
    
    
    //GADBannerView *bannerView_;
}

@end
