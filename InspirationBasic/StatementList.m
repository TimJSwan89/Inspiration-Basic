//
//  StatementList.m
//  InspirationBasic
//
//  Created by Timothy Swan on 5/31/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import "StatementList.h"
#import "ProgramException.h"

@implementation StatementList

- (id) initWithParent: (id <Statement>) parent {
    if (self = [super init]) {
        self.statementList = [[NSMutableArray alloc] init];
        self.parent = parent;
    }
    return self;
}

- (void) addStatement:(id <Statement>)statement {
    [self.statementList addObject:statement];
    statement.parent = self;
}

- (void) executeAgainst: (EnvironmentModel *) environment {
    for (int i = 0; i < self.statementList.count; i++) {
        id <Statement> statement = self.statementList[i];
        [statement executeAgainst: environment];
        if ([ProgramException checkException:statement withEnvironment:environment andIdentifier:@"StatementList Expression"])
            break;
    }
}

- (void) accept:(id <StatementVisitor>)visitor {
    [visitor visitStatementList:self];
}

@end
