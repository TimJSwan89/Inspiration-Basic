//
//  ProgramException.h
//  InspirationBasic
//
//  Created by Timothy Swan on 6/8/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EnvironmentModel.h"
@class EnvironmentModel;

@interface ProgramException : NSObject

@property (nonatomic) NSString * message;

- (id) initWithMessage:(NSString *) message;

+ (BOOL) checkExceptionWithEnvironment:(EnvironmentModel *) environment andIdentifier:(NSString *) identifier;

@end
