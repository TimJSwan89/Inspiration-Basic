//
//  IntAssignment.h
//  InspirationBasic
//
//  Created by Timothy Swan on 5/28/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Statement.h"
#import "IntExpression.h"

@interface IntAssignment : NSObject<Statement>

@property id <Statement> parent;

@property (nonatomic)NSString *variable;

@property (nonatomic) id <IntExpression> expression;

- (id) initWith:(NSString *)variable equals:(id <IntExpression>)expression;

- (void) executeAgainst: (EnvironmentModel *) environment;

- (void) accept:(id <StatementVisitor>)visitor;

@end
