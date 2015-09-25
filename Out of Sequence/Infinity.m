//
//  Compare.m
//  Out of Sequence
//
//  Created by Nur Farazi on 6/17/14.
//  Copyright 2014 nur. All rights reserved.
//

#import "Infinity.h"
#import "Sphere.h"


@implementation Infinity{
    CCPhysicsNode *_physicsWorld;
    int NumArray2[99];
    int increasenum;
    int checkamount;
    NSMutableArray *SpearMainArray;
    NSMutableArray *StoredForSort;
    NSMutableArray *MainCompareArray;
    NSInteger paisi[99];
    NSString *str;
 
    
    

}

+ (Infinity *)scene
{
	return [[self alloc] init];
}

- (id)init
{
    self = [super init];
    if (!self) return(nil);
    
    [self PhysicsWorldLoad];
    [self drawOutline];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"GameplayUI.plist"];
  
   
    [self Background];
    
    checkamount = 20;
 
    [self StartANewame];
   
    self.userInteractionEnabled = YES;

    return self;
}


-(void)StartANewame{
    SpearMainArray = [[NSMutableArray alloc]init];
    StoredForSort = [[NSMutableArray alloc]init];
    MainCompareArray = [[NSMutableArray alloc]init];
    
    [self UniqueNumberenerator:checkamount];
    
    [self LoadAllTheSpheare];
    [self GenerateNumber:checkamount];
    
    [self SmallerOrBier:YES];
    [self ForSort];
    
}
-(void)LoadAllTheSpheare{
    
  
    for (int i = 0; i<=10; i++) {
        
        Sphere *sphear0 = [[Sphere alloc]init];
        [sphear0 setSpritename:[NSString stringWithFormat:@"%@",namesssss[arc4random()%5]]];
        [sphear0 setNumber:[NSString stringWithFormat:@"%d",NumArray2[i]]];
        [SpearMainArray addObject:sphear0];

    }
 }
NSString *namesssss[] = {
    @"BlueCircle.png",
    @"GreenCircle.png",
    @"pinkCircle.png",
    @"redcircle.png",
    @"YellowCircle.png"
    
};


-(void)GenerateNumber :(int)amount{
    
    increasenum = 0;
    
    
    [self schedule:@selector(CreateNumber:) interval:0.1 repeat:amount delay:0.5];
}

-(void)CreateNumber :(CCTime)dt{
    
    
    
    Sphere *spear = [SpearMainArray objectAtIndex:increasenum];
    
    CCSprite *tempSprite = [CCSprite spriteWithSpriteFrame:[CCSpriteFrame frameWithImageNamed:[spear Spritename]]];
    CCLabelTTF *tempo = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%@",[spear Number]] fontName:Fonthelvetica fontSize:Ipadfontsize];
    
    tempo.name =[spear Number];
    [MainCompareArray addObject:tempo];
    
    

    [tempSprite addChild:tempo];
    tempo.position=ccp(tempSprite.contentSize.width/2, tempSprite.contentSize.height/2);
    
    tempSprite.position = ccp((self.contentSize.width/2)+(increasenum*2),(self.contentSize.height/2)+(increasenum*15));
    
    tempSprite.physicsBody = [CCPhysicsBody bodyWithCircleOfRadius:tempSprite.contentSize.width/2 andCenter:tempSprite.anchorPointInPoints];
    
    tempSprite.physicsBody.friction = SphereFriction;
    tempSprite.physicsBody.elasticity = SphereElasticity;
    
 
    tempSprite.physicsBody.collisionCategories = @[NewtonSphereCollisionSphere];
    tempSprite.physicsBody.collisionMask = @[NewtonSphereCollisionSphere, NewtonSphereCollisionOutline];
    
    //[self addChild:tempSprite];
    [_physicsWorld addChild:tempSprite];
    
    increasenum++;

    
}


