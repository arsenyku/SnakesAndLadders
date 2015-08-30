//
//  Board.m
//  SnakesAndLadders
//
//  Created by asu on 2015-08-29.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import "Board.h"
#import "InputController.h"

@interface Board()
@property (nonatomic, assign, readwrite)int sideLength;
@property (nonatomic, strong)BoardCell* start;
@property (nonatomic, strong)NSDictionary *rows;

@property (nonatomic, strong)NSString *winner;
@end

@implementation Board

#pragma mark - initializers

-(instancetype)init{
    return [self initWithLength:10];
}

-(instancetype)initWithLength:(int)length{
    self = [super init];
    if (self)
    {
        _sideLength = length;
        _winner = nil;
        [self generate];
    }
    return self;
}


#pragma mark - public

-(void)show{
    if (self.winner){
        [self showWinner];
        return;
    }
    
    for (int row = 0; row < self.sideLength; row++)
    {
        for (int column = 0; column < self.sideLength; column++){
            char cellBuffer[7];
            [[self cellAtRow:row andColumn:column].appearance getCString:cellBuffer maxLength:sizeof(cellBuffer) encoding:NSUTF8StringEncoding];
            printf("%s ",cellBuffer);
        }
        printf("\n\n");
    }
}


-(BoardCell*)cellAtRow:(int)rowNumber andColumn:(int)columnNumber{
    NSNumber *row = [NSNumber numberWithInt:rowNumber];
    NSNumber *column = [NSNumber numberWithInt:columnNumber];
    return self.rows[row][column];
}


-(void)drawPlayer1:(Player*)p1 andPlayer2:(Player*)p2 onCell:(BoardCell*)cell{
    int rowNumber = [cell.propertyList[@"row"] intValue];
    if (rowNumber % 2 == 0)
        cell.appearance = [NSString stringWithFormat:@"%@%@%@", p1.idNumber, @">", p2.idNumber];
    else
        cell.appearance = [NSString stringWithFormat:@"%@%@%@", p1.idNumber, @"<", p2.idNumber];
}


-(void)drawPlayer:(Player*)player onCell:(BoardCell*)cell{
    
    int rowNumber = [cell.propertyList[@"row"] intValue];
    if (rowNumber % 2 == 0)
        cell.appearance = [NSString stringWithFormat:@"%@%@%@", @"_", player.idNumber, @">"];
	else
    	cell.appearance = [NSString stringWithFormat:@"%@%@%@", @"<", player.idNumber, @"_"];
}

-(void)removePlayersFromCell:(BoardCell *)cell{
    cell.appearance = @"___";
    
    NSNumber *cellRow = cell.propertyList[@"row"];
    NSNumber *cellColumn = cell.propertyList[@"column"];
    
    if ([cellRow isEqual:@0] && [cellColumn isEqual:@0] )
        cell.appearance = @">>>";
    
    if ([cellRow isEqual:[NSNumber numberWithInt:self.sideLength-1]] && [cellColumn isEqual:[NSNumber numberWithInt:0]])
        cell.appearance = @"!!!";
}

#pragma mark  - private

-(BoardCell*)generateRowInDirection:(Direction)direction{
    return [self generateNumberOfCells:self.sideLength InDirection:direction];
}



-(BoardCell*)generateNumberOfCells:(int)numberOfCells InDirection:(Direction)direction{
    

    BoardCell *previousCell = nil;
    BoardCell *startCell = nil;
    for (int i = 0; i < numberOfCells ; i++){
        BoardCell *newCell = [BoardCell new];
        if (i == 0){
            startCell = newCell;
            previousCell = newCell;
            continue;
        }
        
        [previousCell linkToCell:newCell inDirection:direction];
        previousCell = newCell;
    }
    
    return startCell;

}



