//
//  Board.m
//  SnakesAndLadders
//
//  Created by asu on 2015-08-29.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import "Board.h"

@interface Board()
@property (nonatomic, assign, readwrite)int sideLength;
@property (nonatomic, strong)BoardCell* start;
@property (nonatomic, strong)NSDictionary *rows;
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
        [self generate];
    }
    return self;
}


#pragma mark - public

-(void)show{
    for (int row = 0; row < self.sideLength; row++)
    {
        for (int column = 0; column < self.sideLength; column++){
            char cellBuffer[7];
            [[self cellAtRow:row andColumn:column].appearance getCString:cellBuffer maxLength:sizeof(cellBuffer) encoding:NSUTF8StringEncoding];
            printf("%s ",cellBuffer);
        }
        printf("\n");
    }
}


-(BoardCell*)cellAtRow:(int)rowNumber andColumn:(int)columnNumber{
    NSNumber *row = [NSNumber numberWithInt:rowNumber];
    NSNumber *column = [NSNumber numberWithInt:columnNumber];
    return self.rows[row][column];
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
                BoardCell *firstInRow = row[ [NSNumber numberWithInt:0] ];   // [self cellAtRow:rowNumber andColumn:0];
                
                [previousRowFirstCell linkToCell:firstInRow inDirection:South];

                
            } else {

                BoardCell *previousRowLastCell = rows[ [NSNumber numberWithInt:rowNumber-1] ][ [NSNumber numberWithInt:self.sideLength-1] ];
                BoardCell *lastInRow = row [ [NSNumber numberWithInt:self.sideLength - 1] ];

                [previousRowLastCell linkToCell:lastInRow inDirection:South];
                
            }
        }
        
        
    }

    self.rows = [rows copy];
    
    [self cellAtRow:0 andColumn:0].appearance = @"_>_";
    
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




#pragma mark - class

@end
