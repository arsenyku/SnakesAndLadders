//
//  GameController.m
//  SnakesAndLadders
//
//  Created by asu on 2015-08-29.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import "GameController.h"
#import "Board.h"
#import "Dice.h"


@interface GameController()

@property (nonatomic, strong) Player *playerThisTurn;
@property (nonatomic, strong) NSArray *players;
@property (nonatomic, strong) Board *board;
@property (nonatomic, strong) Dice *die;

@end


@implementation GameController

#pragma mark - Initializers

- (instancetype)init
{
    self = [super init];
    if (self) {
        _board = nil ;
        _die = [[Dice alloc] initWithName:@"SnakesAndLadders"];
        _players = @[ [[Player alloc] initWithId:@1], [[Player alloc] initWithId:@2] ];
        _playerPositionDelegate = nil;
        

    }
    return self;
}

#pragma mark - Public

-(void)startNewGameWithPlayer1:(NSString*)player1Name andPlayer2:(NSString*)player2Name andDifficulty:(Difficulty)difficulty{
    
    [self newBoardWithDifficulty:difficulty];
    
    [self setName:player1Name forPlayer:1];
    [self setName:player2Name forPlayer:2];
    
    self.playerThisTurn = self.players[0];
    
    
    
}



-(int)rollAndMoveCurrentPlayer;{
    if (self.winner != nil){
        [self.playerPositionDelegate playerHasWon:self.winner];
        return 0;
    }
    
    int roll = [self.die roll];
    
    [self movePlayerByAmount:roll];
    
    // Change the current player
    self.playerThisTurn = self.players [ [self.playerThisTurn.idNumber isEqual:@1] ? 1 : 0 ];
    
    return roll;
}


-(void)showState{
    [self.board show];
}


-(Player*)winner{
    for (Player* player in self.players) {
        if (player.row == self.board.sideLength-1 && player.column == 0 )
            return player;
    }
    return nil;
}



#pragma mark - Private

-(void)newBoardWithDifficulty:(Difficulty)difficulty{
    int ladderCount = 8;
    int snakeCount = 8;
    switch (difficulty) {
        case Easy:
            snakeCount = 4;
            ladderCount = 12;
            break;
            
        case Hard:
            snakeCount = 12;
            ladderCount = 4;
            break;
            
        case Empty:
            snakeCount = 0;
            ladderCount = 0;
            break;
            
        default:
            break;
    }

    self.board = [[Board alloc] initWithLength:10 snakeCount:snakeCount ladderCount:ladderCount];
    self.playerPositionDelegate = self.board;
}

-(void)setName:(NSString*)name forPlayer:(int)player{
    ((Player*)(self.players[player - 1])).name = name;
}

-(void)movePlayerByAmount:(int)numberOfCells{
    BoardCell *originCell = [self.board cellAtRow:self.playerThisTurn.row andColumn:self.playerThisTurn.column];
    SnakesAndLaddersCell *destinationCell;
    
    if (numberOfCells >= 0)
		destinationCell = (SnakesAndLaddersCell*)[self.board skipForwardFromCell:originCell byNumberOfLinks:numberOfCells];
    else
        destinationCell = (SnakesAndLaddersCell*)[self.board skipBackwardFromCell:originCell byNumberOfLinks:abs(numberOfCells)];

    if (destinationCell == nil){
        destinationCell = (SnakesAndLaddersCell*)[self.board cellAtRow:self.board.sideLength-1 andColumn:0];
        self.playerThisTurn.row = [(NSNumber*)destinationCell.propertyList[ @"row" ] intValue];
        self.playerThisTurn.column = [(NSNumber*)destinationCell.propertyList[ @"column" ] intValue];
        
    } else {
    	self.playerThisTurn.row = [(NSNumber*)destinationCell.propertyList[ @"row" ] intValue];
    	self.playerThisTurn.column = [(NSNumber*)destinationCell.propertyList[ @"column" ] intValue];
    }
    
    [self.board removePlayersFromCell:originCell];
    [self drawPlayersOnBoard];
    
    [self.playerPositionDelegate player:self.playerThisTurn movedNumberOfPositions:numberOfCells];
    
    if (self.winner != nil){
        [self.playerPositionDelegate playerHasWon:self.winner];
        return;
    }

    if (destinationCell.hazard == Snake){
        [self.playerPositionDelegate player:self.playerThisTurn
                      encounteredSnakeAtRow:self.playerThisTurn.row
                                  andColumn:self.playerThisTurn.column
                                withSetback:destinationCell.hazardValue];
        
        [self movePlayerByAmount:-destinationCell.hazardValue];
        
    } else if (destinationCell.hazard == Ladder){
        [self.playerPositionDelegate player:self.playerThisTurn
                     encounteredLadderAtRow:self.playerThisTurn.row
                                  andColumn:self.playerThisTurn.column
                           withForwardBoost:destinationCell.hazardValue];
        
        [self movePlayerByAmount:destinationCell.hazardValue];

    }
    
}

-(void)drawPlayersOnBoard{
    
    Player *p1 = self.players[0];
    Player *p2 = self.players[1];
    
    BoardCell *cellForP1 = [self.board cellAtRow:p1.row andColumn:p1.column];
    BoardCell *cellForP2 = [self.board cellAtRow:p2.row andColumn:p2.column];
    
    if (cellForP1 == cellForP2){
        [self.board drawPlayer1:p1 andPlayer2:p2 onCell:cellForP1];
    } else {
        [self.board drawPlayer:p1 onCell:cellForP1];
        [self.board drawPlayer:p2 onCell:cellForP2];
    }
    
}


#pragma mark - Class



@end
