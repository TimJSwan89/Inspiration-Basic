//
//  InspirationBasicTests.m
//  InspirationBasicTests
//
//  Created by Timothy Swan on 5/28/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "../InspirationBasic/Program.h"
#import "../InspirationBasic/EnvironmentModel.h"
#import "../InspirationBasic/StatementList.h"
#import "../InspirationBasic/IntAssignment.h"
#import "../InspirationBasic/BoolAssignment.h"
#import "../InspirationBasic/IntArrayElementAssignment.h"
#import "../InspirationBasic/BoolArrayElementAssignment.h"
#import "../InspirationBasic/IfThenEndIf.h"
#import "../InspirationBasic/IfThenElseEndIf.h"
#import "../InspirationBasic/WhileEndWhile.h"
#import "../InspirationBasic/IntValue.h"
#import "../InspirationBasic/BoolValue.h"
#import "../InspirationBasic/IntVariable.h"
#import "../InspirationBasic/BoolVariable.h"
#import "../InspirationBasic/IntArrayElement.h"
#import "../InspirationBasic/BoolArrayElement.h"
#import "../InspirationBasic/IntSum.h"
#import "../InspirationBasic/BoolLessThan.h"

#import "../InspirationBasic/ExpressionDisplayStringVisitor.h"
#import "../InspirationBasic/StatementDeleteVisitor.h"
#import "../InspirationBasic/StatementMoveVisitor.h"
#import "StatementDebugStringVisitor.h"
//@class EnvironmentModel;

@interface InspirationBasicTests : XCTestCase

@property (nonatomic) EnvironmentModel * environment;

@end

@implementation InspirationBasicTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.environment = [[EnvironmentModel alloc] initWithOutputListener:nil];
    
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (IntValue *)getIntValueFor:(int)value {
    return [[IntValue alloc] initWithValue:value];
}

- (IntVariable *)getIntVariableFor:(NSString *)variable {
    return [[IntVariable alloc] initWithVariable:variable];
}

- (BoolValue *)getBoolValueFor:(bool)value {
    return [[BoolValue alloc] initWithValue:value];
}

- (BoolVariable *)getBoolVariableFor:(NSString *)variable {
    return [[BoolVariable alloc] initWithVariable:variable];
}

- (IntAssignment *)getIntAssignmentForAssigning:(id <IntExpression>)expression to:(NSString *)variable {
    return [[IntAssignment alloc] initWith:variable equals:expression];
}

- (BoolAssignment *)getBoolAssignmentForAssigning:(id <BoolExpression>)expression to:(NSString *)variable {
    return [[BoolAssignment alloc] initWith:variable equals:expression];
}

- (int)evaluateVariableToIntAgainstGlobalEnvironment:(NSString *)variable {
    return [[self getIntVariableFor:variable] evaluateAgainst:self.environment];
}

- (BOOL)evaluateVariableToBoolAgainstGlobalEnvironment:(NSString *)variable {
    return [[self getBoolVariableFor:variable] evaluateAgainst:self.environment];
}

- (void)testDisplayStringWithIntArrayElement
{
    IntArrayElement * element = [[IntArrayElement alloc] initWithVariable:@"theArray" andIndexExpression:[[IntSum alloc] initWith:[self getIntValueFor:10] plus:[self getIntVariableFor:@"x"]]];
    ExpressionDisplayStringVisitor * visitor = [[ExpressionDisplayStringVisitor alloc] init];
    [element accept:visitor];
    XCTAssertTrue([[visitor displayString] isEqualToString:@"theArray[(10 + x)]"]);
}

- (void)testDisplayStringWithSumOfValueAndVariable
{
    IntSum * sum = [[IntSum alloc] initWith:[self getIntValueFor:10] plus:[self getIntVariableFor:@"x"]];
    ExpressionDisplayStringVisitor * visitor = [[ExpressionDisplayStringVisitor alloc] init];
    [sum accept:visitor];
    XCTAssertTrue([[visitor displayString] isEqualToString:@"(10 + x)"]);
}

- (void)testEvaluateOfSumOfValues
{
    IntSum * sum = [[IntSum alloc] initWith:[self getIntValueFor:4] plus:[self getIntValueFor:7]];
    XCTAssertTrue([sum evaluateAgainst:self.environment] == 11);
}

- (void)testEvaluateBoolLessThanOfValues
{
    BoolLessThan * lessThan = [[BoolLessThan alloc] initWith:[self getIntValueFor:12] LessThan:[self getIntValueFor:9]];
    XCTAssertTrue([lessThan evaluateAgainst:self.environment] == false);
}

- (void)testEvaluateIntVariableAfterExecutingAssignment
{
    IntAssignment * assignment = [[IntAssignment alloc] initWith:@"a" equals:[self getIntValueFor:6]];
    [assignment executeAgainst:self.environment];
    XCTAssertTrue([self evaluateVariableToIntAgainstGlobalEnvironment:@"a"] == 6);
}

