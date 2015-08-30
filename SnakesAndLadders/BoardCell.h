//
//  BoardCell.h
//  SnakesAndLadders
//
//  Created by asu on 2015-08-29.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, Direction) {
    North,
    South,
    East,
    West,
    NorthEast,
    SouthEast,
    SouthWest,
    NorthWest
};

@interface BoardCell : NSObject

@property (strong, nonatomic) id appearance;
@property (strong, nonatomic, readonly) NSMutableDictionary* propertyList;

@property (strong, nonatomic, readonly) BoardCell *northCell;
@property (strong, nonatomic, readonly) BoardCell *southCell;
@property (strong, nonatomic, readonly) BoardCell *eastCell;
@property (strong, nonatomic, readonly) BoardCell *westCell;
@property (strong, nonatomic, readonly) BoardCell *northEastCell;
@property (strong, nonatomic, readonly) BoardCell *southEastCell;
@property (strong, nonatomic, readonly) BoardCell *southWestCell;
@property (strong, nonatomic, readonly) BoardCell *northWestCell;

-(instancetype)initWithNextCell:(BoardCell*)nextCell;

-(instancetype)initWithNorthCell:(BoardCell*)north
                       southCell:(BoardCell*)south
                       eastCell:(BoardCell*)east
                       westCell:(BoardCell*)west
                   northEastCell:(BoardCell*)northEast
                   southEastCell:(BoardCell*)southEast
                   southWestCell:(BoardCell*)southWest
                   northWestCell:(BoardCell*)northWest;

-(void)linkToCell:(BoardCell*)otherCell inDirection:(Direction)direction;

-(BoardCell*)nextCellInDirection:(Direction)direction;

-(BoardCell*)skipToCellNumberOfLinks:(int)numberOfLinks inDirection:(Direction)direction;

@end
