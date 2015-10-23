//
//  BoolArrayElement.h
//  InspirationBasic
//
//  Created by Timothy Swan on 6/3/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IntExpression.h"
#import "BoolExpression.h"

@interface BoolArrayElement : NSObject <BoolExpression>

@property (nonatomic) NSString * variable;
@property (nonatomic) id <IntExpression> indexExpression;

- (id) initWithVariable:(NSString *) variable andIndexExpression:(id <IntExpression>) indexExpression;

- (bool)evaluateAgainst:(EnvironmentModel *)environment;

- (void) accept:(id <ExpressionVisitor>) visitor;

@end