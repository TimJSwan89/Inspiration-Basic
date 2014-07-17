//
//  statementFlatteningVisitor.m
//  InspirationBasic
//
//  Created by Timothy Swan on 6/3/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StatementBreakdownVisitor.h"
#import "ExpressionDisplayStringVisitor.h"
#import "StatementAndDisplayString.h"

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

@implementation StatementBreakdownVisitor

- (id) init {
    if (self = [super init]) {
    }
    return self;
}

- (NSMutableArray *) generateBreakdown:(id <Statement>)statement {
    return nil;
}

- (NSString *) intExpressionToString:(id <IntExpression>) intExpression {
    return nil;
}

- (NSString *) boolExpressionToString:(id <BoolExpression>) boolExpression {
    return nil;
}

- (void) visitPrintInt:(PrintInt *)printInt {
}

- (void) visitPrintBool:(PrintBool *)printBool {
}

- (void) visitIntAssigment:(IntAssignment *)intAssignment {
}

- (void) visitBoolAssigment:(BoolAssignment *)boolAssignment {
}

- (void) visitIntArrayElementAssigment:(IntArrayElementAssignment *)intArrayElementAssignment {
}

- (void) visitBoolArrayElementAssigment:(BoolArrayElementAssignment *)boolArrayElementAssignment {
}

- (void) visitIfThenElseEndIf:(IfThenElseEndIf *)ifThenElseEndIf {
}

- (void) visitIfThenEndIf:(IfThenEndIf *)ifThenEndIf {
}

- (void) visitStatementList:(StatementList *)statementList {
}

- (void) visitWhileEndWhile:(WhileEndWhile *)whileEndWhile {
}

@end
