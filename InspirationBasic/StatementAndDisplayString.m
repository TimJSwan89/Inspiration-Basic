//
//  StatementAndDisplayString.m
//  InspirationBasic
//
//  Created by Timothy Swan on 6/15/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import "StatementAndDisplayString.h"

@implementation StatementAndDisplayString

- (id) initWithStatement: (id <Statement>) statement andDisplayString: (NSString *) displayString {
    if (self = [super init]) {
        self.statement = statement;
        self.displayString = displayString;
    }
    return self;
}

+ (int) indexOfStatement: (id <Statement>) statement inList: (NSMutableArray *) statementAndDisplayStringList {
    for (int i = 0; i < statementAndDisplayStringList.count; i++)
        if (((StatementAndDisplayString *) statementAndDisplayStringList[i]).statement == statement)
            return i;
    return -1;
}

@end
