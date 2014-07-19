//
//  statementFlatteningVisitor.h
//  InspirationBasic
//
//  Created by Timothy Swan on 6/3/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StatementVisitor.h"
#import "Statement.h"
#import "StatementAndDisplayString.h"
#import "ExpressionBreakdownVisitor.h"

@class IntAssignment;
@class BoolAssignment;
@class IntArrayElementAssignment;
@class BoolArrayElementAssignment;
@class IfThenElseEndIf;
@class IfThenEndIf;
@class StatementList;
@class WhileEndWhile;

@interface StatementBreakdownVisitor : NSObject <StatementVisitor>

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

@property NSMutableArray * types;
@property NSMutableArray * elements;
@property NSMutableArray * strings;

// For checking if an expression is a single component (leaf node)
// Keep in mind that we could make a seperate visitor for that if desired
@property ExpressionBreakdownVisitor * expressionBreakdownVisitor;

- (id) init;
- (void) generateBreakdown:(id <Statement>)statement;

- (void) visitPrintInt:(PrintInt *)printInt;
- (void) visitPrintBool:(PrintInt *)printBool;
- (void) visitIntAssigment:(IntAssignment *)intAssignment;
- (void) visitBoolAssigment:(BoolAssignment *)boolAssignment;
- (void) visitIntArrayElementAssigment:(IntArrayElementAssignment *)intArrayElementAssignment;
- (void) visitBoolArrayElementAssigment:(BoolArrayElementAssignment *)boolArrayElementAssignment;
- (void) visitIfThenElseEndIf:(IfThenElseEndIf *)ifThenElseEndIf;
- (void) visitIfThenEndIf:(IfThenEndIf *)ifThenEndIf;
- (void) visitStatementList:(StatementList *)statementList;
- (void) visitWhileEndWhile:(WhileEndWhile *)whileEndWhile;

@end
