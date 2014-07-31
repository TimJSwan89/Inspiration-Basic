#import <Foundation/Foundation.h>
#import "StatementToDBVisitor.h"
#import "ProgramDB.h"
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

#import "IntExpression.h"
#import "BoolExpression.h"
#import "ExpressionToDBVisitor.h"

@implementation StatementToDBVisitor
- (id) init {
    if (self = [super init]) {
    }
    return self;
}
- (void) saveProgramToDB:(Program *)program context:(NSManagedObjectContext *)context {
    self.context = context;
    ProgramDB * newProgram = [NSEntityDescription insertNewObjectForEntityForName:@"ProgramDB" inManagedObjectContext:context];
    newProgram.title = program.title;
    for (int i = 0; i < program.statementList.count; i++) {
        [program.statementList[i] accept:self];
        //The following is a necessary hack for the next commented line.
        NSMutableOrderedSet * tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:newProgram.programChild];
        [tempSet addObject:self.element];
        newProgram.programChild = tempSet;
        //[newProgram addProgramChildObject:self.element];
    }
    NSError * error;
    [context save:&error];
    NSLog(@"%@",[error localizedDescription]);
    NSLog(@"Saved");
}
- (ElementDB *) createElementWithType:(NSString *)type {
    ElementDB * element = [NSEntityDescription insertNewObjectForEntityForName:@"ElementDB" inManagedObjectContext:self.context];
    element.type = type;
    element.integer = 0;
    element.string = @"";
    return element;
}

- (ElementDB *) getIntExpression:(id <IntExpression>)intExpression {
    ExpressionToDBVisitor * visitor = [[ExpressionToDBVisitor alloc] init];
    return [visitor addIntExpression:intExpression forContext:self.context];
}

- (ElementDB *) getBoolExpression:(id <BoolExpression>)boolExpression {
    ExpressionToDBVisitor * visitor = [[ExpressionToDBVisitor alloc] init];
    return [visitor addBoolExpression:boolExpression forContext:self.context];
}

