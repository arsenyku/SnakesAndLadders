//
//  Player.m
//  SnakesAndLadders
//
//  Created by asu on 2015-08-29.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import "Player.h"

@implementation Player
- (instancetype)init{
    return [self initWithId:0];
}

- (instancetype)initWithId:(NSNumber*)number
{
    self = [super init];
    if (self) {
        _idNumber = number;
        _name = @"";
        _row = 0;
        _column = 0;
    }
    return self;
}
@end