-(void)SmallerOrBier :(BOOL)chose{
    
    CCLabelTTF *showHint;
    
    if (chose) {
        showHint = [CCLabelTTF labelWithString:@"Smaller To Bigger" fontName:Fonthelvetica fontSize:(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)? Ipadfontsize : IphoneFontSize];
    } else{
        showHint = [CCLabelTTF labelWithString:@"Bigger To Smaller" fontName:Fonthelvetica fontSize:(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)? Ipadfontsize : IphoneFontSize];
    }
    
    showHint.positionType = CCPositionTypeNormalized;
    showHint.shadowOffset=ccp(0.0, -5.0);
    showHint.shadowOffsetType = CCPositionTypeMake(0.1, 0.8, 0);
    showHint.shadowColor=[CCColor blackColor];
    showHint.shadowBlurRadius=1.1;
    
    showHint.position=ccp(0.5 ,0.9);
    [self addChild:showHint];
    
    id scaleup = [CCActionEaseBounceOut actionWithAction:[CCActionScaleTo actionWithDuration:1 scale:1]];
    id delay = [CCActionDelay actionWithDuration:10];
    id vanish = [CCActionEaseBounceIn actionWithAction:[CCActionFadeOut actionWithDuration:2]];
    id remove = [CCActionRemove action];
    
    [showHint runAction:[CCActionSequence actionWithArray:@[scaleup,delay,vanish,remove]]];
}



-(void)UniqueNumberenerator :(int)Range{
    StoredForSort = [[NSMutableArray alloc]init];

    
    int randomm;
    int checker[Range];
    
    for(int i = 0 ; i < Range ; i++)
    {
        checker[i] = 0;
    }
    for(int i = 0 ; i < Range ; i++)
        
    {
        randomm = arc4random() % Range;
        
        while(checker[randomm] == 1)
            
        {
            randomm = arc4random() % Range;
        }
        checker[randomm] = 1;
        
        NumArray2 [i]=randomm;
        //CCLOG(@"%d",randomm);
        [StoredForSort addObject:[NSString stringWithFormat:@"%d",randomm]];
        
    }
}

-(void)ForSort{
    
    NSArray *sorted = [StoredForSort sortedArrayUsingSelector:@selector(compare:)];
    
    //CCLOG(@"sorted %@",sorted);
    
   str = sorted[0];

    for (int i = 0; i<= sorted.count; i++) {
        
        paisi[i]=[[str stringByReplacingOccurrencesOfString:@"" withString:@""] intValue];
    }
    CCLOG(@"khhgg %@",str);
}

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchLoc = [touch locationInNode:self];
    
    CCLOG(@"The background was touched");
    
    for (CCNode *node in MainCompareArray)
    {
        //CCLOG(@"node.name %@",node.boundingBox.size);
        if (CGRectContainsPoint(node.boundingBox,touchLoc))
        {
            
            if ([node.name isEqualToString:@"0"])
            {
                CCLOG(@"node.name %@",node.name);
                //CCLOG(@"The ");
                
            }
        }
    }
    
    
}

- (void)touchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    // does nothing for now. Does not need to be implemented
}

- (void)touchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    // does nothing for now. Does not need to be implemented
}


-(void)PhysicsWorldLoad{
    
    _physicsWorld = [CCPhysicsNode node];
    _physicsWorld.gravity = Gravity;
    [_physicsWorld setDebugDraw:NO];
    _physicsWorld.collisionDelegate = self;
    [self addChild:_physicsWorld];
}

-(void)drawOutline{
    CGRect worldRect = CGRectMake(0, 0, [CCDirector sharedDirector].viewSize.width, [CCDirector sharedDirector].viewSize.height);
    CCNode *outline = [CCNode node];
    outline.physicsBody = [CCPhysicsBody bodyWithPolylineFromRect:worldRect cornerRadius:0];
    outline.physicsBody.friction = OutlineFriction;
    outline.physicsBody.elasticity = OutlineElasticity;
    outline.physicsBody.collisionCategories = @[NewtonSphereCollisionOutline];
    outline.physicsBody.collisionMask = @[NewtonSphereCollisionSphere, NewtonSphereCollisionRope];
    [_physicsWorld addChild:outline];
    
}



-(void)Background{
    
    CCSprite *_background = [CCSprite spriteWithImageNamed:@"bg.png"];
    _background.positionType = CCPositionTypeNormalized;
    _background.position = ccp(0.5f, 0.5f);
    [self addChild:_background z:-1];
}


@end