- (void) visitPrintInt:(PrintInt *)printInt {
    ElementDB * element = [self createElementWithType:@"PrintInt"];
    //The following is a necessary hack for the next commented line.
    NSMutableOrderedSet * tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:element.expression];
    [tempSet addObject:[self getIntExpression:printInt.expression]];
    element.expression = tempSet;
    //[element addExpressionObject:[self getIntExpression:printInt.expression]];
    self.element = element;
}
- (void) visitPrintBool:(PrintBool *)printBool {
    ElementDB * element = [self createElementWithType:@"PrintBool"];
    //The following is a necessary hack for the next commented line.
    NSMutableOrderedSet * tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:element.expression];
    [tempSet addObject:[self getBoolExpression:printBool.expression]];
    element.expression = tempSet;
    //[element addExpressionObject:[self getBoolExpression:printBool.expression]];
    self.element = element;
}
- (void) visitIntAssigment:(IntAssignment *)intAssignment {
    ElementDB * element = [self createElementWithType:@"IntAssignment"];
    //The following is a necessary hack for the next commented line.
    NSMutableOrderedSet * tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:element.expression];
    [tempSet addObject:[self getIntExpression:intAssignment.expression]];
    element.expression = tempSet;
    element.string = intAssignment.variable;
    //[element addExpressionObject:[self getIntExpression:intAssignment.expression]];
    self.element = element;
}
- (void) visitBoolAssigment:(BoolAssignment *)boolAssignment {
    ElementDB * element = [self createElementWithType:@"BoolAssignment"];
    //The following is a necessary hack for the next commented line.
    NSMutableOrderedSet * tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:element.expression];
    [tempSet addObject:[self getBoolExpression:boolAssignment.expression]];
    element.expression = tempSet;
    element.string = boolAssignment.variable;
    //[element addExpressionObject:[self getBoolExpression:boolAssignment.expression]];
    self.element = element;
}
- (void) visitIntArrayElementAssignment:(IntArrayElementAssignment *)intArrayElementAssignment {
    ElementDB * element = [self createElementWithType:@"IntArrayElementAssignment"];
    //The following is a necessary hack for the next commented lines.
    NSMutableOrderedSet * tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:element.expression];
    [tempSet addObject:[self getIntExpression:intArrayElementAssignment.indexExpression]];
    [tempSet addObject:[self getIntExpression:intArrayElementAssignment.expression]];
    element.expression = tempSet;
    element.string = intArrayElementAssignment.variable;
    //[element addExpressionObject:[self getIntExpression:intArrayElementAssignment.indexExpression]];
    //[element addExpressionObject:[self getIntExpression:intArrayElementAssignment.expression]];
    self.element = element;
}
- (void) visitBoolArrayElementAssignment:(BoolArrayElementAssignment *)boolArrayElementAssignment {
    ElementDB * element = [self createElementWithType:@"BoolArrayElementAssignment"];
    //The following is a necessary hack for the next commented lines.
    NSMutableOrderedSet * tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:element.expression];
    [tempSet addObject:[self getIntExpression:boolArrayElementAssignment.indexExpression]];
    [tempSet addObject:[self getBoolExpression:boolArrayElementAssignment.expression]];
    element.expression = tempSet;
    element.string = boolArrayElementAssignment.variable;
    //[element addExpressionObject:[self getIntExpression:boolArrayElementAssignment.indexExpression]];
    //[element addExpressionObject:[self getBoolExpression:boolArrayElementAssignment.expression]];
    self.element = element;
}
- (void) visitIfThenElseEndIf:(IfThenElseEndIf *)ifThenElseEndIf {
    ElementDB * element = [self createElementWithType:@"IfThenElseEndIf"];
    //The following is a necessary hack for the next commented line.
    NSMutableOrderedSet * tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:element.expression];
    [tempSet addObject:[self getBoolExpression:ifThenElseEndIf.expression]];
    element.expression = tempSet;
    //[element addExpressionObject:[self getBoolExpression:boolArrayElementAssignment.expression]];
    
    //The following is a necessary hack for otherwise shorter code.
    tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:element.child];
    [ifThenElseEndIf.thenStatements accept:self];
    [tempSet addObject:self.element];
    [ifThenElseEndIf.elseStatements accept:self];
    [tempSet addObject:self.element];
    element.child = tempSet;
    //
    
    self.element = element;
}
- (void) visitIfThenEndIf:(IfThenEndIf *)ifThenEndIf {
    ElementDB * element = [self createElementWithType:@"IfThenEndIf"];
    
    //The following is a necessary hack for the next commented line.
    NSMutableOrderedSet * tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:element.expression];
    [tempSet addObject:[self getBoolExpression:ifThenEndIf.expression]];
    element.expression = tempSet;
    //[element addExpressionObject:[self getBoolExpression:boolArrayElementAssignment.expression]];
    
    //The following is a necessary hack for otherwise shorter code.
    tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:element.child];
    [ifThenEndIf.thenStatements accept:self];
    [tempSet addObject:self.element];
    element.child = tempSet;
    //
    
    self.element = element;
}
- (void) visitStatementList:(StatementList *)statementList {
    ElementDB * element = [self createElementWithType:@"StatementList"];
    
    //The following is a necessary hack for otherwise shorter code.
    NSMutableOrderedSet * tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:element.child];
    for (int i = 0; i < statementList.statementList.count; i++) {
        [((id <Statement>)(statementList.statementList[i])) accept:self];
        [tempSet addObject:self.element];
    }
    element.child = tempSet;
    //
    
    self.element = element;
}
- (void) visitWhileEndWhile:(WhileEndWhile *)whileEndWhile {
    ElementDB * element = [self createElementWithType:@"WhileEndWhile"];
    
    //The following is a necessary hack for the next commented line.
    NSMutableOrderedSet * tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:element.expression];
    [tempSet addObject:[self getBoolExpression:whileEndWhile.expression]];
    element.expression = tempSet;
    //[element addExpressionObject:[self getBoolExpression:boolArrayElementAssignment.expression]];
    
    //The following is a necessary hack for otherwise shorter code.
    tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:element.child];
    [whileEndWhile.loopStatements accept:self];
    [tempSet addObject:self.element];
    element.child = tempSet;
    //
    
    self.element = element;
}

@end
