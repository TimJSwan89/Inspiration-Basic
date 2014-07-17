//
//  WhileEndWhile.h
//  InspirationBasic
//
//  Created by Timothy Swan on 5/31/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Statement.h"
#import "BoolExpression.h"
#import "StatementList.h"

@interface WhileEndWhile : NSObject<Statement>

@property id <Statement> parent;

@property (nonatomic) id <BoolExpression> expression;

@property (nonatomic) StatementList * loopStatements;

- (id) initWithWhile: (id <BoolExpression>)expression Do: (StatementList *)loopStatements andParent:(id <Statement>) parent;

- (void) executeAgainst: (EnvironmentModel *) environment;

- (void) accept:(id <StatementVisitor>)visitor;

@end