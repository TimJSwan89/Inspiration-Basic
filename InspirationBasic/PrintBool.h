//
//  PrintBool.h
//  InspirationBasic
//
//  Created by Timothy Swan on 6/16/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Statement.h"
#import "BoolExpression.h"

@interface PrintBool : NSObject<Statement>

@property id <Statement> parent;

@property (nonatomic) id <BoolExpression> expression;

- (id) initWithExpression:(id <BoolExpression>)expression;

- (void) executeAgainst: (EnvironmentModel *) environment;

- (void) accept:(id <StatementVisitor>)visitor;

@end
