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
#import "PrintBool.h"
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
#import "./IntRandom.h"
#import "./IntNegation.h"
#import "./IntSum.h"
#import "./IntDifference.h"
#import "./IntProduct.h"
#import "./IntQuotient.h"
#import "./IntRemainder.h"
#import "./BoolRandom.h"
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
    [list addObject:[self createInsertionSortProgram]];
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

+ (BoolLessThan *) getILessThanLength {
    return [[BoolLessThan alloc] initWith:[self getIntVariableFor:@"i"] LessThan:[self getIntVariableFor:@"length"]];
}

+ (IntAssignment *) getIncrementI {
    IntSum * iPlusOne = [[IntSum alloc] initWith:[self getIntVariableFor:@"i"] plus:[self getIntValueFor:1]];
    return [self getIntAssignmentForAssigning:iPlusOne to:@"i"];
}

+ (IntArrayElement *) getASubI {
    return [[IntArrayElement alloc] initWithVariable:@"a" andIndexExpression:[self getIntVariableFor:@"i"]];
}

+ (IntArrayElement *) getASubJ {
    return [[IntArrayElement alloc] initWithVariable:@"a" andIndexExpression:[self getIntVariableFor:@"j"]];
}

+ (IntArrayElement *) getASubJPlusOne {
    return [[IntArrayElement alloc] initWithVariable:@"a" andIndexExpression:[[IntSum alloc] initWith:[self getIntVariableFor:@"j"] plus:[self getIntValueFor:1]]];
}

+ (PrintInt *) getPrintASubI {
    return [[PrintInt alloc] initWithExpression:[self getASubI]];
}

+ (WhileEndWhile *) getForIInLength:(StatementList *)list {
    return [[WhileEndWhile alloc] initWithWhile:[self getILessThanLength] Do:list];
}

+ (Program *) createInsertionSortProgram {
    
    Program * program = [[Program alloc] initWithTitle:@"Insertion Sort"];
    
    [program addStatement:[self getIntAssignmentForAssigning:[self getIntValueFor:12] to:@"length"]];
    [program addStatement:[self getIntAssignmentForAssigning:[self getIntValueFor:100] to:@"max"]];
    [program addStatement:[self getIntAssignmentForAssigning:[self getIntValueFor:0] to:@"i"]];
    IntArrayElementAssignment * assignment = [[IntArrayElementAssignment alloc] initWith:[self getASubI] equals:[[IntRandom alloc] initWith:[self getIntVariableFor:@"max"]]];
    StatementList * list = [[StatementList alloc] init];
    [list addStatement:assignment];
    [list addStatement:[self getPrintASubI]];
    [list addStatement:[self getIncrementI]];
    [program addStatement:[self getForIInLength:list]];
    [program addStatement:[[PrintBool alloc] initWithExpression:[self getBoolValueFor:false]]];
    [program addStatement:[self getIntAssignmentForAssigning:[self getIntValueFor:1] to:@"i"]];
    IntAssignment * initT = [[IntAssignment alloc] initWith:@"t" equals:[self getASubI]];
    IntAssignment * initJ = [[IntAssignment alloc] initWith:@"j" equals:[[IntDifference alloc] initWith:[self getIntVariableFor:@"i"] minus:[self getIntValueFor:1]]];
    BoolAnd * andCheck = [[BoolAnd alloc] initWith:[[BoolGreaterThanOrEquals alloc] initWith:[self getIntVariableFor:@"j"] GreaterThanOrEquals:[self getIntValueFor:0]] BoolAnd:[[BoolGreaterThan alloc] initWith:[self getASubJ] GreaterThan:[self getIntVariableFor:@"t"]]];
    StatementList * innerList = [[StatementList alloc] init];
    [innerList addStatement:[[IntArrayElementAssignment alloc] initWith:[self getASubJPlusOne] equals:[self getASubJ]]];
    [innerList addStatement:[self getIntAssignmentForAssigning:[[IntDifference alloc] initWith:[self getIntVariableFor:@"j"] minus:[self getIntValueFor:1]] to:@"j"]];
    WhileEndWhile * innerWhile = [[WhileEndWhile alloc] initWithWhile:andCheck Do:innerList];
    assignment = [[IntArrayElementAssignment alloc] initWith:[self getASubJPlusOne] equals:[self getIntVariableFor:@"t"]];
    list = [[StatementList alloc] init];
    [list addStatement:initT];
    [list addStatement:initJ];
    [list addStatement:innerWhile];
    [list addStatement:assignment];
    [list addStatement:[self getIncrementI]];
    [program addStatement:[self getForIInLength:list]];
    [program addStatement:[self getIntAssignmentForAssigning:[self getIntValueFor:0] to:@"i"]];
    list = [[StatementList alloc] init];
    [list addStatement:[self getPrintASubI]];
    [list addStatement:[self getIncrementI]];
    [program addStatement:[self getForIInLength:list]];
    return program;
}

@end
