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

+ (BOOL) checkException:(id) check withEnvironment:(EnvironmentModel *) environment andIdentifier:(NSString *) identifier {
    if (check == nil || environment.exception) {
        if (!(check == nil && environment.exception)) {
            NSString * message = @"Developer Bug Exists. Please immediately report your exact current program to the app developer team through the App Store along with the following details: ";
            
            message = [message stringByAppendingString:@"\nDebug identifier is "];
            message = [message stringByAppendingString:identifier];
            
            message = [message stringByAppendingString:@".\n(check) is "];
            message = [message stringByAppendingString:((check) ? @"not nil" : @"nil")];
            
            if (check) {
                message = [message stringByAppendingString:@".\nClass is "];
                message = [message stringByAppendingString:NSStringFromClass([check class])];
            }
            
            message = [message stringByAppendingString:@".\n(environment.exception) is "];
            message = [message stringByAppendingString:((environment.exception) ? @"not nil" : @"nil")];
            
            if (environment.exception) {
                message = [message stringByAppendingString:@".\nOriginal exception was: {"];
                message = [message stringByAppendingString:environment.exception.message];
                message = [message stringByAppendingString:@"}"];
            }
            
            environment.exception = [[ProgramException alloc] initWithMessage:message];
        }
        return true;
    }
    return false;
}

@end
