//
//  MyCocos2DClass.h
//  Out of Sequence
//
//  Created by Nur Farazi on 7/24/14.
//  Copyright 2014 nur. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d-ui.h"
#import "cocos2d.h"

@interface Sphere : CCNode {
    
}

@property(nonatomic,readwrite,retain) NSString *Spritename;
@property(nonatomic,readwrite,retain) NSString *Number;


@property(nonatomic, readwrite) int IdNumber;



@end
