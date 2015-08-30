//
//  BoardCell.m
//  SnakesAndLadders
//
//  Created by asu on 2015-08-29.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import "BoardCell.h"

@interface BoardCell()
@property (strong, nonatomic, readwrite) BoardCell *northCell;
@property (strong, nonatomic, readwrite) BoardCell *southCell;
@property (strong, nonatomic, readwrite) BoardCell *eastCell;
@property (strong, nonatomic, readwrite) BoardCell *westCell;
@property (strong, nonatomic, readwrite) BoardCell *northEastCell;
@property (strong, nonatomic, readwrite) BoardCell *southEastCell;
@property (strong, nonatomic, readwrite) BoardCell *southWestCell;
@property (strong, nonatomic, readwrite) BoardCell *northWestCell;

@end

@implementation BoardCell


-(instancetype) init{
    return [self initWithNextCell:nil];
}


-(instancetype)initWithNextCell:(BoardCell*)nextCell{
    return [self initWithNorthCell:nil
                         southCell:nil
                          eastCell:nextCell
                          westCell:nil
                     northEastCell:nil
                     southEastCell:nil
                     southWestCell:nil
                     northWestCell:nil];
}

-(instancetype)initWithNorthCell:(BoardCell*)north
                       southCell:(BoardCell*)south
                        eastCell:(BoardCell*)east
                        westCell:(BoardCell*)west
                   northEastCell:(BoardCell*)northEast
                   southEastCell:(BoardCell*)southEast
                   southWestCell:(BoardCell*)southWest
                   northWestCell:(BoardCell*)northWest{
    
    self = [super init];
    
    if (self){
        _appearance = @"";
        _propertyList = [NSMutableDictionary new];
        
        _northCell = nil;
        _southCell = nil;
        _eastCell = nil;
        _westCell = nil;
        _northEastCell = nil;
        _southEastCell = nil;
        _southWestCell = nil;
        _northWestCell = nil;

        [self linkToCell:north inDirection:North];
        [self linkToCell:south inDirection:South];
        [self linkToCell:east inDirection:East];
        [self linkToCell:west inDirection:West];
        [self linkToCell:northEast inDirection:NorthEast];
        [self linkToCell:southEast inDirection:SouthEast];
        [self linkToCell:southWest inDirection:SouthWest];
        [self linkToCell:northWest inDirection:NorthWest];
    }
    return self;
    
}

-(void)linkToCell:(BoardCell *)otherCell inDirection:(Direction)direction{
    switch (direction) {
        case North:
            self.northCell = otherCell;
            if (otherCell.southCell != self)
                [otherCell linkToCell:self inDirection:South];
            break;
            
        case South:
            self.southCell = otherCell;
            if (otherCell.northCell != self)
                [otherCell linkToCell:self inDirection:North];
            break;
            
        case East:
            self.eastCell = otherCell;
            if (otherCell.westCell != self)
                [otherCell linkToCell:self inDirection:West];
            break;
            
        case West:
            self.westCell = otherCell;
            if (otherCell.eastCell != self)
                [otherCell linkToCell:self inDirection:East];
            break;
            
        case NorthEast:
            self.northEastCell = otherCell;
            if (otherCell.southWestCell != self)
                [otherCell linkToCell:self inDirection:SouthWest];
            break;
            
        case SouthEast:
            self.southEastCell = otherCell;
            if (otherCell.northWestCell != self)
                [otherCell linkToCell:self inDirection:NorthWest];
            break;
            
        case SouthWest:
            self.southWestCell = otherCell;
            if (otherCell.northEastCell != self)
                [otherCell linkToCell:self inDirection:NorthEast];
            break;
            
        case NorthWest:
            self.northWestCell = otherCell;
            if (otherCell.southWestCell != self)
                [otherCell linkToCell:self inDirection:SouthWest];
            break;
            
		default:
            break;
    }
}

-(BoardCell *)nextCellInDirection:(Direction)direction{
    switch (direction) {
        case North:
        default:
            return self.northCell;
            break;
            
        case South:
            return self.southCell;
            break;
            
        case East:
            return self.eastCell;
            break;
            
        case West:
            return self.westCell;
            break;
            
        case NorthEast:
            return self.northEastCell;
            break;
            
        case SouthEast:
            return self.southEastCell;
            break;
            
        case SouthWest:
            return self.southWestCell;
            break;
            
        case NorthWest:
            return self.northWestCell;
            break;
            
    }
}

-(BoardCell *)skipToCellNumberOfLinks:(int)numberOfLinks inDirection:(Direction)direction{
    BoardCell* result = self;
    for(int i = 0; i < numberOfLinks; i++){
        result = [result nextCellInDirection:direction];
        
        if (result == nil)
            return result;
    }
    
    return result;
}
@end








