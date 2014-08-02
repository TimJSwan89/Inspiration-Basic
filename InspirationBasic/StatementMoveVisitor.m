//
//  statementFlatteningVisitor.m
//  InspirationBasic
//
//  Created by Timothy Swan on 6/3/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StatementMoveVisitor.h"
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

@implementation StatementMoveVisitor

- (id) initWithDirection:(bool)up andStatement:(id <Statement>)statement {
    if (self = [super init]) {
        self.targetStatement = statement;
        self.up = up;
    }
    return self;
}
- (void) move {
    StatementList * list = (StatementList *) self.targetStatement.parent;
    self.referenceStatement = self.targetStatement;
    self.insertAtEnd = false;
    [list accept:self];
}
- (void) visitStatementList:(StatementList *)statementList {
    if (self.insertAtEnd) {
        (self.up) ?
            [statementList.statementList addObject:self.targetStatement] :
            [statementList.statementList insertObject:self.targetStatement atIndex:0];
        self.targetStatement.parent = statementList;
        self.insertAtEnd = false;
    } else {
        long index = [statementList.statementList indexOfObject:self.referenceStatement];
        if (self.referenceStatement == self.targetStatement) {
            [statementList.statementList removeObjectAtIndex:index];
            index += self.up ? -1 : 0;
        } else {
            index += self.up ? 0 : 1;
            [statementList.statementList insertObject:self.targetStatement atIndex:index];
            self.targetStatement.parent = statementList;
            return;
        }
        if (index >= 0 && index < statementList.statementList.count) {
            id <Statement> statement = [statementList.statementList objectAtIndex:index];
            self.insertAtEnd = true;
            [statement accept:self];
            if (self.insertAtEnd) {
                index += self.up ? 0 : 1;
                [statementList.statementList insertObject:self.targetStatement atIndex:index];
            }
        } else {
            if (statementList.parent == nil) {
                index += self.up ? 1 : 0;
                [statementList.statementList insertObject:self.targetStatement atIndex:index];
            } else {
                self.referenceStatement = statementList;
                [statementList.parent accept:self];
            }
        }
    }
}
- (void) visitPrintInt:(PrintInt *)printInt { }
- (void) visitPrintBool:(PrintBool *)printBool { }
- (void) visitIntAssigment:(IntAssignment *)intAssignment { }
- (void) visitBoolAssigment:(BoolAssignment *)boolAssignment { }
- (void) visitIntArrayElementAssignment:(IntArrayElementAssignment *)intArrayElementAssignment { }
- (void) visitBoolArrayElementAssignment:(BoolArrayElementAssignment *)boolArrayElementAssignment { }
- (void) visitWhileEndWhile:(WhileEndWhile *)whileEndWhile {
    if (self.targetStatement == self.referenceStatement)
        [whileEndWhile.loopStatements accept:self];
    else {
        self.referenceStatement = whileEndWhile;
        [whileEndWhile.parent accept:self];
    }
}
- (void) visitIfThenEndIf:(IfThenEndIf *)ifThenEndIf {
    if (self.targetStatement == self.referenceStatement)
        [ifThenEndIf.thenStatements accept:self];
    else {
        self.referenceStatement = ifThenEndIf;
        [ifThenEndIf.parent accept:self];
    }
}
- (void) visitIfThenElseEndIf:(IfThenElseEndIf *)ifThenElseEndIf {
    if (self.targetStatement == self.referenceStatement)
        [(self.up ? ifThenElseEndIf.elseStatements : ifThenElseEndIf.thenStatements) accept:self];
    else {
        if (ifThenElseEndIf.thenStatements == self.referenceStatement && !self.up) {
            self.insertAtEnd = true;
            [ifThenElseEndIf.elseStatements accept:self];
        } else if (ifThenElseEndIf.elseStatements == self.referenceStatement && self.up) {
            self.insertAtEnd = true;
            [ifThenElseEndIf.thenStatements accept:self];
        } else {
            self.referenceStatement = ifThenElseEndIf;
            [ifThenElseEndIf.parent accept:self];
        }
    }
}

