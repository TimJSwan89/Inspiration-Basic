//
//  statementFlatteningVisitor.m
//  InspirationBasic
//
//  Created by Timothy Swan on 6/3/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StatementDeleteVisitor.h"
#import "ExpressionDisplayStringVisitor.h"
#import "StatementAndDisplayString.h"

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

@implementation StatementDeleteVisitor

- (id) initWithStatement:(id <Statement>)statement and:(bool)protectChildren {
    if (self = [super init]) {
        self.targetStatement = statement;
        self.protectChildren = protectChildren;
    }
    return self;
}
- (void) deleteStatement {
    StatementList * list = (StatementList *) self.targetStatement.parent;
    if (self.protectChildren)
        [self.targetStatement accept:self];
    [list.statementList removeObject:self.targetStatement];
}
- (void) copyStatementsFrom:(StatementList *)inner toParentListOf:(id <Statement>)statement {
    StatementList * list = (StatementList *) statement.parent;
    long index = [list.statementList indexOfObject:statement];
    for (long i = inner.statementList.count - 1; i >= 0; i--) {
        [list.statementList insertObject:inner.statementList[i] atIndex:index];
        ((id <Statement>) inner.statementList[i]).parent = list;
    }
}
- (void) visitStatementList:(StatementList *)statementList {
    
}
- (void) visitPrintInt:(PrintInt *)printInt { }
- (void) visitPrintBool:(PrintBool *)printBool { }
- (void) visitIntAssigment:(IntAssignment *)intAssignment { }
- (void) visitBoolAssigment:(BoolAssignment *)boolAssignment { }
- (void) visitIntArrayElementAssignment:(IntArrayElementAssignment *)intArrayElementAssignment { }
- (void) visitBoolArrayElementAssignment:(BoolArrayElementAssignment *)boolArrayElementAssignment { }
- (void) visitWhileEndWhile:(WhileEndWhile *)whileEndWhile {
    [self copyStatementsFrom:whileEndWhile.loopStatements toParentListOf:whileEndWhile];
}
- (void) visitIfThenEndIf:(IfThenEndIf *)ifThenEndIf {
    [self copyStatementsFrom:ifThenEndIf.thenStatements toParentListOf:ifThenEndIf];
}
- (void) visitIfThenElseEndIf:(IfThenElseEndIf *)ifThenElseEndIf {
    [self copyStatementsFrom:ifThenElseEndIf.thenStatements toParentListOf:ifThenElseEndIf];
    [self copyStatementsFrom:ifThenElseEndIf.elseStatements toParentListOf:ifThenElseEndIf];
}

@end