-(void)generate{
    NSMutableDictionary *rows = [NSMutableDictionary new];

    for (int rowNumber = 0; rowNumber < self.sideLength; rowNumber++ )
    {
        NSMutableDictionary *row = [NSMutableDictionary new];
        
        BoardCell *rowStart ;
        
		rowStart = [self generateRowInDirection:East];
    
        BoardCell *currentCell = rowStart;
        
        for (int position = 0; position < self.sideLength; position++){
            currentCell.appearance = @"___";
            currentCell.propertyList[ @"row" ] = [NSNumber numberWithInt:rowNumber];
            currentCell.propertyList[ @"column" ] = [NSNumber numberWithInt:position];

            row[ [NSNumber numberWithInt:position] ] = currentCell;
            
            currentCell = [currentCell nextCellInDirection:East];
        }
    
        rows[ [NSNumber numberWithInt:rowNumber] ] = row;
        
        if (rowNumber > 0 ) {
            
            if (rowNumber % 2 == 0){

                BoardCell *previousRowFirstCell = rows[ [NSNumber numberWithInt:rowNumber-1] ][ [NSNumber numberWithInt:0] ];
                BoardCell *firstInRow = row[ [NSNumber numberWithInt:0] ];
                
                [previousRowFirstCell linkToCell:firstInRow inDirection:South];

                
            } else {

                BoardCell *previousRowLastCell = rows[ [NSNumber numberWithInt:rowNumber-1] ][ [NSNumber numberWithInt:self.sideLength-1] ];
                BoardCell *lastInRow = row [ [NSNumber numberWithInt:self.sideLength - 1] ];

                [previousRowLastCell linkToCell:lastInRow inDirection:South];
                
            }
        }
        
        
    }

    self.rows = [rows copy];
    
    [self cellAtRow:0 andColumn:0].appearance = @">>>";
    
    [self cellAtRow:(self.sideLength - 1) andColumn:0].appearance = @"!!!";
    
    
    
}

-(BoardCell*)skipForwardFromCell:(BoardCell*)startCell byNumberOfLinks:(int)numberOfLinks {
	if (numberOfLinks == 0)
        return startCell;

    int row = [(NSNumber*)startCell.propertyList[ @"row" ] intValue];
    Direction forward = (row % 2 == 0) ? East : West;
    BoardCell *nextCell = [startCell nextCellInDirection:forward];
    if (nextCell != nil){
        return [self skipForwardFromCell:nextCell byNumberOfLinks:numberOfLinks-1];
    } else {
        // Hit edge of board.
        BoardCell *southCell = [startCell nextCellInDirection:South];
        forward = (forward == East) ? West : East;
        if (southCell != nil) {
            return [self skipForwardFromCell:southCell byNumberOfLinks:numberOfLinks-1];
        } else {
            // Hit bottom left corner of board
            return nil;
        }
    }
}


-(void)showWinner{
    if (self.winner == nil)
    {
        [self show];
        return;
    }
    
    for (int row = 0; row < self.sideLength; row++)
    {
        if (row == 4){
            int spacesOnEachSide = 18 - (((int)self.winner.length / 2) + 4);
			printf("%*.0i", spacesOnEachSide, 0);
            [InputController showText:[NSString stringWithFormat:@"%@ has won!", self.winner]];
            printf("%*.0i", spacesOnEachSide, 0);
            printf("\n\n");
            continue;
        }
        
        for (int column = 0; column < self.sideLength; column++){
            printf("!!! ");
        }
        printf("\n\n");
    }
}

#pragma mark - <PlayerPositionDelegate>

-(void)player:(Player*)player movedNumberOfPositions:(int)numberOfPositions {
    [InputController showLineWithText:[NSString stringWithFormat:
                                       @"%@ moved %d spaces",
                                       player.name, numberOfPositions]];

}

-(void)player:(Player*)player encounteredSnakeAtRow:(int)row andColumn:(int)column withSetback:(int)setbackNumber{
    
}

-(void)player:(Player*)player encounteredLadderAtRow:(int)row andColumn:(int)column withForwardBoost:(int)forwardBoostNumber{
    
}

-(void)playerHasWon:(Player*)player{
    self.winner = player.name;
}

#pragma mark - class

@end
