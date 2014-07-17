//
//  PrintInt.h
//  InspirationBasic
//
//  Created by Timothy Swan on 6/15/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Statement.h"
#import "IntExpression.h"

@interface PrintInt : NSObject<Statement>

@property id <Statement> parent;

@property (nonatomic) id <IntExpression> expression;

- (id) initWithExpression:(id <IntExpression>)expression andParent:(id <Statement>) parent;

- (void) executeAgainst: (EnvironmentModel *) environment;

- (void) accept:(id <StatementVisitor>)visitor;

@end
