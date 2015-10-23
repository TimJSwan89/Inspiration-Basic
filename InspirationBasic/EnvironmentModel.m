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
        self.intDictionary = [[NSMutableDictionary alloc] init];
        self.boolDictionary = [[NSMutableDictionary alloc] init];
        self.intArrayDictionary = [[NSMutableDictionary alloc] init];
        self.boolArrayDictionary = [[NSMutableDictionary alloc] init];
        
        
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

-(void)setInt: (int)value For: (NSString *)variableName {
    @autoreleasepool {
        [self.intDictionary setValue:@(value) forKey:variableName];
    }
}

-(void)setBool: (bool)value For: (NSString *)variableName {
    @autoreleasepool {
        [self.boolDictionary setValue:@(value) forKey:variableName];
    }
}

//-(void)setInt: (int)value For: (NSString *)variableName {
//    Value * oldValue;
//    oldValue = (Value *) [self.intDictionary objectForKey:variableName];
//    if (oldValue == nil) {
//        oldValue = [[Value alloc] init];
//        oldValue.integer = value;
//        [self.intDictionary setValue:oldValue forKey:variableName];
//    } else
//        oldValue.integer = value;
//}
//
//-(void)setBool: (bool)value For: (NSString *)variableName {
//    Value * oldValue;
//    oldValue = (Value *) [self.boolDictionary objectForKey:variableName];
//    if (oldValue == nil) {
//        oldValue = [[Value alloc] init];
//        oldValue.boolean = value;
//        [self.boolDictionary setValue:oldValue forKey:variableName];
//    } else
//        oldValue.boolean = value;
//}

-(void)setInt: (int)value For: (NSString *)variableName atIndex: (int) index {
    @autoreleasepool {
        NSMutableArray * array = [self.intArrayDictionary objectForKey:variableName];
        if (array == nil) {
            array = [[NSMutableArray alloc] init];
            [self.intArrayDictionary setObject:array forKey:variableName];
        }
        if (index < 0) {
            NSString * message = @"Element ";
            message = [message stringByAppendingString:[self arraySyntaxFor:variableName atIndex:index]];
            message = [message stringByAppendingString:@" cannot not exist because the index is negative."];
            self.exception = [[ProgramException alloc] initWithMessage:message];
        } else {
            if (array.count <= index)
                while (array.count <= index)
                    [array addObject:@(value)];
            else
                array[index] = @(value);
        }
    }
}

-(void)setBool: (bool)value For: (NSString *)variableName atIndex: (int) index {
    @autoreleasepool {
        NSMutableArray * array = [self.boolArrayDictionary objectForKey:variableName];
        if (array == nil) {
            array = [[NSMutableArray alloc] init];
            [self.boolArrayDictionary setObject:array forKey:variableName];
        }
        if (index < 0) {
            NSString * message = @"Element ";
            message = [message stringByAppendingString:[self arraySyntaxFor:variableName atIndex:index]];
            message = [message stringByAppendingString:@" cannot not exist because the index is negative."];
            self.exception = [[ProgramException alloc] initWithMessage:message];
        } else {
            if (array.count <= index)
                while (array.count <= index)
                    [array addObject:@(value)];
            else
                array[index] = @(value);
        }
    }
}

- (int)getIntFor: (NSString *)variableName {
    NSNumber * value = [self.intDictionary objectForKey:variableName];
    if (value == nil) {
        NSString * message = @"Variable \"";
        message = [message stringByAppendingString:variableName];
        message = [message stringByAppendingString:@"\" does not exist."];
        self.exception = [[ProgramException alloc] initWithMessage:message];
        return 0;
    }
    return [value intValue];
}

- (bool)getBoolFor: (NSString *)variableName {
    NSNumber * value = [self.boolDictionary objectForKey:variableName];
    if (value == nil) {
        NSString * message = @"Variable \"";
        message = [message stringByAppendingString:variableName];
        message = [message stringByAppendingString:@"\" does not exist."];
        self.exception = [[ProgramException alloc] initWithMessage:message];
        return false;
    }
    return [value boolValue];
}

