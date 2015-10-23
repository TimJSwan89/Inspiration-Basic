//
//  ProgramException.m
//  InspirationBasic
//
//  Created by Timothy Swan on 6/8/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import "ProgramException.h"
@class ProgramException;

@implementation ProgramException

-(id) initWithMessage:(NSString *) message {
    if (self = [super init]) {
        self.message = message;
    }
    return self;
}

+ (BOOL) checkExceptionWithEnvironment:(EnvironmentModel *) environment andIdentifier:(NSString *) identifier {
    if (environment.exception) {
        if ([environment.exception.message isEqualToString:@""]) {
            NSString * message = @"@";
            message = [message stringByAppendingString:identifier];
            message = [message stringByAppendingString:@"."];
            [environment printLine:message];
        } else {
            [environment printLine:environment.exception.message];
            environment.exception = [[ProgramException alloc] initWithMessage:@""];
        }
        return true;
    }
    return false;
}

@end
