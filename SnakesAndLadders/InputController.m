//
//  InputCollector.m
//  ContactList
//
//  Created by asu on 2015-08-25.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import "InputController.h"

@interface InputController()

@property (nonatomic, strong) NSMutableArray* history;

@end

@implementation InputController

-(instancetype)init{
    self = [super init];
    _history = [[NSMutableArray alloc] init];
    return self;
}

// getInput
// Issue a prompt to the user and return the typed input
//
- (NSString*) getInput:(NSString*)prompt{
    // 255 unit long array of characters
    char inputChars[255];
    [InputController showText:prompt];

    // limit input to max 255 characters
    fgets(inputChars, 255, stdin);
    
    // convert char array to an NSString object
    NSString *inputString = [NSString stringWithUTF8String:inputChars] ;
    
    // remove newline
    inputString = [inputString substringToIndex:[inputString length] - 1 ];
    
    return inputString;
}

// inputForPrompt
// This method will take in a single string parameter promptString,
// and return whatever text the user inputs after that prompt.
//
-(NSString *)inputForPrompt:(NSString *)promptString{
    return [self inputForPrompt:promptString andStoreInHistory:NO];
}

// inputForPrompt:andStoreInHistory:
// This method will take in a single string parameter promptString,
// and return whatever text the user inputs after that prompt.
//
-(NSString *)inputForPrompt:(NSString *)promptString andStoreInHistory:(BOOL)storeInHistory{
    NSString* result = [self getInput:promptString];

    if (storeInHistory){
        [self addToHistory:result];
    }
    
    return result;
}

// addToHistory
// Add the command to the history
//
-(void)addToHistory:(NSString*)command{
    [self.history addObject:command];
}

// RetrieveLastCommands
// Return the specified number of commands from the history
//
-(NSArray*)retrieveLastCommands:(NSNumber*)numberOfCommands{
    long n = [numberOfCommands intValue];
    
    // empty history, so return empty result
	if ([self.history count] < 1){
        return [[NSArray alloc] init];
    }
    
    // retrieving more commands than there are commands
    // so just return the commands that are there
    if (n > [self.history count]){
        n = [self.history count];
    }

    NSRange targetRange;
    targetRange.length = n;
    targetRange.location = [self.history count] - n;
    
    
    return [self.history subarrayWithRange:targetRange];
}

#pragma mark - Class methods

+(void)showText:(NSString *)text{
    char output[[text length] + 1];
    [text getCString:output maxLength:sizeof(output) encoding:NSUTF8StringEncoding];
    printf("%s", output);
}

+(void)showLineWithText:(NSString *)text{
    [InputController showText:text];
    printf("\n");
}

@end
