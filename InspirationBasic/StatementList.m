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

- (id) init {
    if (self = [super init]) {
        self.statementList = [[NSMutableArray alloc] init];
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
        NSString * identifier = @"Statement ";
        identifier = [identifier stringByAppendingString:[@(i) stringValue]];
        if ([ProgramException checkExceptionWithEnvironment:environment andIdentifier:identifier])
            break;
    }
}

- (void) accept:(id <StatementVisitor>)visitor {
    [visitor visitStatementList:self];
}

@end
