//
//  statementFlatteningVisitor.m
//  InspirationBasic
//
//  Created by Timothy Swan on 6/3/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StatementDebugStringVisitor.h"

#import "ExpressionDebugStringVisitor.h"

#import "IntExpression.h"
#import "BoolExpression.h"

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

@implementation StatementDebugStringVisitor

- (id) init {
    if (self = [super init]) {
        self.displayString = @"";
        self.assertingParent = nil;
    }
    return self;
}

- (void) assertParent:(id <Statement>)statement {
    if (statement == nil) { // Statement doesn't even exist, major error
        self.displayString = [self.displayString stringByAppendingString:@":(ERROR, statement is nil)"];
    } else {
        if (self.assertingParent != statement.parent) { // Parents don't match in general.
            if (self.assertingParent == nil) { // Parent was supposed to be nil but was set to something.
                self.displayString = [self.displayString stringByAppendingString:@":(ERROR, parent should be nil)"];
            } else {
                if (statement.parent == nil) { // Parent was supposed to be set to something but was nil.
                    self.displayString = [self.displayString stringByAppendingString:@":(ERROR, parent should be set)"];
                } else { // Parent was supposed to be set to something but was set to something else.
                    self.displayString = [self.displayString stringByAppendingString:@":(ERROR, parent is set to the incorrect object)"];
                }
            }
        }
    }
}

- (void) assertParentFor:(id <Statement>)statement withStatementList:(StatementList *)list AndDisplayString:(NSString *)string {
    [self assertParent:statement];
    id <Statement> saveAssertingParent = self.assertingParent;
    self.assertingParent = statement;
    self.displayString = [self.displayString stringByAppendingString:string];
    if (list != nil)
        [list accept:self];
    self.assertingParent = saveAssertingParent;
}

- (void) visitPrintInt:(PrintInt *)printInt {
    [self assertParentFor:printInt withStatementList:nil AndDisplayString:@"P"];
}

- (void) visitPrintBool:(PrintBool *)printBool {
    [self assertParentFor:printBool withStatementList:nil AndDisplayString:@"p"];
}

- (void) visitIntAssigment:(IntAssignment *)intAssignment {
    [self assertParentFor:intAssignment withStatementList:nil AndDisplayString:@"A"];
}

- (void) visitBoolAssigment:(BoolAssignment *)boolAssignment {
    [self assertParentFor:boolAssignment withStatementList:nil AndDisplayString:@"a"];
}

- (void) visitIntArrayElementAssigment:(IntArrayElementAssignment *)intArrayElementAssignment {
    [self assertParentFor:intArrayElementAssignment withStatementList:nil AndDisplayString:@"E"];
}

- (void) visitBoolArrayElementAssigment:(BoolArrayElementAssignment *)boolArrayElementAssignment {
    [self assertParentFor:boolArrayElementAssignment withStatementList:nil AndDisplayString:@"e"];
}

- (void) visitIfThenElseEndIf:(IfThenElseEndIf *)ifThenElseEndIf {
    [self assertParent:ifThenElseEndIf];
    id <Statement> saveAssertingParent = self.assertingParent;
    self.assertingParent = ifThenElseEndIf;
    self.displayString = [self.displayString stringByAppendingString:@"F("];
    [ifThenElseEndIf.thenStatements accept:self];
    self.displayString = [self.displayString stringByAppendingString:@","];
    [ifThenElseEndIf.elseStatements accept:self];
    self.displayString = [self.displayString stringByAppendingString:@")"];
    self.assertingParent = saveAssertingParent;
}

- (void) visitIfThenEndIf:(IfThenEndIf *)ifThenEndIf {
    [self assertParentFor:ifThenEndIf withStatementList:ifThenEndIf.thenStatements AndDisplayString:@"F"];
}

- (void) visitStatementList:(StatementList *)statementList {
    [self assertParent:statementList];
    id <Statement> saveAssertingParent = self.assertingParent;
    self.assertingParent = statementList;
    self.displayString = [self.displayString stringByAppendingString:@"{"];
    for (int i = 0; i < statementList.statementList.count; i++)
        [statementList.statementList[i] accept:self];
    self.displayString = [self.displayString stringByAppendingString:@"}"];
    self.assertingParent = saveAssertingParent;
}

- (void) visitWhileEndWhile:(WhileEndWhile *)whileEndWhile {
    [self assertParentFor:whileEndWhile withStatementList:whileEndWhile.loopStatements AndDisplayString:@"W"];
}

@end
