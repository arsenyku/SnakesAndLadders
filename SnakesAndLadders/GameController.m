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
@property (nonatomic, strong, readwrite) Player *playerThisTurn;


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
        _board = [Board new];
        _die = [[Dice alloc] initWithName:@"SnakesAndLadders"];
        _players = @[ [Player new], [Player new] ];
        _playerThisTurn = _players[0];
    }
    return self;
}

#pragma mark - Public

-(void)startNewGameWithPlayer1:(NSString*)player1Name andPlayer2:(NSString*)player2Name{
 
    [self setName:player1Name forPlayer:1];
    [self setName:player2Name forPlayer:2];
    
    self.playerThisTurn = self.players[0];
    
    
    
}

-(int)rollAndMoveCurrentPlayer;{
    int roll = [self.die roll];
    
    [self movePlayerByAmount:1];
    
    return roll;
}


-(void)showState{
    [self.board show];
}

-(void)showBoard{
    [self.board show];
}






#pragma mark - Private

-(void)setName:(NSString*)name forPlayer:(int)player{
    ((Player*)(self.players[player - 1])).name = name;
}

-(void)movePlayerByAmount:(int)numberOfCells{
    BoardCell *originCell = [self.board cellAtRow:self.playerThisTurn.row andColumn:self.playerThisTurn.column];
    BoardCell *destinationCell = [self.board skipForwardFromCell:originCell byNumberOfLinks:numberOfCells]; 

    if (destinationCell == nil){
        destinationCell = [self.board cellAtRow:self.board.sideLength-1 andColumn:0];
        self.playerThisTurn.row = [(NSNumber*)destinationCell.propertyList[ @"row" ] intValue];
        self.playerThisTurn.column = [(NSNumber*)destinationCell.propertyList[ @"column" ] intValue];
        
    } else {
    	self.playerThisTurn.row = [(NSNumber*)destinationCell.propertyList[ @"row" ] intValue];
    	self.playerThisTurn.column = [(NSNumber*)destinationCell.propertyList[ @"column" ] intValue];
    }
    
    originCell.appearance = @"___";
    destinationCell.appearance = @"_>_";
}


#pragma mark - Class



@end
