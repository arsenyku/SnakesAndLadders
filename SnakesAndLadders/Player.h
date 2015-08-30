//
//  Player.h
//  SnakesAndLadders
//
//  Created by asu on 2015-08-29.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject
@property (nonatomic, strong, readonly) NSNumber *idNumber;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) int row;
@property (nonatomic, assign) int column;

-(instancetype)initWithId:(NSNumber*)idNumber;
@end


@protocol PlayerPositionDelegate <NSObject>

-(void)player:(Player*)player movedNumberOfPositions:(int)numberOfPositions;
-(void)player:(Player*)player encounteredSnakeAtRow:(int)row andColumn:(int)column withSetback:(int)setbackNumber;
-(void)player:(Player*)player encounteredLadderAtRow:(int)row andColumn:(int)column withForwardBoost:(int)forwardBoostNumber;
-(void)playerHasWon:(Player*)player;

@end