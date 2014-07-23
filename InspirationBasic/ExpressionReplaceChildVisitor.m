//
//  displayStringVisitor.m
//  InspirationBasic
//
//  Created by Timothy Swan on 5/31/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import "ExpressionReplaceChildVisitor.h"

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

@implementation ExpressionReplaceChildVisitor

- (id) init {
    if (self = [super init]) {
    }
    return self;
}

- (void) setSwapChildrenOld:(id)oldChild New:(id)newChild {
    self.theOldChild = oldChild;
    self.theNewChild = newChild;
}

- (void) replaceChild:(id)oldChild OfIntExpression:(id <IntExpression>)intExpression With:(id)newChild {
    [self setSwapChildrenOld:oldChild New:newChild];
    [intExpression accept:self];
}

- (void) replaceChild:(id)oldChild OfBoolExpression:(id <BoolExpression>)boolExpression With:(id)newChild {
    [self setSwapChildrenOld:oldChild New:newChild];
    [boolExpression accept:self];
}

- (NSString *) leafNodeException {
    return @"Invalid type value Leaf node";
}

- (NSString *) oldChildDoesNotExistException {
    return @"Old child does not exist in expression";
}

- (void) visitIntValue:(IntValue *)intValue {
    [NSException raise:[self leafNodeException] format:@"LeafNode"];
}

- (void) visitBoolValue:(BoolValue *)boolValue {
    [NSException raise:[self leafNodeException] format:@"LeafNode"];
}

- (void) visitIntVariable:(IntVariable *)intVariable {
    [NSException raise:[self leafNodeException] format:@"LeafNode"];
}

- (void) visitBoolVariable:(BoolVariable *)boolVariable {
    [NSException raise:[self leafNodeException] format:@"LeafNode"];
}

// Non-leaf expressions:

- (void) visitIntArrayElement:(IntArrayElement *)intArrayElement {
    if (intArrayElement.indexExpression == self.theOldChild) {
        intArrayElement.indexExpression = self.theNewChild;
    } else {
        [NSException raise:[self oldChildDoesNotExistException] format:@"OldChild"];
    }
}

- (void) visitBoolArrayElement:(BoolArrayElement *)boolArrayElement {
    if (boolArrayElement.indexExpression == self.theOldChild) {
        boolArrayElement.indexExpression = self.theNewChild;
    } else {
        [NSException raise:[self oldChildDoesNotExistException] format:@"OldChild"];
    }
}

- (void) visitIntNegation:(IntNegation *)intNegation {
    if (intNegation.expression == self.theOldChild) {
        intNegation.expression = self.theNewChild;
    } else {
        [NSException raise:[self oldChildDoesNotExistException] format:@"OldChild"];
    }
}

- (void) visitIntSum:(IntSum *)intSum {
    if (intSum.expression1 == self.theOldChild) {
        intSum.expression1 = self.theNewChild;
    } else if (intSum.expression2 == self.theOldChild) {
        intSum.expression2 = self.theNewChild;
    } else {
        [NSException raise:[self oldChildDoesNotExistException] format:@"OldChild"];
    }
}

- (void) visitIntDifference:(IntDifference *)intDifference {
    if (intDifference.expression1 == self.theOldChild) {
        intDifference.expression1 = self.theNewChild;
    } else if (intDifference.expression2 == self.theOldChild) {
        intDifference.expression2 = self.theNewChild;
    } else {
        [NSException raise:[self oldChildDoesNotExistException] format:@"OldChild"];
    }
}

- (void) visitIntProduct:(IntProduct *)intProduct {
    if (intProduct.expression1 == self.theOldChild) {
        intProduct.expression1 = self.theNewChild;
    } else if (intProduct.expression2 == self.theOldChild) {
        intProduct.expression2 = self.theNewChild;
    } else {
        [NSException raise:[self oldChildDoesNotExistException] format:@"OldChild"];
    }
}

- (void) visitIntQuotient:(IntQuotient *)intQuotient {
    if (intQuotient.expression1 == self.theOldChild) {
        intQuotient.expression1 = self.theNewChild;
    } else if (intQuotient.expression2 == self.theOldChild) {
        intQuotient.expression2 = self.theNewChild;
    } else {
        [NSException raise:[self oldChildDoesNotExistException] format:@"OldChild"];
    }
}