- (void)testEvaluateBoolVariableAfterExecutingAssignment
{
    BoolAssignment * assignment = [[BoolAssignment alloc] initWith:@"b" equals:[self getBoolValueFor:true]];
    [assignment executeAgainst:self.environment];
    XCTAssertTrue([self evaluateVariableToBoolAgainstGlobalEnvironment:@"b"]);
}

- (void)testEvaluationAfterIntArrayElementAssignment
{
    IntArrayElement * element = [[IntArrayElement alloc] initWithVariable:@"x" andIndexExpression:[self getIntValueFor:0]];
    IntArrayElementAssignment * assigment = [[IntArrayElementAssignment alloc] initWith:element equals:[self getIntValueFor:10]];
    [assigment executeAgainst:self.environment];
    XCTAssertTrue([element evaluateAgainst:self.environment] == 10);
}

- (void)testEvaluationAfterBoolArrayElementAssignment
{
    BoolArrayElement * element = [[BoolArrayElement alloc] initWithVariable:@"x" andIndexExpression:[self getIntValueFor:0]];
    BoolArrayElementAssignment * assigment = [[BoolArrayElementAssignment alloc] initWith:element equals:[self getBoolValueFor:true]];
    [assigment executeAgainst:self.environment];
    XCTAssertTrue([element evaluateAgainst:self.environment] == true);
}

- (void)testEvaluateLessThanOfIntVariablesAfterExecutingStatementListOfTheirAssignments
{
    StatementList * statementList = [[StatementList alloc] init];
    [statementList addStatement:[self getIntAssignmentForAssigning:[self getIntValueFor:6] to:@"c"]];
    [statementList addStatement:[self getIntAssignmentForAssigning:[self getIntValueFor:13] to:@"d"]];
    [statementList executeAgainst:self.environment];
    
    BoolLessThan * lessThan = [[BoolLessThan alloc] initWith:[self getIntVariableFor:@"c"] LessThan:[self getIntVariableFor:@"d"]];
    XCTAssertTrue([lessThan evaluateAgainst:self.environment]);
}

-(void)testExecutingIfThenElseEndIf
{
    StatementList * thenStatements = [[StatementList alloc] init];
    [thenStatements addStatement:[self getIntAssignmentForAssigning:[self getIntValueFor:5] to:@"x"]];
    StatementList * elseStatements = [[StatementList alloc] init];
    [elseStatements addStatement:[self getIntAssignmentForAssigning:[self getIntValueFor:10] to:@"x"]];
    IfThenElseEndIf * ifThenElseEndIf = [[IfThenElseEndIf alloc] initWithIf:[self getBoolValueFor:false] Then:thenStatements Else:elseStatements];
    [ifThenElseEndIf executeAgainst:self.environment];
    XCTAssertTrue([self evaluateVariableToIntAgainstGlobalEnvironment:@"x"] == 10);
}

-(void)testExecutingWhileWithIncrementingVariable
{
    [[self getIntAssignmentForAssigning:[self getIntValueFor:5] to:@"x"] executeAgainst:self.environment];
    StatementList * loopStatements = [[StatementList alloc] init];
    BoolLessThan * lessThan = [[BoolLessThan alloc] initWith:[self getIntVariableFor:@"x"] LessThan:[self getIntValueFor:100]];
    IntSum * sum = [[IntSum alloc] initWith:[self getIntVariableFor:@"x"] plus:[self getIntValueFor:1]];
    [loopStatements addStatement:[self getIntAssignmentForAssigning:sum to:@"x"]];
    WhileEndWhile * whileEndWhile = [[WhileEndWhile alloc] initWithWhile:lessThan Do:loopStatements];
    [whileEndWhile executeAgainst:self.environment];
    if (self.environment.exception) {
        NSString * string = self.environment.exception.message;
        string = [string stringByAppendingString:@""];
    }
    XCTAssertTrue([self evaluateVariableToIntAgainstGlobalEnvironment:@"x"] == 100);
}

- (void)testEvaluateIntVariableAfterExecutingProgramWithAssignment
{
    Program * program = [[Program alloc] initWithTitle:@"The Test Program :D"];
    IntAssignment * assignment = [[IntAssignment alloc] initWith:@"a" equals:[self getIntValueFor:6]];
    [program addStatement:assignment];
    [program executeProgramAgainst:self.environment];
    XCTAssertTrue([self evaluateVariableToIntAgainstGlobalEnvironment:@"a"] == 6);
}

- (void)testDebugStringVisitorWithEmptyProgram
{
    Program * program = [[Program alloc] initWithTitle:@"Default Title"];
    StatementDebugStringVisitor * visitor = [[StatementDebugStringVisitor alloc] init];
    [program accept:visitor];
    XCTAssertTrue([visitor.displayString isEqualToString:@"{}"]);
}

- (void)testDebugStringVisitorWithProgramWithIntAssignmentStatement
{
    Program * program = [[Program alloc] initWithTitle:@"The Test Program :D"];
    IntAssignment * assignment = [[IntAssignment alloc] initWith:@"a" equals:[self getIntValueFor:6]];
    [program addStatement:assignment];
    StatementDebugStringVisitor * visitor = [[StatementDebugStringVisitor alloc] init];
    [program accept:visitor];
    XCTAssertTrue([visitor.displayString isEqualToString:@"{A}"]);
}

