//
//  DemoPrograms.m
//  InspirationBasic
//
//  Created by Timothy Swan on 8/1/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import "DemoPrograms.h"

#import "StatementList.h"
#import "PrintInt.h"
#import "IntAssignment.h"
#import "BoolAssignment.h"
#import "IntArrayElementAssignment.h"
#import "BoolArrayElementAssignment.h"
#import "IfThenElseEndIf.h"
#import "IfThenEndIf.h"
#import "WhileEndWhile.h"

#import "./BoolVariable.h"
#import "./IntVariable.h"
#import "./BoolArrayElement.h"
#import "./IntArrayElement.h"
#import "./IntValue.h"
#import "./BoolValue.h"
#import "./IntNegation.h"
#import "./IntSum.h"
#import "./IntDifference.h"
#import "./IntProduct.h"
#import "./IntQuotient.h"
#import "./IntRemainder.h"
#import "./BoolNegation.h"
#import "./BoolOr.h"
#import "./BoolNor.h"
#import "./BoolAnd.h"
#import "./BoolNand.h"
#import "./BoolImplies.h"
#import "./BoolNonImplies.h"
#import "./BoolReverseImplies.h"
#import "./BoolReverseNonImplies.h"
#import "./BoolBoolEquals.h"
#import "./BoolBoolDoesNotEqual.h"
#import "./BoolIntEquals.h"
#import "./BoolIntDoesNotEqual.h"
#import "./BoolLessThan.h"
#import "./BoolLessThanOrEquals.h"
#import "./BoolGreaterThan.h"
#import "./BoolGreaterThanOrEquals.h"

@implementation DemoPrograms

+ (NSMutableArray *) getDefaultListOfDempPrograms {
    NSMutableArray * list = [[NSMutableArray alloc] init];
    [list addObject:[self createDefaultProgram]];
    [list addObject:[self createPrimeGeneratorProgram]];
    return list;
}

+ (IntValue *)getIntValueFor:(int)value {
    return [[IntValue alloc] initWithValue:value];
}

+ (IntVariable *)getIntVariableFor:(NSString *)variable {
    return [[IntVariable alloc] initWithVariable:variable];
}

+ (BoolValue *)getBoolValueFor:(bool)value {
    return [[BoolValue alloc] initWithValue:value];
}

+ (BoolVariable *)getBoolVariableFor:(NSString *)variable {
    return [[BoolVariable alloc] initWithVariable:variable];
}

+ (IntAssignment *)getIntAssignmentForAssigning:(id <IntExpression>)expression to:(NSString *)variable {
    return [[IntAssignment alloc] initWith:variable equals:expression];
}

+ (BoolAssignment *)getBoolAssignmentForAssigning:(id <BoolExpression>)expression to:(NSString *)variable {
    return [[BoolAssignment alloc] initWith:variable equals:expression];
}

+ (Program *) createPrimeGeneratorProgram {
    StatementList * lateIfThen = [[StatementList alloc] init];
    [lateIfThen addStatement:[[PrintInt alloc] initWithExpression:[self getIntVariableFor:@"x"]]];
    
    IfThenEndIf * lateIf = [[IfThenEndIf alloc] initWithIf:[self getBoolVariableFor:@"test"] Then:lateIfThen];
    
    BoolIntEquals * equality = [[BoolIntEquals alloc] initWith:[[IntRemainder alloc] initWith:[self getIntVariableFor:@"x"] dividedBy:[self getIntVariableFor:@"t"]] IntEquals:[self getIntValueFor:0]];
    StatementList * innerThen = [[StatementList alloc] init];
    [innerThen addStatement:[self getBoolAssignmentForAssigning:[self getBoolValueFor:false] to:@"test"]];
    
    IntSum * tAdd = [[IntSum alloc] initWith:[self getIntVariableFor:@"t"] plus:[self getIntValueFor:1]];
    
    BoolLessThan * innerCompare = [[BoolLessThan alloc] initWith:[self getIntVariableFor:@"t"] LessThan:[self getIntVariableFor:@"x"]];
    StatementList * innerLoop = [[StatementList alloc] init];
    [innerLoop addStatement:[[IfThenEndIf alloc] initWithIf:equality Then:innerThen]];
    [innerLoop addStatement:[self getIntAssignmentForAssigning:tAdd to:@"t"]];
    
    BoolLessThan * compare = [[BoolLessThan alloc] initWith:[self getIntVariableFor:@"x"] LessThan:[self getIntValueFor:100]];
    StatementList * loop = [[StatementList alloc] init];
    [loop addStatement:[self getBoolAssignmentForAssigning:[self getBoolValueFor:true] to:@"test"]];
    [loop addStatement:[self getIntAssignmentForAssigning:[self getIntValueFor:2] to:@"t"]];
    [loop addStatement:[[WhileEndWhile alloc] initWithWhile:innerCompare Do:innerLoop]];
    [loop addStatement:lateIf];
    [loop addStatement:[self getIntAssignmentForAssigning:[[IntSum alloc] initWith:[self getIntVariableFor:@"x"] plus:[self getIntValueFor:1]] to:@"x"]];
    Program * program = [[Program alloc] initWithTitle:@"Prime Generator"];
    [program addStatement:[self getIntAssignmentForAssigning:[self getIntValueFor:1] to:@"x"]];
    [program addStatement:[[WhileEndWhile alloc] initWithWhile:compare Do:loop]];
    return program;
}

