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

@class IntAssignment;
@class BoolAssignment;
@class IntArrayElementAssignment;
@class BoolArrayElementAssignment;
@class IfThenElseEndIf;
@class IfThenEndIf;
@class StatementList;
@class WhileEndWhile;

@interface StatementFlatteningVisitor : NSObject <StatementVisitor>

@property (nonatomic) NSMutableArray * flattenedList;
@property (nonatomic) int indentation;
@property (nonatomic) NSString * indentString;

- (id) initWithIndentationString:(NSString *)indentation;
- (NSMutableArray *) getFlattenedList:(id <Statement>)statement;

- (void) visitPrintInt:(PrintInt *)printInt;
- (void) visitPrintBool:(PrintInt *)printBool;
- (void) visitIntAssigment:(IntAssignment *)intAssignment;
- (void) visitBoolAssigment:(BoolAssignment *)boolAssignment;
- (void) visitIntArrayElementAssignment:(IntArrayElementAssignment *)intArrayElementAssignment;
- (void) visitBoolArrayElementAssignment:(BoolArrayElementAssignment *)boolArrayElementAssignment;
- (void) visitIfThenElseEndIf:(IfThenElseEndIf *)ifThenElseEndIf;
- (void) visitIfThenEndIf:(IfThenEndIf *)ifThenEndIf;
- (void) visitStatementList:(StatementList *)statementList;
- (void) visitWhileEndWhile:(WhileEndWhile *)whileEndWhile;

@end
