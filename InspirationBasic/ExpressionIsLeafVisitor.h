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

@interface ExpressionIsLeafVisitor : NSObject<ExpressionVisitor>

@property bool isLeaf;

- (id) init;
- (bool) checkIfIntLeaf:(id <IntExpression>)intExpression;
- (bool) checkIfBoolLeaf:(id <BoolExpression>)boolExpression;

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
