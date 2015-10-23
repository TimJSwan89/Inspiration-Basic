//
//  displayStringVisitor.m
//  InspirationBasic
//
//  Created by Timothy Swan on 5/31/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import "ExpressionDebugStringVisitor.h"
#import "../InspirationBasic/BoolVariable.h"
#import "../InspirationBasic/IntVariable.h"
#import "../InspirationBasic/BoolArrayElement.h"
#import "../InspirationBasic/IntArrayElement.h"
#import "../InspirationBasic/IntValue.h"
#import "../InspirationBasic/BoolValue.h"
#import "../InspirationBasic/IntRandom.h"
#import "../InspirationBasic/IntNegation.h"
#import "../InspirationBasic/IntSum.h"
#import "../InspirationBasic/IntDifference.h"
#import "../InspirationBasic/IntProduct.h"
#import "../InspirationBasic/IntQuotient.h"
#import "../InspirationBasic/IntRemainder.h"
#import "../InspirationBasic/BoolRandom.h"
#import "../InspirationBasic/BoolNegation.h"
#import "../InspirationBasic/BoolOr.h"
#import "../InspirationBasic/BoolNor.h"
#import "../InspirationBasic/BoolAnd.h"
#import "../InspirationBasic/BoolNand.h"
#import "../InspirationBasic/BoolImplies.h"
#import "../InspirationBasic/BoolNonImplies.h"
#import "../InspirationBasic/BoolReverseImplies.h"
#import "../InspirationBasic/BoolReverseNonImplies.h"
#import "../InspirationBasic/BoolBoolEquals.h"
#import "../InspirationBasic/BoolBoolDoesNotEqual.h"
#import "../InspirationBasic/BoolIntEquals.h"
#import "../InspirationBasic/BoolIntDoesNotEqual.h"
#import "../InspirationBasic/BoolLessThan.h"
#import "../InspirationBasic/BoolLessThanOrEquals.h"
#import "../InspirationBasic/BoolGreaterThan.h"
#import "../InspirationBasic/BoolGreaterThanOrEquals.h"

@implementation ExpressionDebugStringVisitor

- (id) init {
    if (self = [super init]) {
        self.displayString = @"";
    }
    return self;
}

- (void) append:(NSString *)string {
    self.displayString = [self.displayString stringByAppendingString:string];
}

- (void) visitIntValue:(IntValue *)intValue {
    [self append:[@(intValue.value) stringValue]];
}

- (void) visitBoolValue:(BoolValue *)boolValue {
    if (boolValue.value)
        [self append:@"true"];
    else
        [self append:@"false"];
}

- (void) visitIntVariable:(IntVariable *)intVariable {
    [self append:intVariable.variable];
}

- (void) visitBoolVariable:(BoolVariable *)boolVariable {
    [self append:boolVariable.variable];
}

- (void) visitIntArrayElement:(IntArrayElement *)intArrayElement {
    [self append:intArrayElement.variable];
    [self append:@"["];
    [intArrayElement.indexExpression accept:self];
    [self append:@"]"];
}

- (void) visitBoolArrayElement:(BoolArrayElement *)boolArrayElement {
    [self append:boolArrayElement.variable];
    [self append:@"["];
    [boolArrayElement.indexExpression accept:self];
    [self append:@"]"];
}

- (void) visitIntRandom:(IntRandom *)intRandom {
    [self append:@"RandomInt("];
    [intRandom.expression accept:self];
    [self append:@")"];
}

- (void) visitIntNegation:(IntNegation *)intNegation {
    [self append:@"-"];
    [intNegation.expression accept:self];
}

- (void) visitIntSum:(IntSum *)intSum {
    [self append:@"("];
    [intSum.expression1 accept:self];
    [self append:@" + "];
    [intSum.expression2 accept:self];
    [self append:@")"];
}

- (void) visitIntDifference:(IntDifference *)intDifference {
    [self append:@"("];
    [intDifference.expression1 accept:self];
    [self append:@" - "];
    [intDifference.expression2 accept:self];
    [self append:@")"];
}

- (void) visitIntProduct:(IntProduct *)intProduct {
    [self append:@"("];
    [intProduct.expression1 accept:self];
    [self append:@" * "];
    [intProduct.expression2 accept:self];
    [self append:@")"];
}

- (void) visitIntQuotient:(IntQuotient *)intQuotient {
    [self append:@"("];
    [intQuotient.expression1 accept:self];
    [self append:@" / "];
    [intQuotient.expression2 accept:self];
    [self append:@")"];
}

- (void) visitIntRemainder:(IntRemainder *)intRemainder {
    [self append:@"("];
    [intRemainder.expression1 accept:self];
    [self append:@" % "];
    [intRemainder.expression2 accept:self];
    [self append:@")"];
}

- (void) visitBoolRandom:(BoolRandom *)boolRandom {
    [self append:@"RandomBoolean"];
}

