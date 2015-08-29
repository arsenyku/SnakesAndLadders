//
//  Player.h
//  SnakesAndLadders
//
//  Created by asu on 2015-08-29.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) int row;
@property (nonatomic, assign) int column;
@end
