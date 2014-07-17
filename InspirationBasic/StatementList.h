//
//  StatementList.h
//  InspirationBasic
//
//  Created by Timothy Swan on 5/31/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Statement.h"

@interface StatementList : NSObject <Statement>

@property (nonatomic, strong) NSMutableArray * statementList;

@property id <Statement> parent;

- (id) initWithParent: (id <Statement>) parent;

- (void) addStatement:(id <Statement>)statement;

- (void) executeAgainst: (EnvironmentModel *) environment;

- (void) accept:(id <StatementVisitor>)visitor;

@end