- (void) visitIntRemainder:(IntRemainder *)intRemainder {
    if (intRemainder.expression1 == self.theOldChild) {
        intRemainder.expression1 = self.theNewChild;
    } else if (intRemainder.expression2 == self.theOldChild) {
        intRemainder.expression2 = self.theNewChild;
    } else {
        [NSException raise:[self oldChildDoesNotExistException] format:@"OldChild"];
    }
}

- (void) visitBoolNegation:(BoolNegation *)boolNegation {
    if (boolNegation.expression == self.theOldChild) {
        boolNegation.expression = self.theNewChild;
    } else {
        [NSException raise:[self oldChildDoesNotExistException] format:@"OldChild"];
    }
}

- (void) visitBoolBoolEquals:(BoolBoolEquals *)boolBoolEquals {
    if (boolBoolEquals.expression1 == self.theOldChild) {
        boolBoolEquals.expression1 = self.theNewChild;
    } else if (boolBoolEquals.expression2 == self.theOldChild) {
        boolBoolEquals.expression2 = self.theNewChild;
    } else {
        [NSException raise:[self oldChildDoesNotExistException] format:@"OldChild"];
    }
}

- (void) visitBoolBoolDoesNotEqual:(BoolBoolDoesNotEqual *)boolBoolDoesNotEqual {
    if (boolBoolDoesNotEqual.expression1 == self.theOldChild) {
        boolBoolDoesNotEqual.expression1 = self.theNewChild;
    } else if (boolBoolDoesNotEqual.expression2 == self.theOldChild) {
        boolBoolDoesNotEqual.expression2 = self.theNewChild;
    } else {
        [NSException raise:[self oldChildDoesNotExistException] format:@"OldChild"];
    }
}

- (void) visitBoolOr:(BoolOr *)boolOr {
    if (boolOr.expression1 == self.theOldChild) {
        boolOr.expression1 = self.theNewChild;
    } else if (boolOr.expression2 == self.theOldChild) {
        boolOr.expression2 = self.theNewChild;
    } else {
        [NSException raise:[self oldChildDoesNotExistException] format:@"OldChild"];
    }
}

- (void) visitBoolNor:(BoolNor *)boolNor {
    if (boolNor.expression1 == self.theOldChild) {
        boolNor.expression1 = self.theNewChild;
    } else if (boolNor.expression2 == self.theOldChild) {
        boolNor.expression2 = self.theNewChild;
    } else {
        [NSException raise:[self oldChildDoesNotExistException] format:@"OldChild"];
    }
}

- (void) visitBoolAnd:(BoolAnd *)boolAnd {
    if (boolAnd.expression1 == self.theOldChild) {
        boolAnd.expression1 = self.theNewChild;
    } else if (boolAnd.expression2 == self.theOldChild) {
        boolAnd.expression2 = self.theNewChild;
    } else {
        [NSException raise:[self oldChildDoesNotExistException] format:@"OldChild"];
    }
}

- (void) visitBoolNand:(BoolNand *)boolNand {
    if (boolNand.expression1 == self.theOldChild) {
        boolNand.expression1 = self.theNewChild;
    } else if (boolNand.expression2 == self.theOldChild) {
        boolNand.expression2 = self.theNewChild;
    } else {
        [NSException raise:[self oldChildDoesNotExistException] format:@"OldChild"];
    }
}

- (void) visitBoolImplies:(BoolImplies *)boolImplies {
    if (boolImplies.expression1 == self.theOldChild) {
        boolImplies.expression1 = self.theNewChild;
    } else if (boolImplies.expression2 == self.theOldChild) {
        boolImplies.expression2 = self.theNewChild;
    } else {
        [NSException raise:[self oldChildDoesNotExistException] format:@"OldChild"];
    }
}

- (void) visitBoolNonImplies:(BoolNonImplies *)boolNonImplies {
    if (boolNonImplies.expression1 == self.theOldChild) {
        boolNonImplies.expression1 = self.theNewChild;
    } else if (boolNonImplies.expression2 == self.theOldChild) {
        boolNonImplies.expression2 = self.theNewChild;
    } else {
        [NSException raise:[self oldChildDoesNotExistException] format:@"OldChild"];
    }
}

