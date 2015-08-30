//
//  SnakesAndLaddersCell.h
//  SnakesAndLadders
//
//  Created by asu on 2015-08-30.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import "BoardCell.h"

typedef NS_ENUM(NSInteger, HazardType) {
    NoHazard,
    Snake,
    Ladder
};

@interface SnakesAndLaddersCell : BoardCell
@property (nonatomic, assign, readonly) HazardType hazard;
@property (nonatomic, assign, readonly) unsigned int hazardValue;

-(void)setHazard:(HazardType)hazard withValue:(unsigned int)value;
@end
