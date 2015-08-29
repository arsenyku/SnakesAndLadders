//
//  Dice.h
//  Threelow
//
//  Created by asu on 2015-08-26.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Dice : NSObject

@property (nonatomic, strong) NSString* name;
@property (nonatomic, assign, readonly) int currentValue;
@property (nonatomic, assign, readonly) int numberOfSides;

-(instancetype)initWithName:(NSString*)name;
-(instancetype)initWithName:(NSString*)name andNumberOfSides:(int)sides;

-(int)roll;


@end
