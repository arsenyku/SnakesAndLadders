//
//  Board.h
//  SnakesAndLadders
//
//  Created by asu on 2015-08-29.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BoardCell.h"

@interface Board : NSObject

@property (nonatomic, assign, readonly)int sideLength;

-(BoardCell*)cellAtRow:(int)rowNumber andColumn:(int)columnNumber;
-(BoardCell*)skipForwardFromCell:(BoardCell*)startCell byNumberOfLinks:(int)numberOfLinks;

-(void)show;

@end
