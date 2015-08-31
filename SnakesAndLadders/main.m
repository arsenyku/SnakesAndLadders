//
//  main.m
//  SnakesAndLadders
//
//  Created by asu on 2015-08-29.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameController.h"
#import "InputController.h"

static NSString* const RollCommand = @"roll";
static NSString* const NewGameCommand = @"new";
static NSString* const QuitCommand = @"quit";

void showGameMenu(){
    [InputController showLineWithText:@"Set the difficulty level: easy medium hard"];
    [InputController showLineWithText:@"Press <enter> for default (medium)"];
    [InputController showText:@"Start? "];
}

void showTurnMenu(NSString *playerName){
    NSString *outputFormat = \
        @"Player %@ move: \n" \
    	@"Press <enter> to roll \n" \
    	@"Type %@ to start a new game \n" \
    	@"Type %@ to end game.";
    
    NSString *text = [NSString stringWithFormat:outputFormat, \
    	playerName,
        NewGameCommand,
        QuitCommand ];
    
    [InputController showLineWithText:text];
    
    
}

NSString* collectInput(InputController *inputController){
    NSString *input = [inputController inputForPrompt:@"> "];
    input = [input stringByTrimmingCharactersInSet:
             [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return input;
}

Difficulty getDifficultyFromText(NSString* input){
    if ([input isEqualToString: @"easy"])
        return Easy;
    
    if ([input isEqualToString: @"hard"])
        return Hard;
    
    if ([input isEqualToString: @"empty"])
        return Empty;
    
    return Medium;

}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        InputController* inputController = [InputController new];
        GameController* game = [GameController new];
        
        BOOL stayInGameLoop = YES;
        BOOL stayInTurnLoop = YES;
        NSString *input = @"";
        
        while (stayInGameLoop){
            
            showGameMenu();
            input = collectInput(inputController);
            
            Difficulty difficulty = getDifficultyFromText([input lowercaseString]);
            
            [InputController showLineWithText:@"Enter Player 1's name:"];
            NSString *p1Name = collectInput(inputController);

            [InputController showLineWithText:@"Enter Player 2's name:"];
            NSString *p2Name = collectInput(inputController);
            
            [game startNewGameWithPlayer1:p1Name andPlayer2:p2Name andDifficulty:difficulty];
            
            stayInTurnLoop = YES;
            
            
            while (stayInTurnLoop){
                
                [game showState];
                
                showTurnMenu([game playerThisTurn].name);
                input = collectInput(inputController);
                
                
                if ([input hasPrefix:QuitCommand]) {
                    [InputController showLineWithText:  @"Exiting. Thanks for playing."] ;
                    stayInTurnLoop = NO;
                    stayInGameLoop = NO;
                    break;
                    
                } else if ([input hasPrefix:NewGameCommand]){
                    game = [GameController new];
                    stayInTurnLoop = NO;
                    continue;
                
                } else {
                    // ROLL!
                    
                    [game rollAndMoveCurrentPlayer];
                }
                
            }

            
//            if ( [gameController gameIsOver]){
//                printline( [NSString stringWithFormat:@"GAME OVER!  Your score is: %d", gameController.score] );
//                previousGameController = gameController;
//                gameController = [GameController new];
//            }
            
        }
    }
    return 0;
}

