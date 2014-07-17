//
//  EnvironmentModel.m
//  InspirationBasic
//
//  Created by Timothy Swan on 5/28/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import "EnvironmentModel.h"

@implementation EnvironmentModel

-(id) initWithOutputListener:(id<OutputListener>)listener {
    if (self = [super init]) {
        self.dictionary = [[NSMutableDictionary alloc] init];
        self.arrayDictionary = [[NSMutableDictionary alloc] init];
        self.exception = nil;
        self.listener = listener;
    }
    return self;
}

-(void)printLine: (NSString *)string {
    if (self.listener != nil) // For unit testing
        [self.listener postOutput:[string stringByAppendingString:@"\n"]];
}

-(NSString *)arraySyntaxFor: (NSString *)variable atIndex:(int)index {
    NSString * syntax = variable;
    syntax = [syntax stringByAppendingString:@"["];
    syntax = [syntax stringByAppendingString:[[NSNumber numberWithInt:index] stringValue]];
    syntax = [syntax stringByAppendingString:@"]"];
    return syntax;
}

-(void)setValue: (Value*)value For: (NSString *)variableName {
    [self.dictionary setValue:value forKey:variableName];
}

-(void)setValue: (Value*)value For: (NSString *)variableName atIndex: (int) index {
    NSMutableArray * array = [self.arrayDictionary objectForKey:variableName];
    if (array == nil) {
        array = [[NSMutableArray alloc] init];
        [self.arrayDictionary setObject:array forKey:variableName];
    }
    if (index < 0) {
        NSString * message = @"Element ";
        message = [message stringByAppendingString:[self arraySyntaxFor:variableName atIndex:index]];
        message = [message stringByAppendingString:@" does not exist because the index is negative."];
        self.exception = [[ProgramException alloc] initWithMessage:message];
    } else {
        if (array.count <= index)
            while (array.count <= index)
                [array addObject:value];
        else
            array[index] = value;
    }
}

- (Value*)getValueFor: (NSString *)variableName {
    Value * value = [self.dictionary objectForKey:variableName];
    if (value == nil) {
        NSString * message = @"Variable \"";
        message = [message stringByAppendingString:variableName];
        message = [message stringByAppendingString:@"\" does not exist."];
        self.exception = [[ProgramException alloc] initWithMessage:message];
        return nil;
    }
    return value;
}

- (Value*)getValueFor: (NSString *)variableName atIndex:(int) index {
    NSMutableArray * array = [self.arrayDictionary objectForKey:variableName];
    if (array == nil) {
        NSString * message = @"Element ";
        message = [message stringByAppendingString:[self arraySyntaxFor:variableName atIndex:index]];
        message = [message stringByAppendingString:@" does not exist because the array \""];
        message = [message stringByAppendingString:variableName];
        message = [message stringByAppendingString:@"[]\" does not exist."];
        self.exception = [[ProgramException alloc] initWithMessage:message];
        return nil;
    }
    if (index < 0 || array.count <= index) {
        NSString * message = @"Element ";
        message = [message stringByAppendingString:[self arraySyntaxFor:variableName atIndex:index]];
        message = [message stringByAppendingString:@" does not exist. The size of \""];
        message = [message stringByAppendingString:variableName];
        message = [message stringByAppendingString:@"[]\" is "];
        message = [message stringByAppendingString:[[NSNumber numberWithInt:array.count] stringValue]];
        message = [message stringByAppendingString:@", thus only values at some index ranged 0 to "];
        message = [message stringByAppendingString:[[NSNumber numberWithInt:array.count - 1] stringValue]];
        message = [message stringByAppendingString:@"may be evaluated."];
        self.exception = [[ProgramException alloc] initWithMessage:message];
        return nil;
    } else
        return array[index];
}

@end
