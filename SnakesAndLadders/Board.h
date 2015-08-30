//
//  Board.h
//  SnakesAndLadders
//
//  Created by asu on 2015-08-29.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SnakesAndLaddersCell.h"
#import "Player.h"

@interface Board : NSObject <PlayerPositionDelegate>

@property (nonatomic, assign, readonly)int sideLength;

-(instancetype)initWithLength:(int)length snakeCount:(int)numberOfSnakes ladderCount:(int)numberOfLadders;

-(BoardCell*)cellAtRow:(int)rowNumber andColumn:(int)columnNumber;
-(BoardCell*)skipForwardFromCell:(BoardCell*)startCell byNumberOfLinks:(int)numberOfLinks;
-(BoardCell*)skipBackwardFromCell:(BoardCell*)startCell byNumberOfLinks:(unsigned int)numberOfLinks ;


-(void)show;
-(void)drawPlayer1:(Player*)p1 andPlayer2:(Player*)p2 onCell:(BoardCell*)cell;
-(void)drawPlayer:(Player*)player onCell:(BoardCell*)cell;
-(void)removePlayersFromCell:(BoardCell*)cell;

@end
