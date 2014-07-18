//
//  displayStringVisitor.m
//  InspirationBasic
//
//  Created by Timothy Swan on 5/31/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import "ExpressionBreakdownVisitor.h"

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

@implementation ExpressionBreakdownVisitor

- (id) init {
    if (self = [super init]) {
        self.types = [[NSMutableArray alloc] init];
        self.elements = [[NSMutableArray alloc] init];
        self.strings = [[NSMutableArray alloc] init];
        self.visitor = [[ExpressionDisplayStringVisitor alloc] init];
    }
    return self;
}

- (void) generateBreakdownInt:(id <IntExpression>)intExpression {
    [intExpression accept:self];
}

- (void) generateBreakdownBool:(id <BoolExpression>)boolExpression {
    [boolExpression accept:self];
}

- (NSString *) getStringForInt:(id <IntExpression>)intExpression {
    return [self.visitor getStringForInt:intExpression];
}

- (NSString *) getStringForBool:(id <BoolExpression>)boolExpression {
    return [self.visitor getStringForBool:boolExpression];
}

/*
 
 Returning types
 
 1. Statement
 2. Int Expression
 3. Bool Expression
 4. Int Variable
 5. Bool Variable
 6. Int Array Variable
 7. Bool Array Variable
 
 */

- (void) visitIntValue:(IntValue *)intValue {
    [self.types addObject:[NSNumber numberWithInt:2]];
    [self.elements addObject:intValue];
    [self.strings addObject:[@(intValue.value) stringValue]];
}

- (void) visitBoolValue:(BoolValue *)boolValue {
    [self.types addObject:[NSNumber numberWithInt:3]];
    [self.elements addObject:boolValue];
    [self.strings addObject:boolValue.value ? @"true" : @"false"];
}

- (void) visitIntVariable:(IntVariable *)intVariable {
    [self.types addObject:[NSNumber numberWithInt:2]];
    [self.elements addObject:intVariable];
    [self.strings addObject:intVariable.variable];
}

- (void) visitBoolVariable:(BoolVariable *)boolVariable {
    [self.types addObject:[NSNumber numberWithInt:3]];
    [self.elements addObject:boolVariable];
    [self.strings addObject:boolVariable.variable];
}

- (void) visitIntArrayElement:(IntArrayElement *)intArrayElement {
    [self.types addObject:[NSNumber numberWithInt:6]];
    [self.elements addObject:intArrayElement.variable];
    [self.strings addObject:intArrayElement.variable];
    
    [self.types addObject:[NSNumber numberWithInt:2]];
    [self.elements addObject:intArrayElement];
    [self.strings addObject:@"["];
    
    [self.types addObject:[NSNumber numberWithInt:2]];
    [self.elements addObject:intArrayElement.indexExpression];
    [self.strings addObject:[self getStringForInt:intArrayElement.indexExpression]];
    
    [self.types addObject:[NSNumber numberWithInt:2]];
    [self.elements addObject:intArrayElement];
    [self.strings addObject:@"]"];
}

- (void) visitBoolArrayElement:(BoolArrayElement *)boolArrayElement {
    [self.types addObject:[NSNumber numberWithInt:7]];
    [self.elements addObject:boolArrayElement.variable];
    [self.strings addObject:boolArrayElement.variable];
    
    [self.types addObject:[NSNumber numberWithInt:3]];
    [self.elements addObject:boolArrayElement];
    [self.strings addObject:@"["];
    
    [self.types addObject:[NSNumber numberWithInt:2]];
    [self.elements addObject:boolArrayElement.indexExpression];
    [self.strings addObject:[self getStringForInt:boolArrayElement.indexExpression]];
    
    [self.types addObject:[NSNumber numberWithInt:3]];
    [self.elements addObject:boolArrayElement];
    [self.strings addObject:@"]"];
}

- (void) visitIntNegation:(IntNegation *)intNegation {
    [self.types addObject:[NSNumber numberWithInt:2]];
    [self.elements addObject:intNegation];
    [self.strings addObject:@"-"];
    
    [self.types addObject:[NSNumber numberWithInt:2]];
    [self.elements addObject:intNegation.expression];
    [self.strings addObject:[self getStringForInt:intNegation.expression]];
}

- (void) visitIntSum:(IntSum *)intSum {
    [self.types addObject:[NSNumber numberWithInt:2]];
    [self.elements addObject:intSum.expression1];
    [self.strings addObject:[self getStringForInt:intSum.expression1]];
    
    [self.types addObject:[NSNumber numberWithInt:2]];
    [self.elements addObject:intSum];
    [self.strings addObject:@"+"];
    
    [self.types addObject:[NSNumber numberWithInt:2]];
    [self.elements addObject:intSum.expression2];
    [self.strings addObject:[self getStringForInt:intSum.expression2]];
}