- (void) visitBoolReverseImplies:(BoolReverseImplies *)boolReverseImplies {
    if (boolReverseImplies.expression1 == self.theOldChild) {
        boolReverseImplies.expression1 = self.theNewChild;
    } else if (boolReverseImplies.expression2 == self.theOldChild) {
        boolReverseImplies.expression2 = self.theNewChild;
    } else {
        [NSException raise:[self oldChildDoesNotExistException] format:@"OldChild"];
    }
}

- (void) visitBoolReverseNonImplies:(BoolReverseNonImplies *)boolReverseNonImplies {
    if (boolReverseNonImplies.expression1 == self.theOldChild) {
        boolReverseNonImplies.expression1 = self.theNewChild;
    } else if (boolReverseNonImplies.expression2 == self.theOldChild) {
        boolReverseNonImplies.expression2 = self.theNewChild;
    } else {
        [NSException raise:[self oldChildDoesNotExistException] format:@"OldChild"];
    }
}

- (void) visitBoolIntEquals:(BoolIntEquals *)boolIntEquals {
    if (boolIntEquals.expression1 == self.theOldChild) {
        boolIntEquals.expression1 = self.theNewChild;
    } else if (boolIntEquals.expression2 == self.theOldChild) {
        boolIntEquals.expression2 = self.theNewChild;
    } else {
        [NSException raise:[self oldChildDoesNotExistException] format:@"OldChild"];
    }
}

- (void) visitBoolIntDoesNotEqual:(BoolIntDoesNotEqual *)boolIntDoesNotEqual {
    if (boolIntDoesNotEqual.expression1 == self.theOldChild) {
        boolIntDoesNotEqual.expression1 = self.theNewChild;
    } else if (boolIntDoesNotEqual.expression2 == self.theOldChild) {
        boolIntDoesNotEqual.expression2 = self.theNewChild;
    } else {
        [NSException raise:[self oldChildDoesNotExistException] format:@"OldChild"];
    }
}

- (void) visitBoolLessThan:(BoolLessThan *)boolLessThan {
    if (boolLessThan.expression1 == self.theOldChild) {
        boolLessThan.expression1 = self.theNewChild;
    } else if (boolLessThan.expression2 == self.theOldChild) {
        boolLessThan.expression2 = self.theNewChild;
    } else {
        [NSException raise:[self oldChildDoesNotExistException] format:@"OldChild"];
    }
}

- (void) visitBoolLessThanOrEquals:(BoolLessThanOrEquals *)boolLessThanOrEquals {
    if (boolLessThanOrEquals.expression1 == self.theOldChild) {
        boolLessThanOrEquals.expression1 = self.theNewChild;
    } else if (boolLessThanOrEquals.expression2 == self.theOldChild) {
        boolLessThanOrEquals.expression2 = self.theNewChild;
    } else {
        [NSException raise:[self oldChildDoesNotExistException] format:@"OldChild"];
    }
}

- (void) visitBoolGreaterThan:(BoolGreaterThan *)boolGreaterThan {
    if (boolGreaterThan.expression1 == self.theOldChild) {
        boolGreaterThan.expression1 = self.theNewChild;
    } else if (boolGreaterThan.expression2 == self.theOldChild) {
        boolGreaterThan.expression2 = self.theNewChild;
    } else {
        [NSException raise:[self oldChildDoesNotExistException] format:@"OldChild"];
    }
}

- (void) visitBoolGreaterThanOrEquals:(BoolGreaterThanOrEquals *)boolGreaterThanOrEquals {
    if (boolGreaterThanOrEquals.expression1 == self.theOldChild) {
        boolGreaterThanOrEquals.expression1 = self.theNewChild;
    } else if (boolGreaterThanOrEquals.expression2 == self.theOldChild) {
        boolGreaterThanOrEquals.expression2 = self.theNewChild;
    } else {
        [NSException raise:[self oldChildDoesNotExistException] format:@"OldChild"];
    }
}

@end
