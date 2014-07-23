//
//  displayStringVisitor.m
//  InspirationBasic
//
//  Created by Timothy Swan on 5/31/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import "ExpressionIsLeafVisitor.h"

#import "./BoolVariable.h"
#import "./IntVariable.h"
#import "./BoolArrayElement.h"
#import "./IntArrayElement.h"
#import "./IntValue.h"
#import "./BoolValue.h"
#import "./IntNegation.h"
#import "./IntSum.h"
#import "./IntDifference.h"
#import "./IntProduct.h"
#import "./IntQuotient.h"
#import "./IntRemainder.h"
#import "./BoolNegation.h"
#import "./BoolOr.h"
#import "./BoolNor.h"
#import "./BoolAnd.h"
#import "./BoolNand.h"
#import "./BoolImplies.h"
#import "./BoolNonImplies.h"
#import "./BoolReverseImplies.h"
#import "./BoolReverseNonImplies.h"
#import "./BoolBoolEquals.h"
#import "./BoolBoolDoesNotEqual.h"
#import "./BoolIntEquals.h"
#import "./BoolIntDoesNotEqual.h"
#import "./BoolLessThan.h"
#import "./BoolLessThanOrEquals.h"
#import "./BoolGreaterThan.h"
#import "./BoolGreaterThanOrEquals.h"

@implementation ExpressionIsLeafVisitor

- (id) init {
    if (self = [super init]) {
    }
    return self;
}

- (bool) checkIfIntLeaf:(id <IntExpression>)intExpression {
    [intExpression accept:self];
    return self.isLeaf;
}

- (bool) checkIfBoolLeaf:(id <BoolExpression>)boolExpression {
    [boolExpression accept:self];
    return self.isLeaf;
}

- (void) visitIntValue:(IntValue *)intValue {
    self.isLeaf = true;
}

- (void) visitBoolValue:(BoolValue *)boolValue {
    self.isLeaf = true;
}

- (void) visitIntVariable:(IntVariable *)intVariable {
    self.isLeaf = true;
}

- (void) visitBoolVariable:(BoolVariable *)boolVariable {
    self.isLeaf = true;
}

// Non-leaf expressions:

- (void) visitIntArrayElement:(IntArrayElement *)intArrayElement {
    self.isLeaf = false;
}

- (void) visitBoolArrayElement:(BoolArrayElement *)boolArrayElement {
    self.isLeaf = false;
}

- (void) visitIntNegation:(IntNegation *)intNegation {
    self.isLeaf = false;
}

- (void) visitIntSum:(IntSum *)intSum {
    self.isLeaf = false;
}

- (void) visitIntDifference:(IntDifference *)intDifference {
    self.isLeaf = false;
}

- (void) visitIntProduct:(IntProduct *)intProduct {
    self.isLeaf = false;
}

- (void) visitIntQuotient:(IntQuotient *)intQuotient {
    self.isLeaf = false;
}

- (void) visitIntRemainder:(IntRemainder *)intRemainder {
    self.isLeaf = false;
}

- (void) visitBoolNegation:(BoolNegation *)boolNegation {
    self.isLeaf = false;
}

- (void) visitBoolBoolEquals:(BoolBoolEquals *)boolBoolEquals {
    self.isLeaf = false;
}

- (void) visitBoolBoolDoesNotEqual:(BoolBoolDoesNotEqual *)boolBoolDoesNotEqual {
    self.isLeaf = false;
}

- (void) visitBoolOr:(BoolOr *)boolOr {
    self.isLeaf = false;
}

- (void) visitBoolNor:(BoolNor *)boolNor {
    self.isLeaf = false;
}

- (void) visitBoolAnd:(BoolAnd *)boolAnd {
    self.isLeaf = false;
}

- (void) visitBoolNand:(BoolNand *)boolNand {
    self.isLeaf = false;
}

- (void) visitBoolImplies:(BoolImplies *)boolImplies {
    self.isLeaf = false;
}

- (void) visitBoolNonImplies:(BoolNonImplies *)boolNonImplies {
    self.isLeaf = false;
}

- (void) visitBoolReverseImplies:(BoolReverseImplies *)boolReverseImplies {
    self.isLeaf = false;
}

- (void) visitBoolReverseNonImplies:(BoolReverseNonImplies *)boolReverseNonImplies {
    self.isLeaf = false;
}

- (void) visitBoolIntEquals:(BoolIntEquals *)boolIntEquals {
    self.isLeaf = false;
}

- (void) visitBoolIntDoesNotEqual:(BoolIntDoesNotEqual *)boolIntDoesNotEqual {
    self.isLeaf = false;
}

- (void) visitBoolLessThan:(BoolLessThan *)boolLessThan {
    self.isLeaf = false;
}

- (void) visitBoolLessThanOrEquals:(BoolLessThanOrEquals *)boolLessThanOrEquals {
    self.isLeaf = false;
}

- (void) visitBoolGreaterThan:(BoolGreaterThan *)boolGreaterThan {
    self.isLeaf = false;
}

- (void) visitBoolGreaterThanOrEquals:(BoolGreaterThanOrEquals *)boolGreaterThanOrEquals {
    self.isLeaf = false;
}

@end
