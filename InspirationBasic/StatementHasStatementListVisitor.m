//
//  statementFlatteningVisitor.m
//  InspirationBasic
//
//  Created by Timothy Swan on 6/3/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StatementHasStatementListVisitor.h"
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

@implementation StatementHasStatementListVisitor

- (id) init {
    if (self = [super init]) {
        self.hasStatementList = true;
    }
    return self;
}
- (bool) hasStatementList:(id<Statement>)statement {
    [statement accept:self];
    return self.hasStatementList;
}
- (void) visitStatementList:(StatementList *)statementList {
    self.hasStatementList = true;
}
- (void) visitPrintInt:(PrintInt *)printInt {
    self.hasStatementList = false;
}
- (void) visitPrintBool:(PrintBool *)printBool {
    self.hasStatementList = false;
}
- (void) visitIntAssigment:(IntAssignment *)intAssignment {
    self.hasStatementList = false;
}
- (void) visitBoolAssigment:(BoolAssignment *)boolAssignment {
    self.hasStatementList = false;
}
- (void) visitIntArrayElementAssigment:(IntArrayElementAssignment *)intArrayElementAssignment {
    self.hasStatementList = false;
}
- (void) visitBoolArrayElementAssigment:(BoolArrayElementAssignment *)boolArrayElementAssignment {
    self.hasStatementList = false;
}
- (void) visitWhileEndWhile:(WhileEndWhile *)whileEndWhile {
    self.hasStatementList = true;
}
- (void) visitIfThenEndIf:(IfThenEndIf *)ifThenEndIf {
    self.hasStatementList = true;
}
- (void) visitIfThenElseEndIf:(IfThenElseEndIf *)ifThenElseEndIf {
    self.hasStatementList = true;
}

@end
