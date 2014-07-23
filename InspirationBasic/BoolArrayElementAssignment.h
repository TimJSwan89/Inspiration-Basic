//
//  BoolArrayElementAssignment.h
//  InspirationBasic
//
//  Created by Timothy Swan on 6/4/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Statement.h"
#import "IntExpression.h"
#import "BoolExpression.h"

@interface BoolArrayElementAssignment : NSObject <Statement>

@property id <Statement> parent;

@property (nonatomic)NSString *variable;
@property (nonatomic) id <IntExpression> indexExpression;
@property (nonatomic) id <BoolExpression> expression;

- (id) initWith:(BoolArrayElement *)element equals:(id <BoolExpression>)expression;

- (void) executeAgainst: (EnvironmentModel *) environment;

- (void) accept:(id <StatementVisitor>)visitor;

@end