- (void)testDebugStringVisitorWithIfThenEndIfStatement
{
    StatementList * thenStatements = [[StatementList alloc] init];
    [thenStatements addStatement:[self getIntAssignmentForAssigning:[self getIntValueFor:5] to:@"x"]];
    [thenStatements addStatement:[self getBoolAssignmentForAssigning:[self getBoolValueFor:true] to:@"z"]];
    IfThenEndIf * ifThenEndIf = [[IfThenEndIf alloc] initWithIf:[self getBoolValueFor:false] Then:thenStatements];
    StatementDebugStringVisitor * visitor = [[StatementDebugStringVisitor alloc] init];
    [ifThenEndIf accept:visitor];
    XCTAssertTrue([visitor.displayString isEqualToString:@"F{Aa}"]);
}

- (void)testDebugStringVisitorWithIfThenElseEndIfStatement
{
    StatementList * thenStatements = [[StatementList alloc] init];
    [thenStatements addStatement:[self getIntAssignmentForAssigning:[self getIntValueFor:5] to:@"x"]];
    [thenStatements addStatement:[self getBoolAssignmentForAssigning:[self getBoolValueFor:true] to:@"z"]];
    StatementList * elseStatements = [[StatementList alloc] init];
    [elseStatements addStatement:[self getIntAssignmentForAssigning:[self getIntValueFor:10] to:@"x"]];
    IfThenElseEndIf * ifThenElseEndIf = [[IfThenElseEndIf alloc] initWithIf:[self getBoolValueFor:false] Then:thenStatements Else:elseStatements];
    StatementDebugStringVisitor * visitor = [[StatementDebugStringVisitor alloc] init];
    [ifThenElseEndIf accept:visitor];
    XCTAssertTrue([visitor.displayString isEqualToString:@"F({Aa},{A})"]);
}

- (void)testDebugStringVisitorWithWhileEndWhileStatement
{
    StatementList * loopStatements = [[StatementList alloc] init];
    [loopStatements addStatement:[self getIntAssignmentForAssigning:[self getIntValueFor:5] to:@"x"]];
    [loopStatements addStatement:[self getBoolAssignmentForAssigning:[self getBoolValueFor:true] to:@"z"]];
    WhileEndWhile * whileEndWhile = [[WhileEndWhile alloc]  initWithWhile:[self getBoolValueFor:false] Do:loopStatements];
    StatementDebugStringVisitor * visitor = [[StatementDebugStringVisitor alloc] init];
    [whileEndWhile accept:visitor];
    XCTAssertTrue([visitor.displayString isEqualToString:@"W{Aa}"]);
}

- (void)testMoveFirstProgramStatementUp {
    Program * program = [[Program alloc] initWithTitle:@"Default Title"];
    IntAssignment * intAssignment = [self getIntAssignmentForAssigning:[self getIntValueFor:5] to:@"x"];
    [program addStatement:intAssignment];
    StatementDebugStringVisitor * stringBeforeVisitor = [[StatementDebugStringVisitor alloc] init];
    [program accept:stringBeforeVisitor];
    StatementMoveVisitor * moveVisitor = [[StatementMoveVisitor alloc] initWithDirection:true andStatement:intAssignment];
    [moveVisitor move];
    StatementDebugStringVisitor * stringAfterVisitor = [[StatementDebugStringVisitor alloc] init];
    [program accept:stringAfterVisitor];
    XCTAssertTrue([stringBeforeVisitor.displayString isEqualToString:@"{A}"]);
    XCTAssertTrue( [stringAfterVisitor.displayString isEqualToString:@"{A}"]);
}

- (void)testMoveLastProgramStatementDown {
    Program * program = [[Program alloc] initWithTitle:@"Default Title"];
    IntAssignment * intAssignment = [self getIntAssignmentForAssigning:[self getIntValueFor:5] to:@"x"];
    [program addStatement:intAssignment];
    StatementDebugStringVisitor * stringBeforeVisitor = [[StatementDebugStringVisitor alloc] init];
    [program accept:stringBeforeVisitor];
    StatementMoveVisitor * moveVisitor = [[StatementMoveVisitor alloc] initWithDirection:false andStatement:intAssignment];
    [moveVisitor move];
    StatementDebugStringVisitor * stringAfterVisitor = [[StatementDebugStringVisitor alloc] init];
    [program accept:stringAfterVisitor];
    XCTAssertTrue([stringBeforeVisitor.displayString isEqualToString:@"{A}"]);
    XCTAssertTrue( [stringAfterVisitor.displayString isEqualToString:@"{A}"]);
}

