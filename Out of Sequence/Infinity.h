//
//  Compare.h
//  Out of Sequence
//
//  Created by Nur Farazi on 6/17/14.
//  Copyright 2014 nur. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "cocos2d-ui.h"
#import "CCParticleSystem.h"
#import "GameMechanics.h"
#import "GamePlay.h"

#import "GameOverLayer.h"
#import "appID.h"


@interface Infinity : CCScene <CCPhysicsCollisionDelegate>{
    
       
}

+ (Infinity *)scene ;
- (id)init;
-(void)SmallerOrBier :(BOOL)chose;

@end
