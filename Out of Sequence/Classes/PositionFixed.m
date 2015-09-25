//
//  MyCocos2DClass.m
//  Out of Sequence
//
//  Created by Nur Farazi on 7/19/14.
//  Copyright 2014 nur. All rights reserved.
//

#import "PositionFixed.h"


@implementation PositionFixed{
    
    int NumArray[20];
    
    
}

+ (instancetype)LoadPositionArray
{
    return([[PositionFixed alloc] init]);
}


- (instancetype)init
{
    
    self = [super init];
    if (!self) return(nil);
    
    
    
    
    
    _PositionArray = [[NSMutableArray alloc]init];
    
  
    
    
    [_PositionArray addObject:[NSValue valueWithCGPoint:ccp(0.15, 0.85)]];
    
    [_PositionArray addObject:[NSValue valueWithCGPoint:ccp(0.3833, 0.85)]];
    
    [_PositionArray addObject:[NSValue valueWithCGPoint:ccp(0.6166, 0.85)]];
    
    [_PositionArray addObject:[NSValue valueWithCGPoint:ccp(0.85, 0.85)]];
    
    [_PositionArray addObject:[NSValue valueWithCGPoint:ccp(0.15, 0.675)]];
    
    [_PositionArray addObject:[NSValue valueWithCGPoint:ccp(0.3833, 0.675)]];
    
    [_PositionArray addObject:[NSValue valueWithCGPoint:ccp(0.6166, 0.675)]];
    
    [_PositionArray addObject:[NSValue valueWithCGPoint:ccp(0.85, 0.675)]];
    
    [_PositionArray addObject:[NSValue valueWithCGPoint:ccp(0.15, .5)]];
    
    [_PositionArray addObject:[NSValue valueWithCGPoint:ccp(0.3833, .5)]];
    
    [_PositionArray addObject:[NSValue valueWithCGPoint:ccp(0.6166, .5)]];
    
    [_PositionArray addObject:[NSValue valueWithCGPoint:ccp(0.85, .5)]];
    
    [_PositionArray addObject:[NSValue valueWithCGPoint:ccp(0.15, 0.325)]];
    
    [_PositionArray addObject:[NSValue valueWithCGPoint:ccp(0.3833, 0.325)]];
    
    [_PositionArray addObject:[NSValue valueWithCGPoint:ccp(0.6166, 0.325)]];
    
    [_PositionArray addObject:[NSValue valueWithCGPoint:ccp(0.85, 0.325)]];
    
    [_PositionArray addObject:[NSValue valueWithCGPoint:ccp(0.15, 0.15)]];
    
    [_PositionArray addObject:[NSValue valueWithCGPoint:ccp(0.3833, 0.15)]];
    
    [_PositionArray addObject:[NSValue valueWithCGPoint:ccp(0.6166, 0.15)]];
    
    [_PositionArray addObject:[NSValue valueWithCGPoint:ccp(0.85, 0.15)]];
  
    
    return(self);
}

-(CGPoint) getLocation :(NSInteger)Number{
    
  
    
    CGPoint point = [[_PositionArray objectAtIndex:Number] CGPointValue];
    
    return point;
    
}





@end
