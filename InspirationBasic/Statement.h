//
//  Executing.h
//  InspirationBasic
//
//  Created by Timothy Swan on 5/28/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EnvironmentModel.h"
#import "StatementVisitor.h"

@protocol Statement

@property id <Statement> parent;

- (void) executeAgainst: (EnvironmentModel *) environment;

- (void) accept: (id <StatementVisitor>) visitor;

@end
