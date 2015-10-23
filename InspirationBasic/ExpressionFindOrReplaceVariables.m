//
//  displayStringVisitor.m
//  InspirationBasic
//
//  Created by Timothy Swan on 5/31/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import "ExpressionFindOrReplaceVariables.h"

#import "./BoolVariable.h"
#import "./IntVariable.h"
#import "./BoolArrayElement.h"
#import "./IntArrayElement.h"
#import "./IntValue.h"
#import "./BoolValue.h"
#import "./IntRandom.h"
#import "./IntNegation.h"
#import "./IntSum.h"
#import "./IntDifference.h"
#import "./IntProduct.h"
#import "./IntQuotient.h"
#import "./IntRemainder.h"
#import "./BoolRandom.h"
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

@implementation ExpressionFindOrReplaceVariables

- (id) init {
    if (self = [super init]) {
    }
    return self;
}

- (NSMutableArray *) findVariablesInIntExpression:(id <IntExpression>)intExpression withType:(int)type {
    return nil;
}

- (NSMutableArray *) findVariablesInBoolExpression:(id <BoolExpression>)boolExpression withType:(int)type {
    return nil;
}

- (void) replaceVariableInIntExpression:(id <IntExpression>)intExpression withVariable:(NSString *)variable {
    self.type = 0;
    self.replacementVariable = variable;
    [intExpression accept:self];
}

- (void) replaceVariableInBoolExpression:(id <BoolExpression>)boolExpression withVariable:(NSString *)variable {
    self.type = 0;
    self.replacementVariable = variable;
    [boolExpression accept:self];
}

- (void) visitIntValue:(IntValue *)intValue {
    
}

- (void) visitBoolValue:(BoolValue *)boolValue {
    
}

- (void) visitIntVariable:(IntVariable *)intVariable {
    
}

- (void) visitBoolVariable:(BoolVariable *)boolVariable {
    
}

- (void) visitIntArrayElement:(IntArrayElement *)intArrayElement {
    if (self.type == 0)
        intArrayElement.variable = self.replacementVariable;
}

- (void) visitBoolArrayElement:(BoolArrayElement *)boolArrayElement {
    if (self.type == 0)
        boolArrayElement.variable = self.replacementVariable;
}

- (void) visitIntRandom:(IntRandom *)intRandom {
    
}

- (void) visitIntNegation:(IntNegation *)intNegation {
    
}

- (void) visitIntSum:(IntSum *)intSum {
    
}

- (void) visitIntDifference:(IntDifference *)intDifference {
    
}

- (void) visitIntProduct:(IntProduct *)intProduct {
    
}

- (void) visitIntQuotient:(IntQuotient *)intQuotient {
    
}

- (void) visitIntRemainder:(IntRemainder *)intRemainder {
    
}

- (void) visitBoolRandom:(BoolRandom *)boolRandom {
    
}

- (void) visitBoolNegation:(BoolNegation *)boolNegation {
    
}

- (void) visitBoolBoolEquals:(BoolBoolEquals *)boolBoolEquals {
    
}

- (void) visitBoolBoolDoesNotEqual:(BoolBoolDoesNotEqual *)boolBoolDoesNotEqual {
    
}

- (void) visitBoolOr:(BoolOr *)boolOr {
    
}

- (void) visitBoolNor:(BoolNor *)boolNor {
    
}

- (void) visitBoolAnd:(BoolAnd *)boolAnd {
    
}

- (void) visitBoolNand:(BoolNand *)boolNand {
    
}

- (void) visitBoolImplies:(BoolImplies *)boolImplies {
    
}

- (void) visitBoolNonImplies:(BoolNonImplies *)boolNonImplies {
    
}

- (void) visitBoolReverseImplies:(BoolReverseImplies *)boolReverseImplies {
    
}

- (void) visitBoolReverseNonImplies:(BoolReverseNonImplies *)boolReverseNonImplies {
    
}

- (void) visitBoolIntEquals:(BoolIntEquals *)boolIntEquals {
    
}

- (void) visitBoolIntDoesNotEqual:(BoolIntDoesNotEqual *)boolIntDoesNotEqual {
    
}

- (void) visitBoolLessThan:(BoolLessThan *)boolLessThan {
    
}

- (void) visitBoolLessThanOrEquals:(BoolLessThanOrEquals *)boolLessThanOrEquals {
    
}

- (void) visitBoolGreaterThan:(BoolGreaterThan *)boolGreaterThan {
    
}

- (void) visitBoolGreaterThanOrEquals:(BoolGreaterThanOrEquals *)boolGreaterThanOrEquals {
    
}

@end
