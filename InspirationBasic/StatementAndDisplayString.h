//
//  StatementAndDisplayString.h
//  InspirationBasic
//
//  Created by Timothy Swan on 6/15/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Statement.h"

@interface StatementAndDisplayString : NSObject

@property (nonatomic) id <Statement> statement;
@property (nonatomic) NSString * displayString;

- (id) initWithStatement: (id <Statement>) statement andDisplayString: (NSString *) displayString;

+ (int) indexOfStatement: (id <Statement>) statement inList: (NSMutableArray *) statementAndDisplayStringList;

@end