- (void)testMoveAssignmentWithinIfThenEndIfUpFromThenToOutside {
    Program * program = [[Program alloc] initWithTitle:@"Default Title"];
    StatementList * thenStatements = [[StatementList alloc] init];
    IntAssignment * intAssignment = [self getIntAssignmentForAssigning:[self getIntValueFor:5] to:@"x"];
    [thenStatements addStatement:intAssignment];
    IfThenEndIf * ifThenEndIf = [[IfThenEndIf alloc] initWithIf:[self getBoolValueFor:false] Then:thenStatements];
    [program addStatement:ifThenEndIf];
    StatementDebugStringVisitor * stringBeforeVisitor = [[StatementDebugStringVisitor alloc] init];
    [program accept:stringBeforeVisitor];
    StatementMoveVisitor * moveVisitor = [[StatementMoveVisitor alloc] initWithDirection:true andStatement:intAssignment];
    [moveVisitor move];
    StatementDebugStringVisitor * stringAfterVisitor = [[StatementDebugStringVisitor alloc] init];
    [program accept:stringAfterVisitor];
    XCTAssertTrue([stringBeforeVisitor.displayString isEqualToString:@"{F{A}}"]);
    XCTAssertTrue( [stringAfterVisitor.displayString isEqualToString:@"{AF{}}"]);
}

- (void)testMoveAssignmentWithinIfThenEndIfUpFromThenToThen {
    Program * program = [[Program alloc] initWithTitle:@"Default Title"];
    StatementList * thenStatements = [[StatementList alloc] init];
    BoolAssignment * boolAssignment = [self getBoolAssignmentForAssigning:[self getBoolValueFor:true] to:@"y"];
    [thenStatements addStatement:boolAssignment];
    IntAssignment * intAssignment = [self getIntAssignmentForAssigning:[self getIntValueFor:5] to:@"x"];
    [thenStatements addStatement:intAssignment];
    IfThenEndIf * ifThenEndIf = [[IfThenEndIf alloc] initWithIf:[self getBoolValueFor:false] Then:thenStatements];
    [program addStatement:ifThenEndIf];
    StatementDebugStringVisitor * stringBeforeVisitor = [[StatementDebugStringVisitor alloc] init];
    [program accept:stringBeforeVisitor];
    StatementMoveVisitor * moveVisitor = [[StatementMoveVisitor alloc] initWithDirection:true andStatement:intAssignment];
    [moveVisitor move];
    StatementDebugStringVisitor * stringAfterVisitor = [[StatementDebugStringVisitor alloc] init];
    [program accept:stringAfterVisitor];
    XCTAssertTrue([stringBeforeVisitor.displayString isEqualToString:@"{F{aA}}"]);
    XCTAssertTrue( [stringAfterVisitor.displayString isEqualToString:@"{F{Aa}}"]);
}

- (void)testMoveAssignmentWithinIfThenEndIfUpFromOutsideToThen {
    Program * program = [[Program alloc] initWithTitle:@"Default Title"];
    StatementList * thenStatements = [[StatementList alloc] init];
    IfThenEndIf * ifThenEndIf = [[IfThenEndIf alloc] initWithIf:[self getBoolValueFor:false] Then:thenStatements];
    [program addStatement:ifThenEndIf];
    IntAssignment * intAssignment = [self getIntAssignmentForAssigning:[self getIntValueFor:5] to:@"x"];
    [program addStatement:intAssignment];
    StatementDebugStringVisitor * stringBeforeVisitor = [[StatementDebugStringVisitor alloc] init];
    [program accept:stringBeforeVisitor];
    StatementMoveVisitor * moveVisitor = [[StatementMoveVisitor alloc] initWithDirection:true andStatement:intAssignment];
    [moveVisitor move];
    StatementDebugStringVisitor * stringAfterVisitor = [[StatementDebugStringVisitor alloc] init];
    [program accept:stringAfterVisitor];
    XCTAssertTrue([stringBeforeVisitor.displayString isEqualToString:@"{F{}A}"]);
    XCTAssertTrue( [stringAfterVisitor.displayString isEqualToString:@"{F{A}}"]);
}

- (void)testMoveAssignmentWithinIfThenEndIfDownFromOutsideToThen {
    Program * program = [[Program alloc] initWithTitle:@"Default Title"];
    IntAssignment * intAssignment = [self getIntAssignmentForAssigning:[self getIntValueFor:5] to:@"x"];
    [program addStatement:intAssignment];
    StatementList * thenStatements = [[StatementList alloc] init];
    IfThenEndIf * ifThenEndIf = [[IfThenEndIf alloc] initWithIf:[self getBoolValueFor:false] Then:thenStatements];
    [program addStatement:ifThenEndIf];
    StatementDebugStringVisitor * stringBeforeVisitor = [[StatementDebugStringVisitor alloc] init];
    [program accept:stringBeforeVisitor];
    StatementMoveVisitor * moveVisitor = [[StatementMoveVisitor alloc] initWithDirection:false andStatement:intAssignment];
    [moveVisitor move];
    StatementDebugStringVisitor * stringAfterVisitor = [[StatementDebugStringVisitor alloc] init];
    [program accept:stringAfterVisitor];
    XCTAssertTrue([stringBeforeVisitor.displayString isEqualToString:@"{AF{}}"]);
    XCTAssertTrue( [stringAfterVisitor.displayString isEqualToString:@"{F{A}}"]);
}

