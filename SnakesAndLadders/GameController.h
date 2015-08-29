//
//  GameController.h
//  SnakesAndLadders
//
//  Created by asu on 2015-08-29.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"

@interface GameController : NSObject
@property (nonatomic, strong, readonly) Player *playerThisTurn;

-(void)startNewGameWithPlayer1:(NSString*)player1Name andPlayer2:(NSString*)player2Name;
-(void)rollForCurrentPlayer;


-(void)showState;
-(void)showBoard;
@end
