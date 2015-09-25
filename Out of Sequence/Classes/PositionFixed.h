//
//  MyCocos2DClass.h
//  Out of Sequence
//
//  Created by Nur Farazi on 7/19/14.
//  Copyright 2014 nur. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface PositionFixed : CCNode {
    
}

@property(readonly, nonatomic) NSMutableArray *PositionArray;


+ (instancetype)LoadPositionArray ;
- (instancetype)init ;

-(CGPoint) getLocation :(NSInteger)Number;

@end