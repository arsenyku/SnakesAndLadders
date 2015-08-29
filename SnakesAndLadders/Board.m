//
//  Board.m
//  SnakesAndLadders
//
//  Created by asu on 2015-08-29.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import "Board.h"

@interface Board()
@property (nonatomic, assign)int sideLength;
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
            [[self cellAtRow:row andColumn:column] getCString:cellBuffer maxLength:sizeof(cellBuffer) encoding:NSUTF8StringEncoding];
            printf("%s ",cellBuffer);
        }
        printf("\n");
    }
}


#pragma mark  - private

-(void)generate{
    NSMutableDictionary *rows = [NSMutableDictionary new];

    for (int rowNumber = 0; rowNumber < self.sideLength; rowNumber++)
    {
        NSMutableDictionary *row = [NSMutableDictionary new];
    
        for (int position = 0; position < self.sideLength; position++){
            row[ [NSNumber numberWithInt:position] ] = [@"_" mutableCopy];
        }
    
        rows[ [NSNumber numberWithInt:rowNumber] ] = row;
        
    }
    
    self.rows = [rows copy];
    
    [[self cellAtRow:0 andColumn:0] setString:@">"];
    
    [[self cellAtRow:(self.sideLength - 1) andColumn:(self.sideLength - 1)] setString:@"!"];
    
    
    
}

-(NSMutableString*)cellAtRow:(int)rowNumber andColumn:(int)columnNumber{
    NSNumber *row = [NSNumber numberWithInt:rowNumber];
    NSNumber *column = [NSNumber numberWithInt:columnNumber];
    return self.rows[row][column];
}


#pragma mark - class

@end