- (void)testMoveAssignmentWithinIfThenEndIfDownFromThenToThen {
    Program * program = [[Program alloc] initWithTitle:@"Default Title"];
    StatementList * thenStatements = [[StatementList alloc] init];
    IntAssignment * intAssignment = [self getIntAssignmentForAssigning:[self getIntValueFor:5] to:@"x"];
    [thenStatements addStatement:intAssignment];
    BoolAssignment * boolAssignment = [self getBoolAssignmentForAssigning:[self getBoolValueFor:true] to:@"y"];
    [thenStatements addStatement:boolAssignment];
    IfThenEndIf * ifThenEndIf = [[IfThenEndIf alloc] initWithIf:[self getBoolValueFor:false] Then:thenStatements];
    [program addStatement:ifThenEndIf];
    StatementDebugStringVisitor * stringBeforeVisitor = [[StatementDebugStringVisitor alloc] init];
    [program accept:stringBeforeVisitor];
    StatementMoveVisitor * moveVisitor = [[StatementMoveVisitor alloc] initWithDirection:false andStatement:intAssignment];
    [moveVisitor move];
    StatementDebugStringVisitor * stringAfterVisitor = [[StatementDebugStringVisitor alloc] init];
    [program accept:stringAfterVisitor];
    XCTAssertTrue([stringBeforeVisitor.displayString isEqualToString:@"{F{Aa}}"]);
    XCTAssertTrue( [stringAfterVisitor.displayString isEqualToString:@"{F{aA}}"]);
}

- (void)testMoveAssignmentWithinIfThenEndIfDownFromThenToOutside {
    Program * program = [[Program alloc] initWithTitle:@"Default Title"];
    StatementList * thenStatements = [[StatementList alloc] init];
    IntAssignment * intAssignment = [self getIntAssignmentForAssigning:[self getIntValueFor:5] to:@"x"];
    [thenStatements addStatement:intAssignment];
    IfThenEndIf * ifThenEndIf = [[IfThenEndIf alloc] initWithIf:[self getBoolValueFor:false] Then:thenStatements];
    [program addStatement:ifThenEndIf];
    StatementDebugStringVisitor * stringBeforeVisitor = [[StatementDebugStringVisitor alloc] init];
    [program accept:stringBeforeVisitor];
    StatementMoveVisitor * moveVisitor = [[StatementMoveVisitor alloc] initWithDirection:false andStatement:intAssignment];
    [moveVisitor move];
    StatementDebugStringVisitor * stringAfterVisitor = [[StatementDebugStringVisitor alloc] init];
    [program accept:stringAfterVisitor];
    XCTAssertTrue([stringBeforeVisitor.displayString isEqualToString:@"{F{A}}"]);
    XCTAssertTrue( [stringAfterVisitor.displayString isEqualToString:@"{F{}A}"]);
}

- (void)testMoveAssignmentWithinIfThenElseEndIfUpFromThenToOutside {
    Program * program = [[Program alloc] initWithTitle:@"Default Title"];
    StatementList * thenStatements = [[StatementList alloc] init];
    IntAssignment * intAssignment = [self getIntAssignmentForAssigning:[self getIntValueFor:5] to:@"x"];
    [thenStatements addStatement:intAssignment];
    StatementList * elseStatements = [[StatementList alloc] init];
    IfThenElseEndIf * ifThenElseEndIf = [[IfThenElseEndIf alloc] initWithIf:[self getBoolValueFor:false] Then:thenStatements Else:elseStatements];
    [program addStatement:ifThenElseEndIf];
    StatementDebugStringVisitor * stringBeforeVisitor = [[StatementDebugStringVisitor alloc] init];
    [program accept:stringBeforeVisitor];
    StatementMoveVisitor * moveVisitor = [[StatementMoveVisitor alloc] initWithDirection:true andStatement:intAssignment];
    [moveVisitor move];
    StatementDebugStringVisitor * stringAfterVisitor = [[StatementDebugStringVisitor alloc] init];
    [program accept:stringAfterVisitor];
    XCTAssertTrue([stringBeforeVisitor.displayString isEqualToString:@"{F({A},{})}"]);
    XCTAssertTrue( [stringAfterVisitor.displayString isEqualToString:@"{AF({},{})}"]);
}

