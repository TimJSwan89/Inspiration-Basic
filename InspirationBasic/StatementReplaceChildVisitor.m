//
//  statementFlatteningVisitor.m
//  InspirationBasic
//
//  Created by Timothy Swan on 6/3/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StatementReplaceChildVisitor.h"

#import "IntExpression.h"
#import "BoolExpression.h"

#import "Program.h" // for null parent check in visitStatementList()
#import "StatementList.h"
#import "PrintInt.h"
#import "PrintBool.h"
#import "IntAssignment.h"
#import "BoolAssignment.h"
#import "IntArrayElementAssignment.h"
#import "BoolArrayElementAssignment.h"
#import "IfThenElseEndIf.h"
#import "IfThenEndIf.h"
#import "WhileEndWhile.h"
#import "Statement.h"

@implementation StatementReplaceChildVisitor

- (id) init {
    if (self = [super init]) {
    }
    return self;
}
- (void) replaceChild:(id)oldChild OfStatement:(id <Statement>)statement With:(id)newChild {
    self.theOldChild = oldChild;
    self.theNewChild = newChild;
    [statement accept:self];
}

- (NSString *) oldChildDoesNotExistException {
    return @"Old child does not exist in expression";
}

- (void) visitStatementList:(StatementList *)statementList {
    // Visitor is used only for replacing expressions, not statements.
}
- (void) visitPrintInt:(PrintInt *)printInt {
    if (printInt.expression == self.theOldChild) {
        printInt.expression = self.theNewChild;
    } else {
        [NSException raise:[self oldChildDoesNotExistException] format:@"OldChild"];
    }
}
- (void) visitPrintBool:(PrintBool *)printBool {
    if (printBool.expression == self.theOldChild) {
        printBool.expression = self.theNewChild;
    } else {
        [NSException raise:[self oldChildDoesNotExistException] format:@"OldChild"];
    }
}
- (void) visitIntAssigment:(IntAssignment *)intAssignment {
    if (intAssignment.expression == self.theOldChild) {
        intAssignment.expression = self.theNewChild;
    } else {
        [NSException raise:[self oldChildDoesNotExistException] format:@"OldChild"];
    }
}
- (void) visitBoolAssigment:(BoolAssignment *)boolAssignment {
    if (boolAssignment.expression == self.theOldChild) {
        boolAssignment.expression = self.theNewChild;
    } else {
        [NSException raise:[self oldChildDoesNotExistException] format:@"OldChild"];
    }
}
- (void) visitIntArrayElementAssignment:(IntArrayElementAssignment *)intArrayElementAssignment {
    if (intArrayElementAssignment.indexExpression == self.theOldChild) {
        intArrayElementAssignment.indexExpression = self.theNewChild;
    } else if (intArrayElementAssignment.expression == self.theOldChild) {
        intArrayElementAssignment.expression = self.theNewChild;
    } else {
        [NSException raise:[self oldChildDoesNotExistException] format:@"OldChild"];
    }
}
- (void) visitBoolArrayElementAssignment:(BoolArrayElementAssignment *)boolArrayElementAssignment {
    if (boolArrayElementAssignment.indexExpression == self.theOldChild) {
        boolArrayElementAssignment.indexExpression = self.theNewChild;
    } else if (boolArrayElementAssignment.expression == self.theOldChild) {
        boolArrayElementAssignment.expression = self.theNewChild;
    } else {
        [NSException raise:[self oldChildDoesNotExistException] format:@"OldChild"];
    }
}
- (void) visitWhileEndWhile:(WhileEndWhile *)whileEndWhile {
    if (whileEndWhile.expression == self.theOldChild) {
        whileEndWhile.expression = self.theNewChild;
    } else {
        [NSException raise:[self oldChildDoesNotExistException] format:@"OldChild"];
    }
}
- (void) visitIfThenEndIf:(IfThenEndIf *)ifThenEndIf {
    if (ifThenEndIf.expression == self.theOldChild) {
        ifThenEndIf.expression = self.theNewChild;
    } else {
        [NSException raise:[self oldChildDoesNotExistException] format:@"OldChild"];
    }
}
- (void) visitIfThenElseEndIf:(IfThenElseEndIf *)ifThenElseEndIf {
    if (ifThenElseEndIf.expression == self.theOldChild) {
        ifThenElseEndIf.expression = self.theNewChild;
    } else {
        [NSException raise:[self oldChildDoesNotExistException] format:@"OldChild"];
    }
}

@end
