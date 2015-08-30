//
//  SnakesAndLaddersCell.m
//  SnakesAndLadders
//
//  Created by asu on 2015-08-30.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import "SnakesAndLaddersCell.h"

@interface SnakesAndLaddersCell()
@property (nonatomic, assign, readwrite) HazardType hazard;
@property (nonatomic, assign, readwrite) unsigned int hazardValue;
@end

@implementation SnakesAndLaddersCell

-(void)setHazard:(HazardType)hazard withValue:(unsigned int)value{
    self.hazard = hazard;
    self.hazardValue = value;
}

@end