- (void) visitIntDifference:(IntDifference *)intDifference {
    [self.types addObject:[NSNumber numberWithInt:2]];
    [self.elements addObject:intDifference.expression1];
    [self.strings addObject:[self getStringForInt:intDifference.expression1]];
    
    [self.types addObject:[NSNumber numberWithInt:2]];
    [self.elements addObject:intDifference];
    [self.strings addObject:@"-"];
    
    [self.types addObject:[NSNumber numberWithInt:2]];
    [self.elements addObject:intDifference.expression2];
    [self.strings addObject:[self getStringForInt:intDifference.expression2]];
}

- (void) visitIntProduct:(IntProduct *)intProduct {
    [self.types addObject:[NSNumber numberWithInt:2]];
    [self.elements addObject:intProduct.expression1];
    [self.strings addObject:[self getStringForInt:intProduct.expression1]];
    
    [self.types addObject:[NSNumber numberWithInt:2]];
    [self.elements addObject:intProduct];
    [self.strings addObject:@"*"];
    
    [self.types addObject:[NSNumber numberWithInt:2]];
    [self.elements addObject:intProduct.expression2];
    [self.strings addObject:[self getStringForInt:intProduct.expression2]];
}

- (void) visitIntQuotient:(IntQuotient *)intQuotient {
    [self.types addObject:[NSNumber numberWithInt:2]];
    [self.elements addObject:intQuotient.expression1];
    [self.strings addObject:[self getStringForInt:intQuotient.expression1]];
    
    [self.types addObject:[NSNumber numberWithInt:2]];
    [self.elements addObject:intQuotient];
    [self.strings addObject:@"/"];
    
    [self.types addObject:[NSNumber numberWithInt:2]];
    [self.elements addObject:intQuotient.expression2];
    [self.strings addObject:[self getStringForInt:intQuotient.expression2]];
}

- (void) visitIntRemainder:(IntRemainder *)intRemainder {
    [self.types addObject:[NSNumber numberWithInt:2]];
    [self.elements addObject:intRemainder.expression1];
    [self.strings addObject:[self getStringForInt:intRemainder.expression1]];
    
    [self.types addObject:[NSNumber numberWithInt:2]];
    [self.elements addObject:intRemainder];
    [self.strings addObject:@"%"];
    
    [self.types addObject:[NSNumber numberWithInt:2]];
    [self.elements addObject:intRemainder.expression2];
    [self.strings addObject:[self getStringForInt:intRemainder.expression2]];
}

- (void) visitBoolNegation:(BoolNegation *)boolNegation {
    [self.types addObject:[NSNumber numberWithInt:3]];
    [self.elements addObject:boolNegation];
    [self.strings addObject:@"¬"];
    
    [self.types addObject:[NSNumber numberWithInt:3]];
    [self.elements addObject:boolNegation.expression];
    [self.strings addObject:[self getStringForBool:boolNegation.expression]];
}

- (void) visitBoolBoolEquals:(BoolBoolEquals *)boolBoolEquals {
    [self.types addObject:[NSNumber numberWithInt:3]];
    [self.elements addObject:boolBoolEquals.expression1];
    [self.strings addObject:[self getStringForBool:boolBoolEquals.expression1]];
    
    [self.types addObject:[NSNumber numberWithInt:3]];
    [self.elements addObject:boolBoolEquals];
    [self.strings addObject:@"="];
    
    [self.types addObject:[NSNumber numberWithInt:3]];
    [self.elements addObject:boolBoolEquals.expression2];
    [self.strings addObject:[self getStringForBool:boolBoolEquals.expression2]];
}

- (void) visitBoolBoolDoesNotEqual:(BoolBoolDoesNotEqual *)boolBoolDoesNotEqual {
    [self.types addObject:[NSNumber numberWithInt:3]];
    [self.elements addObject:boolBoolDoesNotEqual.expression1];
    [self.strings addObject:[self getStringForBool:boolBoolDoesNotEqual.expression1]];
    
    [self.types addObject:[NSNumber numberWithInt:3]];
    [self.elements addObject:boolBoolDoesNotEqual];
    [self.strings addObject:@"≠"];
    
    [self.types addObject:[NSNumber numberWithInt:3]];
    [self.elements addObject:boolBoolDoesNotEqual.expression2];
    [self.strings addObject:[self getStringForBool:boolBoolDoesNotEqual.expression2]];
}