- (void)testMoveAssignmentWithinIfThenElseEndIfUpFromThenToThen {
    Program * program = [[Program alloc] initWithTitle:@"Default Title"];
    StatementList * thenStatements = [[StatementList alloc] init];
    BoolAssignment * boolAssignment = [self getBoolAssignmentForAssigning:[self getBoolValueFor:true] to:@"y"];
    [thenStatements addStatement:boolAssignment];
    IntAssignment * intAssignment = [self getIntAssignmentForAssigning:[self getIntValueFor:5] to:@"x"];
    [thenStatements addStatement:intAssignment];
    StatementList * elseStatements = [[StatementList alloc] init];
    IfThenElseEndIf * ifThenElseEndIf = [[IfThenElseEndIf alloc] initWithIf:[self getBoolValueFor:false] Then:thenStatements Else:elseStatements];
    [program addStatement:ifThenElseEndIf];
    StatementDebugStringVisitor * stringBeforeVisitor = [[StatementDebugStringVisitor alloc] init];
    [program accept:stringBeforeVisitor];
    StatementMoveVisitor * moveVisitor = [[StatementMoveVisitor alloc] initWithDirection:true andStatement:intAssignment];
    [moveVisitor move];
    StatementDebugStringVisitor * stringAfterVisitor = [[StatementDebugStringVisitor alloc] init];
    [program accept:stringAfterVisitor];
    XCTAssertTrue([stringBeforeVisitor.displayString isEqualToString:@"{F({aA},{})}"]);
    XCTAssertTrue( [stringAfterVisitor.displayString isEqualToString:@"{F({Aa},{})}"]);
}

- (void)testMoveAssignmentWithinIfThenElseEndIfUpFromElseToThen {
    Program * program = [[Program alloc] initWithTitle:@"Default Title"];
    StatementList * thenStatements = [[StatementList alloc] init];
    StatementList * elseStatements = [[StatementList alloc] init];
    IntAssignment * intAssignment = [self getIntAssignmentForAssigning:[self getIntValueFor:5] to:@"x"];
    [elseStatements addStatement:intAssignment];
    IfThenElseEndIf * ifThenElseEndIf = [[IfThenElseEndIf alloc] initWithIf:[self getBoolValueFor:false] Then:thenStatements Else:elseStatements];
    [program addStatement:ifThenElseEndIf];
    StatementDebugStringVisitor * stringBeforeVisitor = [[StatementDebugStringVisitor alloc] init];
    [program accept:stringBeforeVisitor];
    StatementMoveVisitor * moveVisitor = [[StatementMoveVisitor alloc] initWithDirection:true andStatement:intAssignment];
    [moveVisitor move];
    StatementDebugStringVisitor * stringAfterVisitor = [[StatementDebugStringVisitor alloc] init];
    [program accept:stringAfterVisitor];
    XCTAssertTrue([stringBeforeVisitor.displayString isEqualToString:@"{F({},{A})}"]);
    XCTAssertTrue( [stringAfterVisitor.displayString isEqualToString:@"{F({A},{})}"]);
}

- (void)testMoveAssignmentWithinIfThenElseEndIfUpFromElseToElse {
    Program * program = [[Program alloc] initWithTitle:@"Default Title"];
    StatementList * thenStatements = [[StatementList alloc] init];
    StatementList * elseStatements = [[StatementList alloc] init];
    BoolAssignment * boolAssignment = [self getBoolAssignmentForAssigning:[self getBoolValueFor:true] to:@"y"];
    [elseStatements addStatement:boolAssignment];
    IntAssignment * intAssignment = [self getIntAssignmentForAssigning:[self getIntValueFor:5] to:@"x"];
    [elseStatements addStatement:intAssignment];
    IfThenElseEndIf * ifThenElseEndIf = [[IfThenElseEndIf alloc] initWithIf:[self getBoolValueFor:false] Then:thenStatements Else:elseStatements];
    [program addStatement:ifThenElseEndIf];
    StatementDebugStringVisitor * stringBeforeVisitor = [[StatementDebugStringVisitor alloc] init];
    [program accept:stringBeforeVisitor];
    StatementMoveVisitor * moveVisitor = [[StatementMoveVisitor alloc] initWithDirection:true andStatement:intAssignment];
    [moveVisitor move];
    StatementDebugStringVisitor * stringAfterVisitor = [[StatementDebugStringVisitor alloc] init];
    [program accept:stringAfterVisitor];
    XCTAssertTrue([stringBeforeVisitor.displayString isEqualToString:@"{F({},{aA})}"]);
    XCTAssertTrue( [stringAfterVisitor.displayString isEqualToString:@"{F({},{Aa})}"]);
}

- (void)testMoveAssignmentWithinIfThenElseEndIfUpFromOutsideToElse {
    Program * program = [[Program alloc] initWithTitle:@"Default Title"];
    StatementList * thenStatements = [[StatementList alloc] init];
    StatementList * elseStatements = [[StatementList alloc] init];
    IfThenElseEndIf * ifThenElseEndIf = [[IfThenElseEndIf alloc] initWithIf:[self getBoolValueFor:false] Then:thenStatements Else:elseStatements];
    [program addStatement:ifThenElseEndIf];
    IntAssignment * intAssignment = [self getIntAssignmentForAssigning:[self getIntValueFor:5] to:@"x"];
    [program addStatement:intAssignment];
    StatementDebugStringVisitor * stringBeforeVisitor = [[StatementDebugStringVisitor alloc] init];
    [program accept:stringBeforeVisitor];
    StatementMoveVisitor * moveVisitor = [[StatementMoveVisitor alloc] initWithDirection:true andStatement:intAssignment];
    [moveVisitor move];
    StatementDebugStringVisitor * stringAfterVisitor = [[StatementDebugStringVisitor alloc] init];
    [program accept:stringAfterVisitor];
    XCTAssertTrue([stringBeforeVisitor.displayString isEqualToString:@"{F({},{})A}"]);
    XCTAssertTrue( [stringAfterVisitor.displayString isEqualToString:@"{F({},{A})}"]);
}

