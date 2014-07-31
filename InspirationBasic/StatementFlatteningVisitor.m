//
//  statementFlatteningVisitor.m
//  InspirationBasic
//
//  Created by Timothy Swan on 6/3/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StatementFlatteningVisitor.h"
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

@implementation StatementFlatteningVisitor

- (id) initWithIndentationString:(NSString *)indentation {
    if (self = [super init]) {
        self.flattenedList = [[NSMutableArray alloc] init];
        self.indentation = -1;
        self.indentString = indentation;
    }
    return self;
}

- (NSString *) getIndentation {
    NSString * string = @"";
    for (int i = 0; i < self.indentation; i++)
        string = [string stringByAppendingString:self.indentString];
    return string;
}

- (NSMutableArray *) getFlattenedList:(id <Statement>)statement {
    [statement accept:self];
    return self.flattenedList;
}

- (NSString *) intExpressionToString:(id <IntExpression>) intExpression {
    ExpressionDisplayStringVisitor * visitor = [[ExpressionDisplayStringVisitor alloc] init];
    return [visitor getStringForInt:intExpression];
}

- (NSString *) boolExpressionToString:(id <BoolExpression>) boolExpression {
    ExpressionDisplayStringVisitor * visitor = [[ExpressionDisplayStringVisitor alloc] init];
    return [visitor getStringForBool:boolExpression];
}

- (void) visitPrintInt:(PrintInt *)printInt {
    NSString * string = [self getIndentation];
    string = [string stringByAppendingString:@"print "];
    string = [string stringByAppendingString:[self intExpressionToString:printInt.expression]];
    //string = [string stringByAppendingString:@";"];
    [self.flattenedList addObject:[[StatementAndDisplayString alloc] initWithStatement:printInt andDisplayString:string]];
}

- (void) visitPrintBool:(PrintBool *)printBool {
    NSString * string = [self getIndentation];
    string = [string stringByAppendingString:@"print "];
    string = [string stringByAppendingString:[self boolExpressionToString:printBool.expression]];
    //string = [string stringByAppendingString:@";"];
    [self.flattenedList addObject:[[StatementAndDisplayString alloc] initWithStatement:printBool andDisplayString:string]];
}

- (void) visitIntAssigment:(IntAssignment *)intAssignment {
    NSString * string = [self getIndentation];
    string = [string stringByAppendingString:intAssignment.variable];
    string = [string stringByAppendingString:@" = "];
    string = [string stringByAppendingString:[self intExpressionToString:intAssignment.expression]];
    //string = [string stringByAppendingString:@";"];
    [self.flattenedList addObject:[[StatementAndDisplayString alloc] initWithStatement:intAssignment andDisplayString:string]];
}

- (void) visitBoolAssigment:(BoolAssignment *)boolAssignment {
    NSString * string = [self getIndentation];
    string = [string stringByAppendingString:boolAssignment.variable];
    string = [string stringByAppendingString:@" = "];
    string = [string stringByAppendingString:[self boolExpressionToString:boolAssignment.expression]];
    //string = [string stringByAppendingString:@";"];
    [self.flattenedList addObject:[[StatementAndDisplayString alloc] initWithStatement:boolAssignment andDisplayString:string]];
}

- (void) visitIntArrayElementAssignment:(IntArrayElementAssignment *)intArrayElementAssignment {
    NSString * string = [self getIndentation];
    string = [string stringByAppendingString:intArrayElementAssignment.variable];
    string = [string stringByAppendingString:@"["];
    string = [string stringByAppendingString:[self intExpressionToString:intArrayElementAssignment.indexExpression]];
    string = [string stringByAppendingString:@"] = "];
    string = [string stringByAppendingString:[self intExpressionToString:intArrayElementAssignment.expression]];
    //string = [string stringByAppendingString:@";"];
    [self.flattenedList addObject:[[StatementAndDisplayString alloc] initWithStatement:intArrayElementAssignment andDisplayString:string]];
}

- (void) visitBoolArrayElementAssignment:(BoolArrayElementAssignment *)boolArrayElementAssignment {
    NSString * string = [self getIndentation];
    string = [string stringByAppendingString:boolArrayElementAssignment.variable];
    string = [string stringByAppendingString:@"["];
    string = [string stringByAppendingString:[self intExpressionToString:boolArrayElementAssignment.indexExpression]];
    string = [string stringByAppendingString:@"] = "];
    string = [string stringByAppendingString:[self boolExpressionToString:boolArrayElementAssignment.expression]];
    //string = [string stringByAppendingString:@";"];
    [self.flattenedList addObject:[[StatementAndDisplayString alloc] initWithStatement:boolArrayElementAssignment andDisplayString:string]];
}

- (void) visitIfThenElseEndIf:(IfThenElseEndIf *)ifThenElseEndIf {
    NSString * string = [self getIndentation];
    string = [string stringByAppendingString:@"if "];
    string = [string stringByAppendingString:[self boolExpressionToString:ifThenElseEndIf.expression]];
    string = [string stringByAppendingString:@" then"];
    [self.flattenedList addObject:[[StatementAndDisplayString alloc] initWithStatement:ifThenElseEndIf andDisplayString:string]];
    
    [ifThenElseEndIf.thenStatements accept:self];
    
    string = [self getIndentation];
    string = [string stringByAppendingString:@"else"];
    [self.flattenedList addObject:[[StatementAndDisplayString alloc] initWithStatement:ifThenElseEndIf andDisplayString:string]];
    
    [ifThenElseEndIf.elseStatements accept:self];
}

- (void) visitIfThenEndIf:(IfThenEndIf *)ifThenEndIf {
    NSString * string = [self getIndentation];
    string = [string stringByAppendingString:@"if "];
    string = [string stringByAppendingString:[self boolExpressionToString:ifThenEndIf.expression]];
    string = [string stringByAppendingString:@" then"];
    [self.flattenedList addObject:[[StatementAndDisplayString alloc] initWithStatement:ifThenEndIf andDisplayString:string]];
    
    [ifThenEndIf.thenStatements accept:self];
}

- (void) visitStatementList:(StatementList *)statementList {
    self.indentation++;
    for (int i = 0; i < statementList.statementList.count; i++) {
        [statementList.statementList[i] accept:self];
        NSLog(@"%@%d", @"Flattener statement: ", i);
    }
    self.indentation--;
}

- (void) visitWhileEndWhile:(WhileEndWhile *)whileEndWhile {
    NSString * string = [self getIndentation];
    string = [string stringByAppendingString:@"while "];
    string = [string stringByAppendingString:[self boolExpressionToString:whileEndWhile.expression]];
    string = [string stringByAppendingString:@":"];
    [self.flattenedList addObject:[[StatementAndDisplayString alloc] initWithStatement:whileEndWhile andDisplayString:string]];
    [whileEndWhile.loopStatements accept:self];
}

@end
