//
//  GameController.h
//  SnakesAndLadders
//
//  Created by asu on 2015-08-29.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"


@protocol PlayerPositionDelegate <NSObject>

-(void)player:(Player*)player movedNumberOfPositions:(int)numberOfPositions toRow:(int)newPositionRow andColumn:(int)newPositionColumn;
-(void)player:(Player*)player encounteredSnakeAtRow:(int)row andColumn:(int)column withSetback:(int)setbackNumber;
-(void)player:(Player*)player encounteredLadderAtRow:(int)row andColumn:(int)column withForwardBoost:(int)forwardBoostNumber;
-(void)playerHasWon:(Player*)player;

@end

@interface GameController : NSObject

@property (nonatomic, strong, readonly) Player *playerThisTurn;
@property (nonatomic, strong) id<PlayerPositionDelegate> playerPositionDelegate;

-(void)startNewGameWithPlayer1:(NSString*)player1Name andPlayer2:(NSString*)player2Name;
-(int)rollAndMoveCurrentPlayer;

-(void)showState;
-(void)showBoard;
@end