- (void) visitBoolNegation:(BoolNegation *)boolNegation {
    [self append:@"¬"];
    [boolNegation.expression accept:self];
}

- (void) visitBoolBoolEquals:(BoolBoolEquals *)boolBoolEquals {
    [self append:@"("];
    [boolBoolEquals.expression1 accept:self];
    [self append:@" = "];
    [boolBoolEquals.expression2 accept:self];
    [self append:@")"];
}

- (void) visitBoolBoolDoesNotEqual:(BoolBoolDoesNotEqual *)boolBoolDoesNotEqual {
    [self append:@"("];
    [boolBoolDoesNotEqual.expression1 accept:self];
    [self append:@" ≠ "];
    [boolBoolDoesNotEqual.expression2 accept:self];
    [self append:@")"];
}

- (void) visitBoolOr:(BoolOr *)boolOr {
    [self append:@"("];
    [boolOr.expression1 accept:self];
    [self append:@" ∨ "];
    [boolOr.expression2 accept:self];
    [self append:@")"];
}

- (void) visitBoolNor:(BoolNor *)boolNor {
    [self append:@"("];
    [boolNor.expression1 accept:self];
    [self append:@" ↓ "];
    [boolNor.expression2 accept:self];
    [self append:@")"];
}

- (void) visitBoolAnd:(BoolAnd *)boolAnd {
    [self append:@"("];
    [boolAnd.expression1 accept:self];
    [self append:@" ∧ "];
    [boolAnd.expression2 accept:self];
    [self append:@")"];
}

- (void) visitBoolNand:(BoolNand *)boolNand {
    [self append:@"("];
    [boolNand.expression1 accept:self];
    [self append:@" ↑ "];
    [boolNand.expression2 accept:self];
    [self append:@")"];
}

- (void) visitBoolImplies:(BoolImplies *)boolImplies {
    [self append:@"("];
    [boolImplies.expression1 accept:self];
    [self append:@" ⇒ "];
    [boolImplies.expression2 accept:self];
    [self append:@")"];
}

- (void) visitBoolNonImplies:(BoolNonImplies *)boolNonImplies {
    [self append:@"("];
    [boolNonImplies.expression1 accept:self];
    [self append:@" ⇏ "];
    [boolNonImplies.expression2 accept:self];
    [self append:@")"];
}

- (void) visitBoolReverseImplies:(BoolReverseImplies *)boolReverseImplies {
    [self append:@"("];
    [boolReverseImplies.expression1 accept:self];
    [self append:@" ⇐ "];
    [boolReverseImplies.expression2 accept:self];
    [self append:@")"];
}

- (void) visitBoolReverseNonImplies:(BoolReverseNonImplies *)boolReverseNonImplies {
    [self append:@"("];
    [boolReverseNonImplies.expression1 accept:self];
    [self append:@" ⇍ "];
    [boolReverseNonImplies.expression2 accept:self];
    [self append:@")"];
}

- (void) visitBoolIntEquals:(BoolIntEquals *)boolIntEquals {
    [self append:@"("];
    [boolIntEquals.expression1 accept:self];
    [self append:@" = "];
    [boolIntEquals.expression2 accept:self];
    [self append:@")"];
}

- (void) visitBoolIntDoesNotEqual:(BoolIntDoesNotEqual *)boolIntDoesNotEqual {
    [self append:@"("];
    [boolIntDoesNotEqual.expression1 accept:self];
    [self append:@" ≠ "];
    [boolIntDoesNotEqual.expression2 accept:self];
    [self append:@")"];
}

- (void) visitBoolLessThan:(BoolLessThan *)boolLessThan {
    [self append:@"("];
    [boolLessThan.expression1 accept:self];
    [self append:@" < "];
    [boolLessThan.expression2 accept:self];
    [self append:@")"];
}

- (void) visitBoolLessThanOrEquals:(BoolLessThanOrEquals *)boolLessThanOrEquals {
    [self append:@"("];
    [boolLessThanOrEquals.expression1 accept:self];
    [self append:@" ≤ "];
    [boolLessThanOrEquals.expression2 accept:self];
    [self append:@")"];
}

- (void) visitBoolGreaterThan:(BoolGreaterThan *)boolGreaterThan {
    [self append:@"("];
    [boolGreaterThan.expression1 accept:self];
    [self append:@" > "];
    [boolGreaterThan.expression2 accept:self];
    [self append:@")"];
}

- (void) visitBoolGreaterThanOrEquals:(BoolGreaterThanOrEquals *)boolGreaterThanOrEquals {
    [self append:@"("];
    [boolGreaterThanOrEquals.expression1 accept:self];
    [self append:@" ≥ "];
    [boolGreaterThanOrEquals.expression2 accept:self];
    [self append:@")"];
}

@end