- (void)testMoveAssignmentWithinIfThenElseEndIfDownFromOutsideToThen {
    Program * program = [[Program alloc] initWithTitle:@"Default Title"];
    IntAssignment * intAssignment = [self getIntAssignmentForAssigning:[self getIntValueFor:5] to:@"x"];
    [program addStatement:intAssignment];
    StatementList * thenStatements = [[StatementList alloc] init];
    StatementList * elseStatements = [[StatementList alloc] init];
    IfThenElseEndIf * ifThenElseEndIf = [[IfThenElseEndIf alloc] initWithIf:[self getBoolValueFor:false] Then:thenStatements Else:elseStatements];
    [program addStatement:ifThenElseEndIf];
    StatementDebugStringVisitor * stringBeforeVisitor = [[StatementDebugStringVisitor alloc] init];
    [program accept:stringBeforeVisitor];
    StatementMoveVisitor * moveVisitor = [[StatementMoveVisitor alloc] initWithDirection:false andStatement:intAssignment];
    [moveVisitor move];
    StatementDebugStringVisitor * stringAfterVisitor = [[StatementDebugStringVisitor alloc] init];
    [program accept:stringAfterVisitor];
    XCTAssertTrue([stringBeforeVisitor.displayString isEqualToString:@"{AF({},{})}"]);
    XCTAssertTrue( [stringAfterVisitor.displayString isEqualToString:@"{F({A},{})}"]);
}

- (void)testMoveAssignmentWithinIfThenElseEndIfDownFromThenToThen {
    Program * program = [[Program alloc] initWithTitle:@"Default Title"];
    StatementList * thenStatements = [[StatementList alloc] init];
    IntAssignment * intAssignment = [self getIntAssignmentForAssigning:[self getIntValueFor:5] to:@"x"];
    [thenStatements addStatement:intAssignment];
    BoolAssignment * boolAssignment = [self getBoolAssignmentForAssigning:[self getBoolValueFor:true] to:@"y"];
    [thenStatements addStatement:boolAssignment];
    StatementList * elseStatements = [[StatementList alloc] init];
    IfThenElseEndIf * ifThenElseEndIf = [[IfThenElseEndIf alloc] initWithIf:[self getBoolValueFor:false] Then:thenStatements Else:elseStatements];
    [program addStatement:ifThenElseEndIf];
    StatementDebugStringVisitor * stringBeforeVisitor = [[StatementDebugStringVisitor alloc] init];
    [program accept:stringBeforeVisitor];
    StatementMoveVisitor * moveVisitor = [[StatementMoveVisitor alloc] initWithDirection:false andStatement:intAssignment];
    [moveVisitor move];
    StatementDebugStringVisitor * stringAfterVisitor = [[StatementDebugStringVisitor alloc] init];
    [program accept:stringAfterVisitor];
    XCTAssertTrue([stringBeforeVisitor.displayString isEqualToString:@"{F({Aa},{})}"]);
    XCTAssertTrue( [stringAfterVisitor.displayString isEqualToString:@"{F({aA},{})}"]);
}

- (void)testMoveAssignmentWithinIfThenElseEndIfDownFromThenToElse {
    Program * program = [[Program alloc] initWithTitle:@"Default Title"];
    StatementList * thenStatements = [[StatementList alloc] init];
    IntAssignment * intAssignment = [self getIntAssignmentForAssigning:[self getIntValueFor:5] to:@"x"];
    [thenStatements addStatement:intAssignment];
    StatementList * elseStatements = [[StatementList alloc] init];
    IfThenElseEndIf * ifThenElseEndIf = [[IfThenElseEndIf alloc] initWithIf:[self getBoolValueFor:false] Then:thenStatements Else:elseStatements];
    [program addStatement:ifThenElseEndIf];
    StatementDebugStringVisitor * stringBeforeVisitor = [[StatementDebugStringVisitor alloc] init];
    [program accept:stringBeforeVisitor];
    StatementMoveVisitor * moveVisitor = [[StatementMoveVisitor alloc] initWithDirection:false andStatement:intAssignment];
    [moveVisitor move];
    StatementDebugStringVisitor * stringAfterVisitor = [[StatementDebugStringVisitor alloc] init];
    [program accept:stringAfterVisitor];
    XCTAssertTrue([stringBeforeVisitor.displayString isEqualToString:@"{F({A},{})}"]);
    XCTAssertTrue( [stringAfterVisitor.displayString isEqualToString:@"{F({},{A})}"]);
}

