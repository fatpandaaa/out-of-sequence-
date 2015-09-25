//
//  appID.h
//  coran
//
//  Created by nur farazi on 02/03/2014.
//  Copyright (c) 2014 nur games. All rights reserved.
//

#ifndef coran_appID_h
#define coran_appID_h

#define MyAdUnitID @"ca-app-pub-7234603308329467/1090099377";
#define InterstitialID @"ca-app-pub-7234603308329467/9636100972";

#define ChartboostAdID @"53722caac26ee4329baa8a2e";
#define ChartboostcbAppSignature @"0527dab2d8a3f65b6eaedc2ad9ee99d905e5a6c9";



#define IRateBundleID @"com.charles.OutOfSequence";

#define IRateGameLink [NSURL URLWithString:@"https://itunes.apple.com/us/app/out-of-sequence/id882317256?ls=1&mt=8"];


static  NSString *const _PushNotificationBody = @"come back and play Out Of Sequence";

static int const Ipadfontsize = 75;
static int const IphoneFontSize = 40;

static float const GapBetWeenBubble = 2.0f;

static  NSString *const CircleGroup = @"CircleGroup";



static  NSString *const ArcademodeBool = @"Arcademode";
static  NSString *const ClassicModeBool = @"ClassicModeBool";
static  NSString *const ZenModeBool = @"ZenModeBool";



static  NSString *const ArcadeModeHighScore = @"ArcadeModeHighScore";
static  NSString *const ClassicModeHighScore = @"ClassicModeHighScore";
static  NSString *const ZenModeHighScore = @"ZenModeHighScore";


static  NSString *const ClassicModeScore = @"ClassicModeScore";
static  NSString *const ArcadeModeScore = @"ArcadeModeScore";
static  NSString *const ZenModeScore = @"ZenModeScore";


static  NSString *const ClassicTime = @"ClassicModeScoreTime";
static  NSString *const ArcadeTime = @"ArcadeModeScoreTime";
static  NSString *const ZenModeTime = @"ZenModeScoreTime";


static  NSString *const ClassicBestTime = @"ClassicModeScoreBestTime";
static  NSString *const ArcadeBestTime = @"ArcadeModeScoreBestTime";
static  NSString *const ZenModeBestTime = @"ZenModeScoreBestTime";



static const float ClassicModeIntervalTime =5.0f;
static const float ArcadeModeIntervalTime =4.0f;
static const float ZenModeIntervalTime =4.0f;

static  NSString *const Comboone = @"combo1.png";
static  NSString *const Combofive = @"combo5.png";
static  NSString *const Comboten = @"combo10.png";
static  NSString *const Combofifty = @"combo50.png";
static  NSString *const Combohundred = @"combo100.png";


static  NSString *const Fonthelvetica = @"CACMOOSE.TTF";

static const float ParticleScale = 0.8f;
static const CGPoint Gravity = (CGPoint){0, -2};
static const float OutlineFriction = 1.0f;
static const float OutlineElasticity = 0.5f;
static const float SphereFriction = 1.0;
static const float SphereElasticity = 1.0;

static const NSString *NewtonSphereCollisionSphere = @"sphere";
static const NSString *NewtonSphereCollisionOutline = @"outline";
static const NSString *NewtonSphereCollisionRope = @"rope";

static const float NewtonSphereMargin = 3;
static const float NewtonSphereSpacing = 3;


#endif
