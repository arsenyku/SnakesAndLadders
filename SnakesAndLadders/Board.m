//
//  Board.m
//  SnakesAndLadders
//
//  Created by asu on 2015-08-29.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import "Board.h"
#import "BoardCell.h"

@interface Board()
@property (nonatomic, assign)int sideLength;
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


#pragma mark  - private

-(BoardCell*)generateRow{
    return [self generateNumberOfCells:self.sideLength InDirection:East];
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
        
        BoardCell *rowStart = [self generateRow];
        BoardCell *currentCell = rowStart;
        
        for (int position = 0; position < self.sideLength; position++){
            currentCell.appearance = @"___";
            row[ [NSNumber numberWithInt:position] ] = currentCell;
            
            currentCell = [currentCell nextCellInDirection:East];
        }
    
        rows[ [NSNumber numberWithInt:rowNumber] ] = row;
        
        if (rowNumber > 0 ) {
            
            if (rowNumber % 2 == 0){

                BoardCell *previousRowFirstCell = [self cellAtRow:rowNumber-1 andColumn:0];
                BoardCell *firstInRow = [self cellAtRow:rowNumber andColumn:0];
                
                [previousRowFirstCell linkToCell:firstInRow inDirection:South];

                
            } else {

                BoardCell *previousRowLastCell = [self cellAtRow:rowNumber-1 andColumn:self.sideLength - 1];
                BoardCell *lastInRow = [self cellAtRow:rowNumber andColumn:self.sideLength - 1];

                [previousRowLastCell linkToCell:lastInRow inDirection:South];
                
            }
        }
        
        
    }

    self.rows = [rows copy];
    
    [self cellAtRow:0 andColumn:0].appearance = @"_>_";
    
    [self cellAtRow:(self.sideLength - 1) andColumn:(self.sideLength - 1)].appearance = @"!!!";
    
    
    
}

-(BoardCell*)cellAtRow:(int)rowNumber andColumn:(int)columnNumber{
    NSNumber *row = [NSNumber numberWithInt:rowNumber];
    NSNumber *column = [NSNumber numberWithInt:columnNumber];
    return self.rows[row][column];
}


#pragma mark - class

@end
