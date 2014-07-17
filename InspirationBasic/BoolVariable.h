//
//  BoolVariable.h
//  InspirationBasic
//
//  Created by Timothy Swan on 5/31/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BoolExpression.h"
#import "BoolValue.h"

@interface BoolVariable : NSObject <BoolExpression>

@property (nonatomic) NSString * variable;

- (id) initWithVariable:(NSString *) variable;

- (BoolValue *)evaluateAgainst:(EnvironmentModel *)environment;

- (void) accept:(id <ExpressionVisitor>) visitor;

@end