//
//  IfThenElseEndIf.h
//  InspirationBasic
//
//  Created by Timothy Swan on 5/31/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Statement.h"
#import "BoolExpression.h"
#import "StatementList.h"

@interface IfThenElseEndIf : NSObject<Statement>

@property id <Statement> parent;

@property (nonatomic) id <BoolExpression> expression;

@property (nonatomic) StatementList * thenStatements;
@property (nonatomic) StatementList * elseStatements;

- (id) initWithIf: (id <BoolExpression>)expression Then: (StatementList *)thenStatements Else: (StatementList *)elseStatements andParent:(id <Statement>) parent;

- (void) executeAgainst: (EnvironmentModel *) environment;

- (void) accept:(id <StatementVisitor>)visitor;

@end