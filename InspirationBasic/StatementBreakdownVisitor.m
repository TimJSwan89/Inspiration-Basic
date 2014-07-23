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
        self.types = [[NSMutableArray alloc] init];
        self.elements = [[NSMutableArray alloc] init];
        self.strings = [[NSMutableArray alloc] init];
        self.expressionBreakdownVisitor = [[ExpressionBreakdownVisitor alloc] init];
    }
    return self;
}

- (void) generateBreakdown:(id <Statement>)statement {
    [statement accept:self];
}

- (NSString *) intExpressionToString:(id <IntExpression>) intExpression {
    ExpressionDisplayStringVisitor * visitor = [[ExpressionDisplayStringVisitor alloc] init];
    return [visitor getStringForInt:intExpression];
}

- (NSString *) boolExpressionToString:(id <BoolExpression>) boolExpression {
    ExpressionDisplayStringVisitor * visitor = [[ExpressionDisplayStringVisitor alloc] init];
    return [visitor getStringForBool:boolExpression];
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

- (void) visitPrintInt:(PrintInt *)printInt {
    [self.types addObject:[NSNumber numberWithInt:1]];
    [self.elements addObject:printInt];
    [self.strings addObject:@"print"];
    
    [self.types addObject:[self.expressionBreakdownVisitor checkIntSingleComponent:printInt.expression]];
    [self.elements addObject:printInt.expression];
    [self.strings addObject:[self intExpressionToString:printInt.expression]];
}

- (void) visitPrintBool:(PrintBool *)printBool {
    [self.types addObject:[NSNumber numberWithInt:1]];
    [self.elements addObject:printBool];
    [self.strings addObject:@"print"];
    
    [self.types addObject:[self.expressionBreakdownVisitor checkBoolSingleComponent:printBool.expression]];
    [self.elements addObject:printBool.expression];
    [self.strings addObject:[self boolExpressionToString:printBool.expression]];
}

- (void) visitIntAssigment:(IntAssignment *)intAssignment {
    [self.types addObject:[NSNumber numberWithInt:4]];
    [self.elements addObject:intAssignment.variable];
    [self.strings addObject:intAssignment.variable];
    
    [self.types addObject:[NSNumber numberWithInt:1]];
    [self.elements addObject:intAssignment];
    [self.strings addObject:@"="];
    
    [self.types addObject:[self.expressionBreakdownVisitor checkIntSingleComponent:intAssignment.expression]];
    [self.elements addObject:intAssignment.expression];
    [self.strings addObject:[self intExpressionToString:intAssignment.expression]];
}

- (void) visitBoolAssigment:(BoolAssignment *)boolAssignment {
    [self.types addObject:[NSNumber numberWithInt:5]];
    [self.elements addObject:boolAssignment.variable];
    [self.strings addObject:boolAssignment.variable];
    
    [self.types addObject:[NSNumber numberWithInt:1]];
    [self.elements addObject:boolAssignment];
    [self.strings addObject:@"="];
    
    [self.types addObject:[self.expressionBreakdownVisitor checkBoolSingleComponent:boolAssignment.expression]];
    [self.elements addObject:boolAssignment.expression];
    [self.strings addObject:[self boolExpressionToString:boolAssignment.expression]];
}

- (void) visitIntArrayElementAssigment:(IntArrayElementAssignment *)intArrayElementAssignment {
    [self.types addObject:[NSNumber numberWithInt:6]];
    [self.elements addObject:intArrayElementAssignment.variable];
    [self.strings addObject:intArrayElementAssignment.variable];
    
    [self.types addObject:[self.expressionBreakdownVisitor checkIntSingleComponent:intArrayElementAssignment.indexExpression]];
    [self.elements addObject:intArrayElementAssignment.indexExpression];
    [self.strings addObject:[@"[" stringByAppendingString:([[self intExpressionToString:intArrayElementAssignment.indexExpression] stringByAppendingString:@"]"])]];
    
    [self.types addObject:[NSNumber numberWithInt:1]];
    [self.elements addObject:intArrayElementAssignment];
    [self.strings addObject:@"="];
    
    [self.types addObject:[self.expressionBreakdownVisitor checkIntSingleComponent:intArrayElementAssignment.expression]];
    [self.elements addObject:intArrayElementAssignment.expression];
    [self.strings addObject:[self intExpressionToString:intArrayElementAssignment.expression]];
}

- (void) visitBoolArrayElementAssigment:(BoolArrayElementAssignment *)boolArrayElementAssignment {
    [self.types addObject:[NSNumber numberWithInt:7]];
    [self.elements addObject:boolArrayElementAssignment.variable];
    [self.strings addObject:boolArrayElementAssignment.variable];
    
    [self.types addObject:[self.expressionBreakdownVisitor checkIntSingleComponent:boolArrayElementAssignment.indexExpression]];
    [self.elements addObject:boolArrayElementAssignment.indexExpression];
    [self.strings addObject:[@"[" stringByAppendingString:([[self intExpressionToString:boolArrayElementAssignment.indexExpression] stringByAppendingString:@"]"])]];
    
    [self.types addObject:[NSNumber numberWithInt:1]];
    [self.elements addObject:boolArrayElementAssignment];
    [self.strings addObject:@"="];
    
    [self.types addObject:[self.expressionBreakdownVisitor checkBoolSingleComponent:boolArrayElementAssignment.expression]];
    [self.elements addObject:boolArrayElementAssignment.expression];
    [self.strings addObject:[self boolExpressionToString:boolArrayElementAssignment.expression]];
}

- (void) visitIfThenEndIf:(IfThenEndIf *)ifThenEndIf {
    [self.types addObject:[NSNumber numberWithInt:1]];
    [self.elements addObject:ifThenEndIf];
    [self.strings addObject:@"if"];
    
    [self.types addObject:[self.expressionBreakdownVisitor checkBoolSingleComponent:ifThenEndIf.expression]];
    [self.elements addObject:ifThenEndIf.expression];
    [self.strings addObject:[self boolExpressionToString:ifThenEndIf.expression]];
}

- (void) visitIfThenElseEndIf:(IfThenElseEndIf *)ifThenElseEndIf {
    [self.types addObject:[NSNumber numberWithInt:1]];
    [self.elements addObject:ifThenElseEndIf];
    [self.strings addObject:@"if"];
    
    [self.types addObject:[self.expressionBreakdownVisitor checkBoolSingleComponent:ifThenElseEndIf.expression]];
    [self.elements addObject:ifThenElseEndIf.expression];
    [self.strings addObject:[self boolExpressionToString:ifThenElseEndIf.expression]];
}

- (void) visitStatementList:(StatementList *)statementList {}

- (void) visitWhileEndWhile:(WhileEndWhile *)whileEndWhile {
    [self.types addObject:[NSNumber numberWithInt:1]];
    [self.elements addObject:whileEndWhile];
    [self.strings addObject:@"while"];
    
    [self.types addObject:[self.expressionBreakdownVisitor checkBoolSingleComponent:whileEndWhile.expression]];
    [self.elements addObject:whileEndWhile.expression];
    [self.strings addObject:[self boolExpressionToString:whileEndWhile.expression]];
}

@end