/*
- (void) move {
    
 
    // We need to store this so we can tell if we are in the else statements or the then statements in the IfThenElseEndIf
    self.originalParentList = (StatementList *) self.targetStatement.parent;
    
    // Assume originalParentList is a non-nil non-empty statement list
    self.insertAtEnd = false;
        
    // Remove the target statement from the list
    self.targetIndex = [self.originalParentList.statementList indexOfObject:self.targetStatement];
    bool top = self.targetIndex == 0 && self.up;
    bool bottom = self.targetIndex == self.originalParentList.statementList.count - 1 && !self.up;
    if ((top || bottom) && self.originalParentList.parent == nil) {
        return;
    }
    [self.originalParentList.statementList removeObjectAtIndex: self.targetIndex];
    if (top || bottom) {
        //self.targetIndex = [self.originalParentList.statementList indexOfObject:self.originalParentList] + (bottom ? 1 : 0);
        self.targetIndex = -2;
        [self.originalParentList.parent accept:self];
    } else {
        self.targetIndex += self.up ? -1 : 1;
        [self.originalParentList accept:self];
    }
 
}

- (void) visitStatementList:(StatementList *)statementList { // Always Entering (Never Exiting)
    
    
    if (self.targetIndex == -1) { // Entering from external
        self.done = true;
        self.targetStatement.parent = statementList;
        if (self.up) {
            [statementList.statementList addObject:self.targetStatement];
        } else {
            [statementList.statementList insertObject:self.targetStatement atIndex:0];
        }
    } else if (self.targetIndex == -2) { // Exiting
            
    } else { // Moving from within
        self.done = false;
        int index = self.targetIndex;
        self.targetIndex = -1;
        [((id <Statement>) [statementList.statementList objectAtIndex:index]) accept:self];
        if (!self.done) {
            [statementList.statementList insertObject:self.targetStatement atIndex:self.targetIndex];
            self.targetStatement.parent = statementList;
        }
    }
    return;
    
    if (self.done) {return;}
    if (self.insertAtEnd) {
        if (self.up) {
            [statementList.statementList addObject:self.targetStatement];
        } else {
            [statementList.statementList insertObject:self.targetStatement atIndex:0];
            self.targetStatement.parent = statementList;
        }
    } else {
        self.insertAtEnd = true;
        [((StatementList *) statementList.statementList[self.targetIndex]) accept:self];
        self.insertAtEnd = false;
        if(!self.done) {
            [statementList.statementList insertObject:self.targetStatement atIndex:self.targetIndex];
            self.targetStatement.parent = statementList;
        }
    }
    self.done = true;
    
}


- (void) visitPrintInt:(PrintInt *)printInt { }
- (void) visitPrintBool:(PrintBool *)printBool { }
- (void) visitIntAssigment:(IntAssignment *)intAssignment { }
- (void) visitBoolAssigment:(BoolAssignment *)boolAssignment { }
- (void) visitIntArrayElementAssigment:(IntArrayElementAssignment *)intArrayElementAssignment { }
- (void) visitBoolArrayElementAssigment:(BoolArrayElementAssignment *)boolArrayElementAssignment { }

- (void) visitWhileEndWhile:(WhileEndWhile *)whileEndWhile {
    if (self.targetIndex == -1) // Entering
        [whileEndWhile.loopStatements accept:self];
    else // Exiting
        [whileEndWhile.parent accept:self];
}

- (void) visitIfThenEndIf:(IfThenEndIf *)ifThenEndIf {
    if (self.targetIndex == -1) // Entering
        [ifThenEndIf.thenStatements accept:self];
    else // Exiting
        [ifThenEndIf.parent accept:self];
}
- (void) visitIfThenElseEndIf:(IfThenElseEndIf *)ifThenElseEndIf {
    if (self.targetIndex == -1) { // Entering
        if (self.up) {
            [ifThenElseEndIf.elseStatements accept:self];
        } else {
            [ifThenElseEndIf.thenStatements accept:self];
        }
    } else { // Exiting
        if (self.originalParentList == ifThenElseEndIf.elseStatements && self.up) {
            [ifThenElseEndIf.thenStatements accept:self];
        } else if (self.originalParentList == ifThenElseEndIf.thenStatements && !self.up) {
            [ifThenElseEndIf.elseStatements accept:self];
        } else {
            [ifThenElseEndIf.parent accept:self];
        }
    }
}
*/