//- (int)getIntFor: (NSString *)variableName {
//    Value * value = [self.intDictionary objectForKey:variableName];
//    if (value == nil) {
//        NSString * message = @"Variable \"";
//        message = [message stringByAppendingString:variableName];
//        message = [message stringByAppendingString:@"\" does not exist."];
//        self.exception = [[ProgramException alloc] initWithMessage:message];
//        return 0;
//    }
//    return value.integer;
//}
//
//- (bool)getBoolFor: (NSString *)variableName {
//    Value * value = [self.boolDictionary objectForKey:variableName];
//    if (value == nil) {
//        NSString * message = @"Variable \"";
//        message = [message stringByAppendingString:variableName];
//        message = [message stringByAppendingString:@"\" does not exist."];
//        self.exception = [[ProgramException alloc] initWithMessage:message];
//        return false;
//    }
//    return value.boolean;
//}

- (int)getIntFor: (NSString *)variableName atIndex:(int) index {
    NSMutableArray * array = [self.intArrayDictionary objectForKey:variableName];
    if (array == nil) {
        NSString * message = @"Element ";
        message = [message stringByAppendingString:[self arraySyntaxFor:variableName atIndex:index]];
        message = [message stringByAppendingString:@" does not exist because the array \""];
        message = [message stringByAppendingString:variableName];
        message = [message stringByAppendingString:@"[]\" does not exist."];
        self.exception = [[ProgramException alloc] initWithMessage:message];
        return 0;
    }
    if (index < 0 || array.count <= index) {
        NSString * message = @"Element ";
        message = [message stringByAppendingString:[self arraySyntaxFor:variableName atIndex:index]];
        message = [message stringByAppendingString:@" does not exist. The size of \""];
        message = [message stringByAppendingString:variableName];
        message = [message stringByAppendingString:@"[]\" is "];
        message = [message stringByAppendingString:[[NSNumber numberWithLong:array.count] stringValue]];
        message = [message stringByAppendingString:@", thus only values at some index ranged 0 to "];
        message = [message stringByAppendingString:[[NSNumber numberWithLong:array.count - 1] stringValue]];
        message = [message stringByAppendingString:@" may be evaluated."];
        self.exception = [[ProgramException alloc] initWithMessage:message];
        return 0;
    } else
        return [(NSNumber *) array[index] intValue];
}

- (bool)getBoolFor: (NSString *)variableName atIndex:(int) index {
    NSMutableArray * array = [self.boolArrayDictionary objectForKey:variableName];
    if (array == nil) {
        NSString * message = @"Element ";
        message = [message stringByAppendingString:[self arraySyntaxFor:variableName atIndex:index]];
        message = [message stringByAppendingString:@" does not exist because the array \""];
        message = [message stringByAppendingString:variableName];
        message = [message stringByAppendingString:@"[]\" does not exist."];
        self.exception = [[ProgramException alloc] initWithMessage:message];
        return false;
    }
    if (index < 0 || array.count <= index) {
        NSString * message = @"Element ";
        message = [message stringByAppendingString:[self arraySyntaxFor:variableName atIndex:index]];
        message = [message stringByAppendingString:@" does not exist. The size of \""];
        message = [message stringByAppendingString:variableName];
        message = [message stringByAppendingString:@"[]\" is "];
        message = [message stringByAppendingString:[[NSNumber numberWithLong:array.count] stringValue]];
        message = [message stringByAppendingString:@", thus only values at some index ranged 0 to "];
        message = [message stringByAppendingString:[[NSNumber numberWithLong:array.count - 1] stringValue]];
        message = [message stringByAppendingString:@" may be evaluated."];
        self.exception = [[ProgramException alloc] initWithMessage:message];
        return false;
    } else
        return [(NSNumber *) array[index] boolValue];
}

@end
