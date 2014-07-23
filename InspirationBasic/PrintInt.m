//
//  PrintInt.m
//  InspirationBasic
//
//  Created by Timothy Swan on 6/15/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import "PrintInt.h"
#import "IntValue.h"

@implementation PrintInt

- (id) initWithExpression:(id <IntExpression>)expression {
    if (self = [super init]) {
        self.expression = expression;
    }
    return self;
}

- (void) executeAgainst:(EnvironmentModel *)environment {
    
    IntValue * theValue = [self.expression evaluateAgainst:environment];
    if ([ProgramException checkException:theValue withEnvironment:environment andIdentifier:@"PrintInt Statement"])
        return;
    [environment printLine:[@(theValue.value) stringValue]];
    
}

- (void) accept:(id <StatementVisitor>)visitor {
    [visitor visitPrintInt:self];
}

@end