/*
- (id) initWithDirection:(bool)up andStatement:(id <Statement>)statement {
    if (self = [super init]) {
        self.insertionStatement = statement;
        self.referenceStatement = statement;
        self.up = up;
    }
    return self;
}
- (void) move {
    if (self.insertionStatement.parent != nil) {
        [self.insertionStatement.parent accept:self];
        self.insertionStatement.parent = self.referenceStatement.parent;
    }
}

- (void) tryParentNilException:(id)parent {
    if (parent == nil) {
        NSString * exceptionString = [[parent class] description];
        exceptionString = [exceptionString stringByAppendingString:@" has nil parent, see 'StatementMoveVisitor'. "];
        [NSException raise:[exceptionString stringByAppendingString:@"[raise]"] format:@"%@", [exceptionString stringByAppendingString:@"[format]"]];
    }
}

- (void) visitPrintInt:(PrintInt *)printInt { [self tryParentNilException:printInt.parent]; }
- (void) visitPrintBool:(PrintBool *)printBool { [self tryParentNilException:printBool.parent]; }
- (void) visitIntAssigment:(IntAssignment *)intAssignment { [self tryParentNilException:intAssignment.parent]; }
- (void) visitBoolAssigment:(BoolAssignment *)boolAssignment { [self tryParentNilException:boolAssignment.parent]; }
- (void) visitIntArrayElementAssigment:(IntArrayElementAssignment *)intArrayElementAssignment { [self tryParentNilException:intArrayElementAssignment.parent]; }
- (void) visitBoolArrayElementAssigment:(BoolArrayElementAssignment *)boolArrayElementAssignment { [self tryParentNilException:boolArrayElementAssignment.parent]; }

- (void) visitIfThenElseEndIf:(IfThenElseEndIf *)ifThenElseEndIf {
    [self tryParentNilException:ifThenElseEndIf.parent];
    if (self.referenceStatement == ifThenElseEndIf.elseStatements && self.up){
        [ifThenElseEndIf.thenStatements.statementList addObject:self.insertionStatement];
    } else if (self.referenceStatement == ifThenElseEndIf.thenStatements && !self.up){
        [ifThenElseEndIf.elseStatements.statementList insertObject:self.insertionStatement atIndex:0];
    } else {
        self.referenceStatement = ifThenElseEndIf;
        [self.referenceStatement accept:self];
    }
}
- (void) visitIfThenEndIf:(IfThenEndIf *)ifThenEndIf {
    [self tryParentNilException:ifThenEndIf.parent];
    self.referenceStatement = ifThenEndIf;
    [ifThenEndIf.parent accept:self];
}
- (void) visitStatementList:(StatementList *)statementList {
    if (![statementList isKindOfClass:[Program class]]) {
        [self tryParentNilException:statementList.parent];
    }
    int index = [statementList.statementList indexOfObject:self.referenceStatement];
    if (self.up ? index > 0 : index < statementList.statementList.count - 1) {
        [statementList.statementList removeObjectAtIndex:index];
        [statementList.statementList insertObject:self.insertionStatement atIndex:(self.up ? index - 1 : index + 1)];
    } else if(statementList.parent != nil) {
        [statementList.statementList removeObjectAtIndex:index];
        [statementList.parent accept:self];
    }
    self.referenceStatement = statementList;
}
- (void) visitWhileEndWhile:(WhileEndWhile *)whileEndWhile {
    [self tryParentNilException:whileEndWhile.parent];
    self.referenceStatement = whileEndWhile;
    [whileEndWhile.parent accept:self];
}*/
@end
