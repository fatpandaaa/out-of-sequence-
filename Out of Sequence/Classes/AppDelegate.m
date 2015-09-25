//
//  AppDelegate.m
//  Out of Sequence
//
//  Created by Nur Farazi on 5/7/14.
//  Copyright nur 2014. All rights reserved.
//
// -----------------------------------------------------------------------

#import "AppDelegate.h"
#import "IntroScene.h"
#import "HelloWorldScene.h"
#import "MainMenu.h"

@implementation AppDelegate


-(void)applicationDidBecomeActive:(UIApplication *)application{
    
    [[CCDirector sharedDirector] resume];
    
    
//    cb = [Chartboost sharedChartboost];
//    
//    cb.appId = ChartboostAdID;
//    cb.appSignature = ChartboostcbAppSignature;
//    
//    cb.delegate = self;
//    
//    [cb startSession];
//    [cb cacheInterstitial];
//    
//    [cb showInterstitial];
    
    
    
    
    [iRate sharedInstance].applicationBundleID = IRateBundleID;
	
    //enable preview mode
    [iRate sharedInstance].previewMode = YES;
    
    //prevent automatic prompt
    [iRate sharedInstance].promptAtLaunch = NO;
    
    [iRate sharedInstance].eventsUntilPrompt = 15;
    
    [iRate sharedInstance].daysUntilPrompt = 5;
    [iRate sharedInstance].usesUntilPrompt = 5;
    [iRate sharedInstance].ratingsURL = IRateGameLink;
    
    
    
    
    [[GameCenterManager sharedManager] setupManager];


    //[self ShowAdmobBanner];

    
}
//-(void)ShowAdmobBanner{
//    
//    bannerView_ = [[GADBannerView alloc] initWithAdSize:kGADAdSizeSmartBannerPortrait];
//    bannerView_.adUnitID = MyAdUnitID;
//    bannerView_.rootViewController = self.navController;
//    [self.navController.view addSubview:bannerView_];
//    [bannerView_ loadRequest:[GADRequest request]];
//    
//    
//    CGSize s = [[CCDirector sharedDirector] viewSize];
//    
//    CGRect frame = bannerView_.frame;
//    
//    off_x = 0.0f;
//    on_x = 0.0f;
//    mBannerType = kBanner_Portrait_Bottom;
//    
//    switch (mBannerType)
//    {
//        case kBanner_Portrait_Top:
//        {
//            off_y = -frame.size.height;
//            on_y = 0.0f;
//        }
//            break;
//        case kBanner_Portrait_Bottom:
//        {
//            off_y = s.height;
//            on_y = s.height-frame.size.height;
//        }
//            break;
//        case kBanner_Landscape_Top:
//        {
//            off_y = -frame.size.height;
//            on_y = 0.0f;
//        }
//            break;
//        case kBanner_Landscape_Bottom:
//        {
//            off_y = s.height;
//            on_y = s.height-frame.size.height;
//        }
//            break;
//            
//        default:
//            break;
//    }
//    
//    frame.origin.y = off_y;
//    frame.origin.x = off_x;
//    
//    bannerView_.frame = frame;
//    
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.5];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
//    
//    frame = bannerView_.frame;
//    frame.origin.x = on_x;
//    frame.origin.y = on_y;
//    
//    
//    bannerView_.frame = frame;
//    [UIView commitAnimations];
//    
//    
//    
//}

- (void)iRateUserDidRequestReminderToRateApp
{
    //reset event count after every 5 (for demo purposes)
    [iRate sharedInstance].eventCount = 0;
}

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	// This is the only app delegate method you need to implement when inheriting from CCAppDelegate.
	// This method is a good place to add one time setup code that only runs when your app is first launched.
	
	// Setup Cocos2D with reasonable defaults for everything.
	// There are a number of simple options you can change.
	// If you want more flexibility, you can configure Cocos2D yourself instead of calling setupCocos2dWithOptions:.
	[self setupCocos2dWithOptions:@{
		// Show the FPS and draw call label.
		CCSetupShowDebugStats: @(YES),
		
		// More examples of options you might wa nt to fiddle with:
		// (See CCAppDelegate.h for more information)
		
		// Use a 16 bit color buffer: 
//		CCSetupPixelFormat: kEAGLColorFormatRGB565,
		// Use a simplified coordinate system that is shared across devices.
//		CCSetupScreenMode: CCScreenModeFixed,
		// Run in portrait mode.
		CCSetupScreenOrientation: CCScreenOrientationPortrait,
		// Run at a reduced framerate.
//		CCSetupAnimationInterval: @(1.0/30.0),
		// Run the fixed timestep extra fast.
//		CCSetupFixedUpdateInterval: @(1.0/180.0),
		// Make iPad's act like they run at a 2x content scale. (iPad retina 4x)
//		CCSetupTabletScale2X: @(YES),
	}];
	
	return YES;
}

-(void)applicationDidEnterBackground:(UIApplication *)application{
    
    [[CCDirector sharedDirector] stopAnimation];
    [[CCDirector sharedDirector] pause];
    
    
    NSDate *alertTime = [[NSDate date]dateByAddingTimeInterval:100000];
    
    UIApplication *app = [UIApplication sharedApplication];
    
    UILocalNotification *notification = [[UILocalNotification alloc]init];
    
    if (notification) {
    
        notification.fireDate = alertTime;
        notification.timeZone=[NSTimeZone defaultTimeZone];
        notification.repeatInterval = 0;
        notification.alertBody = _PushNotificationBody;
        notification.alertLaunchImage=@"icon";
        
        [app scheduleLocalNotification:notification];
    }
    
}

-(void)applicationWillEnterForeground:(UIApplication *)application{
    
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *Oldnotification = [ app scheduledLocalNotifications];
    
    if (Oldnotification >0) {
        [app cancelAllLocalNotifications];
    }
    
}
-(void)applicationWillResignActive:(UIApplication *)application{
    
    [[CCDirector sharedDirector] resume];
    
}



- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
	[[CCDirector sharedDirector] purgeCachedData];
}



-(CCScene *)startScene
{
	// This method should return the very first scene to be run when your app starts.
	return [MainMenu scene];
}



@end