- (void) visitBoolOr:(BoolOr *)boolOr {
    [self.types addObject:[NSNumber numberWithInt:3]];
    [self.elements addObject:boolOr.expression1];
    [self.strings addObject:[self getStringForBool:boolOr.expression1]];
    
    [self.types addObject:[NSNumber numberWithInt:3]];
    [self.elements addObject:boolOr];
    [self.strings addObject:@"∨"];
    
    [self.types addObject:[NSNumber numberWithInt:3]];
    [self.elements addObject:boolOr.expression2];
    [self.strings addObject:[self getStringForBool:boolOr.expression2]];
}

- (void) visitBoolNor:(BoolNor *)boolNor {
    [self.types addObject:[NSNumber numberWithInt:3]];
    [self.elements addObject:boolNor.expression1];
    [self.strings addObject:[self getStringForBool:boolNor.expression1]];
    
    [self.types addObject:[NSNumber numberWithInt:3]];
    [self.elements addObject:boolNor];
    [self.strings addObject:@"↓"];
    
    [self.types addObject:[NSNumber numberWithInt:3]];
    [self.elements addObject:boolNor.expression2];
    [self.strings addObject:[self getStringForBool:boolNor.expression2]];
}

- (void) visitBoolAnd:(BoolAnd *)boolAnd {
    [self.types addObject:[NSNumber numberWithInt:3]];
    [self.elements addObject:boolAnd.expression1];
    [self.strings addObject:[self getStringForBool:boolAnd.expression1]];
    
    [self.types addObject:[NSNumber numberWithInt:3]];
    [self.elements addObject:boolAnd];
    [self.strings addObject:@"∧"];
    
    [self.types addObject:[NSNumber numberWithInt:3]];
    [self.elements addObject:boolAnd.expression2];
    [self.strings addObject:[self getStringForBool:boolAnd.expression2]];
}

- (void) visitBoolNand:(BoolNand *)boolNand {
    [self.types addObject:[NSNumber numberWithInt:3]];
    [self.elements addObject:boolNand.expression1];
    [self.strings addObject:[self getStringForBool:boolNand.expression1]];
    
    [self.types addObject:[NSNumber numberWithInt:3]];
    [self.elements addObject:boolNand];
    [self.strings addObject:@"↑"];
    
    [self.types addObject:[NSNumber numberWithInt:3]];
    [self.elements addObject:boolNand.expression2];
    [self.strings addObject:[self getStringForBool:boolNand.expression2]];
}

- (void) visitBoolImplies:(BoolImplies *)boolImplies {
    [self.types addObject:[NSNumber numberWithInt:3]];
    [self.elements addObject:boolImplies.expression1];
    [self.strings addObject:[self getStringForBool:boolImplies.expression1]];
    
    [self.types addObject:[NSNumber numberWithInt:3]];
    [self.elements addObject:boolImplies];
    [self.strings addObject:@"⇒"];
    
    [self.types addObject:[NSNumber numberWithInt:3]];
    [self.elements addObject:boolImplies.expression2];
    [self.strings addObject:[self getStringForBool:boolImplies.expression2]];
}

- (void) visitBoolNonImplies:(BoolNonImplies *)boolNonImplies {
    [self.types addObject:[NSNumber numberWithInt:3]];
    [self.elements addObject:boolNonImplies.expression1];
    [self.strings addObject:[self getStringForBool:boolNonImplies.expression1]];
    
    [self.types addObject:[NSNumber numberWithInt:3]];
    [self.elements addObject:boolNonImplies];
    [self.strings addObject:@"⇏"];
    
    [self.types addObject:[NSNumber numberWithInt:3]];
    [self.elements addObject:boolNonImplies.expression2];
    [self.strings addObject:[self getStringForBool:boolNonImplies.expression2]];
}

- (void) visitBoolReverseImplies:(BoolReverseImplies *)boolReverseImplies {
    [self.types addObject:[NSNumber numberWithInt:3]];
    [self.elements addObject:boolReverseImplies.expression1];
    [self.strings addObject:[self getStringForBool:boolReverseImplies.expression1]];
    
    [self.types addObject:[NSNumber numberWithInt:3]];
    [self.elements addObject:boolReverseImplies];
    [self.strings addObject:@"⇐"];
    
    [self.types addObject:[NSNumber numberWithInt:3]];
    [self.elements addObject:boolReverseImplies.expression2];
    [self.strings addObject:[self getStringForBool:boolReverseImplies.expression2]];
}

- (void) visitBoolReverseNonImplies:(BoolReverseNonImplies *)boolReverseNonImplies {
    [self.types addObject:[NSNumber numberWithInt:3]];
    [self.elements addObject:boolReverseNonImplies.expression1];
    [self.strings addObject:[self getStringForBool:boolReverseNonImplies.expression1]];
    
    [self.types addObject:[NSNumber numberWithInt:3]];
    [self.elements addObject:boolReverseNonImplies];
    [self.strings addObject:@"⇍"];
    
    [self.types addObject:[NSNumber numberWithInt:3]];
    [self.elements addObject:boolReverseNonImplies.expression2];
    [self.strings addObject:[self getStringForBool:boolReverseNonImplies.expression2]];
}

