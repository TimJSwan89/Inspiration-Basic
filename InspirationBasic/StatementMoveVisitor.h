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
#import "StatementList.h"

@class IntAssignment;
@class BoolAssignment;
@class IntArrayElementAssignment;
@class BoolArrayElementAssignment;
@class IfThenElseEndIf;
@class IfThenEndIf;
@class StatementList;
@class WhileEndWhile;

@interface StatementMoveVisitor : NSObject <StatementVisitor>

@property (nonatomic) bool up;
@property (nonatomic) id <Statement> targetStatement;
@property (nonatomic) id <Statement> referenceStatement;
@property (nonatomic) bool insertAtEnd;

/*
@property (nonatomic) int targetIndex;
@property (nonatomic) StatementList * originalParentList;
@property (nonatomic) bool done;
*/

- (id) initWithDirection:(bool)up andStatement:(id <Statement>)statement;
- (void) move;

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