+ (Program *) createDefaultProgram {
    
    Program * program = [[Program alloc] initWithTitle:@"Default Program"];
    
    [program addStatement:[[IntAssignment alloc] initWith:@"x" equals:[[IntValue alloc] initWithValue:5]]];
    StatementList * loopStatements = [[StatementList alloc] init];
    BoolLessThan * lessThan = [[BoolLessThan alloc] initWith:[[IntVariable alloc] initWithVariable:@"x"] LessThan:[[IntValue alloc] initWithValue:10]];
    IntSum * sum = [[IntSum alloc] initWith:[[IntVariable alloc] initWithVariable:@"x"] plus:[[IntValue alloc] initWithValue:1]];
    [loopStatements addStatement:[[IntAssignment alloc] initWith:@"x" equals:sum]];
    [loopStatements addStatement:[[PrintInt alloc] initWithExpression:[[IntVariable alloc] initWithVariable:@"x"]]];
    WhileEndWhile * whileEndWhile = [[WhileEndWhile alloc] initWithWhile:lessThan Do:loopStatements];
    [program addStatement:whileEndWhile];
    
    StatementList * loopStatements1 = [[StatementList alloc] init];
    BoolLessThan * lessThan1 = [[BoolLessThan alloc] initWith:[[IntVariable alloc] initWithVariable:@"x"] LessThan:[[IntValue alloc] initWithValue:10]];
    IntSum * sum1 = [[IntSum alloc] initWith:[[IntVariable alloc] initWithVariable:@"x"] plus:[[IntValue alloc] initWithValue:1]];
    [loopStatements1 addStatement:[[IntAssignment alloc] initWith:@"x" equals:sum1]];
    [loopStatements1 addStatement:[[PrintInt alloc] initWithExpression:[[IntVariable alloc] initWithVariable:@"x"]]];
    WhileEndWhile * whileEndWhile1 = [[WhileEndWhile alloc] initWithWhile:lessThan1 Do:loopStatements1];
    [whileEndWhile.loopStatements addStatement:whileEndWhile1];
    
    [program addStatement:[[IntAssignment alloc] initWith:@"x" equals:[[IntValue alloc] initWithValue:6]]];
    NSInteger num = program.statementList.count;
    [program addStatement:[[IntAssignment alloc] initWith:@"x" equals:[[IntValue alloc] initWithValue:7]]];
    num = program.statementList.count;
    [program addStatement:[[IntAssignment alloc] initWith:@"x" equals:[[IntValue alloc] initWithValue:8]]];
    num = program.statementList.count;
    [program addStatement:[[IntAssignment alloc] initWith:@"x" equals:[[IntValue alloc] initWithValue:9]]];
    num = program.statementList.count;
    [program addStatement:[[IntAssignment alloc] initWith:@"x" equals:[[IntValue alloc] initWithValue:10]]];
    num = program.statementList.count;
    [program addStatement:[[IntAssignment alloc] initWith:@"x" equals:[[IntValue alloc] initWithValue:8]]];
    num = program.statementList.count;
    [program addStatement:[[IntAssignment alloc] initWith:@"x" equals:[[IntValue alloc] initWithValue:9]]];
    num = program.statementList.count;
    [program addStatement:[[IntAssignment alloc] initWith:@"x" equals:[[IntValue alloc] initWithValue:10]]];
    num = program.statementList.count;
    [program addStatement:[[IntAssignment alloc] initWith:@"x" equals:[[IntValue alloc] initWithValue:8]]];
    num = program.statementList.count;
    [program addStatement:[[IntAssignment alloc] initWith:@"x" equals:[[IntValue alloc] initWithValue:9]]];
    num = program.statementList.count;
    [program addStatement:[[IntAssignment alloc] initWith:@"x" equals:[[IntValue alloc] initWithValue:10]]];
    num = program.statementList.count;
    [program addStatement:[[IntAssignment alloc] initWith:@"x" equals:[[IntValue alloc] initWithValue:10]]];
    num = program.statementList.count;
    [program addStatement:[[IntAssignment alloc] initWith:@"x" equals:[[IntValue alloc] initWithValue:8]]];
    num = program.statementList.count;
    [program addStatement:[[IntAssignment alloc] initWith:@"x" equals:[[IntValue alloc] initWithValue:9]]];
    num = program.statementList.count;
    [program addStatement:[[IntAssignment alloc] initWith:@"x" equals:[[IntValue alloc] initWithValue:10]]];
    num = program.statementList.count;
    [program addStatement:[[IntAssignment alloc] initWith:@"x" equals:[[IntValue alloc] initWithValue:8]]];
    num = program.statementList.count;
    [program addStatement:[[IntAssignment alloc] initWith:@"x" equals:[[IntValue alloc] initWithValue:9]]];
    num = program.statementList.count;
    [program addStatement:[[IntAssignment alloc] initWith:@"x" equals:[[IntValue alloc] initWithValue:10]]];
    num = program.statementList.count;
    return program;
}

@end