- (void)testMoveAssignmentWithinIfThenElseEndIfDownFromElseToElse {
    Program * program = [[Program alloc] initWithTitle:@"Default Title"];
    StatementList * thenStatements = [[StatementList alloc] init];
    StatementList * elseStatements = [[StatementList alloc] init];
    IntAssignment * intAssignment = [self getIntAssignmentForAssigning:[self getIntValueFor:5] to:@"x"];
    [elseStatements addStatement:intAssignment];
    BoolAssignment * boolAssignment = [self getBoolAssignmentForAssigning:[self getBoolValueFor:true] to:@"y"];
    [elseStatements addStatement:boolAssignment];
    IfThenElseEndIf * ifThenElseEndIf = [[IfThenElseEndIf alloc] initWithIf:[self getBoolValueFor:false] Then:thenStatements Else:elseStatements];
    [program addStatement:ifThenElseEndIf];
    StatementDebugStringVisitor * stringBeforeVisitor = [[StatementDebugStringVisitor alloc] init];
    [program accept:stringBeforeVisitor];
    StatementMoveVisitor * moveVisitor = [[StatementMoveVisitor alloc] initWithDirection:false andStatement:intAssignment];
    [moveVisitor move];
    StatementDebugStringVisitor * stringAfterVisitor = [[StatementDebugStringVisitor alloc] init];
    [program accept:stringAfterVisitor];
    XCTAssertTrue([stringBeforeVisitor.displayString isEqualToString:@"{F({},{Aa})}"]);
    XCTAssertTrue( [stringAfterVisitor.displayString isEqualToString:@"{F({},{aA})}"]);
}

- (void)testMoveAssignmentWithinIfThenElseEndIfDownFromElseToOutside {
    Program * program = [[Program alloc] initWithTitle:@"Default Title"];
    StatementList * thenStatements = [[StatementList alloc] init];
    StatementList * elseStatements = [[StatementList alloc] init];
    IntAssignment * intAssignment = [self getIntAssignmentForAssigning:[self getIntValueFor:5] to:@"x"];
    [elseStatements addStatement:intAssignment];
    IfThenElseEndIf * ifThenElseEndIf = [[IfThenElseEndIf alloc] initWithIf:[self getBoolValueFor:false] Then:thenStatements Else:elseStatements];
    [program addStatement:ifThenElseEndIf];
    StatementDebugStringVisitor * stringBeforeVisitor = [[StatementDebugStringVisitor alloc] init];
    [program accept:stringBeforeVisitor];
    StatementMoveVisitor * moveVisitor = [[StatementMoveVisitor alloc] initWithDirection:false andStatement:intAssignment];
    [moveVisitor move];
    StatementDebugStringVisitor * stringAfterVisitor = [[StatementDebugStringVisitor alloc] init];
    [program accept:stringAfterVisitor];
    XCTAssertTrue([stringBeforeVisitor.displayString isEqualToString:@"{F({},{A})}"]);
    XCTAssertTrue( [stringAfterVisitor.displayString isEqualToString:@"{F({},{})A}"]);
}

- (void)testDeleteProtectChildrenIfThenElseEndIfDown {
    Program * program = [[Program alloc] initWithTitle:@"Default Title"];
    StatementList * thenStatements = [[StatementList alloc] init];
    BoolAssignment * boolAssignment1 = [self getBoolAssignmentForAssigning:[self getBoolValueFor:true] to:@"y"];
    [thenStatements addStatement:boolAssignment1];
    IntAssignment * intAssignment1 = [self getIntAssignmentForAssigning:[self getIntValueFor:5] to:@"x"];
    [thenStatements addStatement:intAssignment1];
    StatementList * elseStatements = [[StatementList alloc] init];
    IntAssignment * intAssignment2 = [self getIntAssignmentForAssigning:[self getIntValueFor:5] to:@"x"];
    [elseStatements addStatement:intAssignment2];
    BoolAssignment * boolAssignment2 = [self getBoolAssignmentForAssigning:[self getBoolValueFor:true] to:@"y"];
    [elseStatements addStatement:boolAssignment2];
    BoolAssignment * boolAssignment3 = [self getBoolAssignmentForAssigning:[self getBoolValueFor:true] to:@"y"];
    [elseStatements addStatement:boolAssignment3];
    IfThenElseEndIf * ifThenElseEndIf = [[IfThenElseEndIf alloc] initWithIf:[self getBoolValueFor:false] Then:thenStatements Else:elseStatements];
    [program addStatement:ifThenElseEndIf];
    StatementDebugStringVisitor * stringBeforeVisitor = [[StatementDebugStringVisitor alloc] init];
    [program accept:stringBeforeVisitor];
    StatementDeleteVisitor * deleteVisitor = [[StatementDeleteVisitor alloc] initWithStatement:ifThenElseEndIf and:true];
    [deleteVisitor deleteStatement];
    StatementDebugStringVisitor * stringAfterVisitor = [[StatementDebugStringVisitor alloc] init];
    [program accept:stringAfterVisitor];
    XCTAssertTrue([stringBeforeVisitor.displayString isEqualToString:@"{F({aA},{Aaa})}"]);
    XCTAssertTrue( [stringAfterVisitor.displayString isEqualToString:@"{aAAaa}"]);
}

@end
