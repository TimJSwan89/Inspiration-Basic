//
//  statementFlatteningVisitor.m
//  InspirationBasic
//
//  Created by Timothy Swan on 6/3/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StatementFindOrReplaceVariables.h"

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

@implementation StatementFindOrReplaceVariables

- (id) init {
    if (self = [super init]) {
        self.variables = [[NSMutableArray alloc] init];
    }
    return self;
}

/*
 4. int var
 5. bool var
 6. int array var
 7. bool array var
 */

- (NSMutableArray *) findVariables:(id <Statement>)statement withType:(int)type {
    self.type = type;
    [statement accept:self];
    return self.variables;
}

- (void) addVariable:(NSString *)variable {
    bool exists = false;
    for (int i = 0; i < self.variables.count; i++)
        if ([((NSString *) self.variables[i]) isEqualToString:variable]) {
            exists = true;
            break;
        }
    if (!exists)
        [self.variables addObject:variable];
}

- (void) replaceVariable:(id <Statement>)statement withVariable:(NSString *)variable {
    self.type = 0;
    self.replacementVariable = variable;
    [statement accept:self];
}

- (void) visitStatementList:(StatementList *)statementList {
    if (self.type == 0)
        [NSException raise:@"Invalid type value (see visitStatementList in StatementFindOrReplaceVariables)" format:@"value of %d is invalid", self.type];
    for (int i = 0; i < statementList.statementList.count; i++)
         [((id <Statement>)statementList.statementList[i]) accept:self];
}
- (void) visitPrintInt:(PrintInt *)printInt {}
- (void) visitPrintBool:(PrintBool *)printBool {}
- (void) visitIntAssigment:(IntAssignment *)intAssignment {
    if (self.type == 4)
        [self addVariable:intAssignment.variable];
    else if (self.type == 0)
        intAssignment.variable = self.replacementVariable;
}
- (void) visitBoolAssigment:(BoolAssignment *)boolAssignment {
    if (self.type == 5)
        [self addVariable:boolAssignment.variable];
    else if (self.type == 0)
        boolAssignment.variable = self.replacementVariable;
}
- (void) visitIntArrayElementAssignment:(IntArrayElementAssignment *)intArrayElementAssignment {
    if (self.type == 6)
        [self addVariable:intArrayElementAssignment.variable];
    else if (self.type == 0)
        intArrayElementAssignment.variable = self.replacementVariable;
}
- (void) visitBoolArrayElementAssignment:(BoolArrayElementAssignment *)boolArrayElementAssignment {
    if (self.type == 7)
        [self addVariable:boolArrayElementAssignment.variable];
    else if (self.type == 0)
        boolArrayElementAssignment.variable = self.replacementVariable;
}
- (void) visitWhileEndWhile:(WhileEndWhile *)whileEndWhile {
    [whileEndWhile.loopStatements accept:self];
}
- (void) visitIfThenEndIf:(IfThenEndIf *)ifThenEndIf {
    [ifThenEndIf.thenStatements accept:self];
}
- (void) visitIfThenElseEndIf:(IfThenElseEndIf *)ifThenElseEndIf {
    [ifThenElseEndIf.thenStatements accept:self];
    [ifThenElseEndIf.elseStatements accept:self];
}

@end
