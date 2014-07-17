//
//  BoolAssignment.h
//  InspirationBasic
//
//  Created by Timothy Swan on 5/29/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Statement.h"
#import "BoolExpression.h"

@interface BoolAssignment : NSObject <Statement>

@property id <Statement> parent;

@property (nonatomic)NSString *variable;

@property (nonatomic) id <BoolExpression> expression;

- (id) initWith:(NSString *)variable equals:(id <BoolExpression>)expression andParent:(id <Statement>) parent;

- (void) executeAgainst: (EnvironmentModel *) environment;

- (void) accept:(id <StatementVisitor>)visitor;

@end