- (void) visitBoolIntEquals:(BoolIntEquals *)boolIntEquals {
    [self.types addObject:[NSNumber numberWithInt:2]];
    [self.elements addObject:boolIntEquals.expression1];
    [self.strings addObject:[self getStringForInt:boolIntEquals.expression1]];
    
    [self.types addObject:[NSNumber numberWithInt:3]];
    [self.elements addObject:boolIntEquals];
    [self.strings addObject:@"="];
    
    [self.types addObject:[NSNumber numberWithInt:2]];
    [self.elements addObject:boolIntEquals.expression2];
    [self.strings addObject:[self getStringForInt:boolIntEquals.expression2]];
}

- (void) visitBoolIntDoesNotEqual:(BoolIntDoesNotEqual *)boolIntDoesNotEqual {
    [self.types addObject:[NSNumber numberWithInt:2]];
    [self.elements addObject:boolIntDoesNotEqual.expression1];
    [self.strings addObject:[self getStringForInt:boolIntDoesNotEqual.expression1]];
    
    [self.types addObject:[NSNumber numberWithInt:3]];
    [self.elements addObject:boolIntDoesNotEqual];
    [self.strings addObject:@"≠"];
    
    [self.types addObject:[NSNumber numberWithInt:2]];
    [self.elements addObject:boolIntDoesNotEqual.expression2];
    [self.strings addObject:[self getStringForInt:boolIntDoesNotEqual.expression2]];
}

- (void) visitBoolLessThan:(BoolLessThan *)boolLessThan {
    [self.types addObject:[NSNumber numberWithInt:2]];
    [self.elements addObject:boolLessThan.expression1];
    [self.strings addObject:[self getStringForInt:boolLessThan.expression1]];
    
    [self.types addObject:[NSNumber numberWithInt:3]];
    [self.elements addObject:boolLessThan];
    [self.strings addObject:@"<"];
    
    [self.types addObject:[NSNumber numberWithInt:2]];
    [self.elements addObject:boolLessThan.expression2];
    [self.strings addObject:[self getStringForInt:boolLessThan.expression2]];
}

- (void) visitBoolLessThanOrEquals:(BoolLessThanOrEquals *)boolLessThanOrEquals {
    [self.types addObject:[NSNumber numberWithInt:2]];
    [self.elements addObject:boolLessThanOrEquals.expression1];
    [self.strings addObject:[self getStringForInt:boolLessThanOrEquals.expression1]];
    
    [self.types addObject:[NSNumber numberWithInt:3]];
    [self.elements addObject:boolLessThanOrEquals];
    [self.strings addObject:@"≤"];
    
    [self.types addObject:[NSNumber numberWithInt:2]];
    [self.elements addObject:boolLessThanOrEquals.expression2];
    [self.strings addObject:[self getStringForInt:boolLessThanOrEquals.expression2]];
}

- (void) visitBoolGreaterThan:(BoolGreaterThan *)boolGreaterThan {
    [self.types addObject:[NSNumber numberWithInt:2]];
    [self.elements addObject:boolGreaterThan.expression1];
    [self.strings addObject:[self getStringForInt:boolGreaterThan.expression1]];
    
    [self.types addObject:[NSNumber numberWithInt:3]];
    [self.elements addObject:boolGreaterThan];
    [self.strings addObject:@">"];
    
    [self.types addObject:[NSNumber numberWithInt:2]];
    [self.elements addObject:boolGreaterThan.expression2];
    [self.strings addObject:[self getStringForInt:boolGreaterThan.expression2]];
}

- (void) visitBoolGreaterThanOrEquals:(BoolGreaterThanOrEquals *)boolGreaterThanOrEquals {
    [self.types addObject:[NSNumber numberWithInt:2]];
    [self.elements addObject:boolGreaterThanOrEquals.expression1];
    [self.strings addObject:[self getStringForInt:boolGreaterThanOrEquals.expression1]];
    
    [self.types addObject:[NSNumber numberWithInt:3]];
    [self.elements addObject:boolGreaterThanOrEquals];
    [self.strings addObject:@"≥"];
    
    [self.types addObject:[NSNumber numberWithInt:2]];
    [self.elements addObject:boolGreaterThanOrEquals.expression2];
    [self.strings addObject:[self getStringForInt:boolGreaterThanOrEquals.expression2]];
}

@end
