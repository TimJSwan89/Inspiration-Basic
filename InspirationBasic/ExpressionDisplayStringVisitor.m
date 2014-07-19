//
//  displayStringVisitor.m
//  InspirationBasic
//
//  Created by Timothy Swan on 5/31/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import "ExpressionDisplayStringVisitor.h"
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

@implementation ExpressionDisplayStringVisitor

- (id) init {
    if (self = [super init]) {
        self.displayString = @"";
    }
    return self;
}

- (NSString *) getStringForInt:(id <IntExpression>)intExpression {
    self.displayString = @"";
    [intExpression accept:self];
    return self.displayString;
}

- (NSString *) getStringForBool:(id <BoolExpression>)boolExpression {
    self.displayString = @"";
    [boolExpression accept:self];
    return self.displayString;
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
