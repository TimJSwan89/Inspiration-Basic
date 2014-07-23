//
//  IfThenEndIf.h
//  InspirationBasic
//
//  Created by Timothy Swan on 6/2/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Statement.h"
#import "BoolExpression.h"
#import "StatementList.h"

@interface IfThenEndIf : NSObject<Statement>

@property id <Statement> parent;

@property (nonatomic) id <BoolExpression> expression;

@property (nonatomic) StatementList * thenStatements;

- (id) initWithIf: (id <BoolExpression>)expression Then: (StatementList *)thenStatements;

- (void) executeAgainst: (EnvironmentModel *) environment;

- (void) accept:(id <StatementVisitor>)visitor;

@end