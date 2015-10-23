//
//  IntVariable.h
//  InspirationBasic
//
//  Created by Timothy Swan on 5/31/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IntExpression.h"
#import "IntValue.h"

@interface IntVariable : NSObject <IntExpression>

@property (nonatomic) NSString * variable;

- (id) initWithVariable:(NSString *) variable;

- (int) evaluateAgainst:(EnvironmentModel *) environment;

- (void) accept:(id <ExpressionVisitor>) visitor;

@end
