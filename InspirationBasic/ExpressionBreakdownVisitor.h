//
//  displayStringVisitor.h
//  InspirationBasic
//
//  Created by Timothy Swan on 5/31/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "./ExpressionVisitor.h"

#import "ExpressionDisplayStringVisitor.h"

#import "IntExpression.h"
#import "BoolExpression.h"

@interface ExpressionBreakdownVisitor : NSObject<ExpressionVisitor>

@property NSMutableArray * types;
@property NSMutableArray * elements;
@property NSMutableArray * strings;
@property ExpressionDisplayStringVisitor * visitor;
- (id) init;
- (void) generateBreakdownInt:(id <IntExpression>)intExpression;
- (void) generateBreakdownBool:(id <BoolExpression>)boolExpression;

// The following two methods are used by StatementBreakdownVisitor
- (NSNumber *) checkIntSingleComponent:(id <IntExpression>)intExpression;
- (NSNumber *) checkBoolSingleComponent:(id <BoolExpression>)boolExpression;

/*
 
 Returning types
 
 1. Statement
 2. Int Expression
 3. Bool Expression
 4. Int Variable
 5. Bool Variable
 6. Int Array Variable
 7. Bool Array Variable
 8. Int Expression Component
 9. Bool Expression Component
 10. Int Single Component Expression
 11. Bool Single Component Expression
 
 */

- (void) visitIntValue:(IntValue *)intValue;
- (void) visitBoolValue:(BoolValue *)boolValue;
- (void) visitIntVariable:(IntVariable *)intVariable;
- (void) visitBoolVariable:(BoolVariable *)boolVariable;
- (void) visitIntNegation:(IntNegation *)intNegation;
- (void) visitIntSum:(IntSum *)intSum;
- (void) visitIntDifference:(IntDifference *)intDifference;
- (void) visitIntProduct:(IntProduct *)intProduct;
- (void) visitIntQuotient:(IntQuotient *)intQuotient;
- (void) visitIntRemainder:(IntRemainder *)intRemainder;
- (void) visitBoolNegation:(BoolNegation *)boolNegation;
- (void) visitBoolBoolEquals:(BoolBoolEquals *)boolBoolEquals;
- (void) visitBoolBoolDoesNotEqual:(BoolBoolDoesNotEqual *)boolBoolDoesNotEqual;
- (void) visitBoolOr:(BoolOr *)boolOr;
- (void) visitBoolNor:(BoolNor *)boolNor;
- (void) visitBoolAnd:(BoolAnd *)boolAnd;
- (void) visitBoolNand:(BoolNand *)boolNand;
- (void) visitBoolImplies:(BoolImplies *)boolImplies;
- (void) visitBoolNonImplies:(BoolNonImplies *)boolNonImplies;
- (void) visitBoolReverseImplies:(BoolReverseImplies *)boolReverseImplies;
- (void) visitBoolReverseNonImplies:(BoolReverseNonImplies *)boolReverseNonImplies;
- (void) visitBoolIntEquals:(BoolIntEquals *)boolIntEquals;
- (void) visitBoolIntDoesNotEqual:(BoolIntDoesNotEqual *)boolIntDoesNotEqual;
- (void) visitBoolLessThan:(BoolLessThan *)boolLessThan;
- (void) visitBoolLessThanOrEquals:(BoolLessThanOrEquals *)boolLessThanOrEquals;
- (void) visitBoolGreaterThan:(BoolGreaterThan *)boolGreaterThan;
- (void) visitBoolGreaterThanOrEquals:(BoolGreaterThanOrEquals *)boolGreaterThanOrEquals;

@end
