//
//  Program.m
//  InspirationBasic
//
//  Created by Timothy Swan on 6/1/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import "Program.h"

@implementation Program

- (id) initWithTitle:(NSString *) title {
    if (self = [super init]) {
        self.title = title;
        self.parent = nil;
    }
    return self;
}

- (void) executeWithListener:(id<OutputListener>)listener {
    [self executeAgainst:[[EnvironmentModel alloc] initWithOutputListener:listener]];
}

- (void) executeProgramAgainst:(EnvironmentModel *)environment { // For debugging/testing
    [self executeAgainst:environment];
    [ProgramException checkExceptionWithEnvironment:environment andIdentifier:@"Program"];
}

@end
