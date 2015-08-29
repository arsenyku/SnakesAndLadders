//
//  InputCollector.h
//  ContactList
//
//  Created by asu on 2015-08-25.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InputController : NSObject

-(NSString *)inputForPrompt:(NSString *)promptString;
-(NSString *)inputForPrompt:(NSString *)promptString andStoreInHistory:(BOOL)storeInHistory;
-(NSArray*)retrieveLastCommands:(NSNumber*)numberOfCommands;

+(void)showText:(NSString *)text;
+(void)showLineWithText:(NSString *)text;

@end
