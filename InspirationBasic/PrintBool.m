//
//  PrintBool.m
//  InspirationBasic
//
//  Created by Timothy Swan on 6/16/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import "PrintBool.h"
#import "BoolValue.h"

@implementation PrintBool

- (id) initWithExpression:(id <BoolExpression>)expression {
    if (self = [super init]) {
        self.expression = expression;
    }
    return self;
}

- (void) executeAgainst:(EnvironmentModel *)environment {
    
    BoolValue * theValue = [self.expression evaluateAgainst:environment];
    if ([ProgramException checkException:theValue withEnvironment:environment andIdentifier:@"PrintInt Statement"])
        return;
    [environment printLine:[@(theValue.value) stringValue]];
    
}

- (void) accept:(id <StatementVisitor>)visitor {
    [visitor visitPrintBool:self];
}

@end
