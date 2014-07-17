//
//  IntArrayElement.h
//  InspirationBasic
//
//  Created by Timothy Swan on 5/31/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IntExpression.h"

@interface IntArrayElement : NSObject <IntExpression>

@property (nonatomic) NSString * variable;
@property (nonatomic) id <IntExpression> indexExpression;

- (id) initWithVariable:(NSString *) variable andIndexExpression:(id <IntExpression>) indexExpression;

- (IntValue *) evaluateAgainst:(EnvironmentModel *) environment;

- (void) accept:(id <ExpressionVisitor>) visitor;

@end
