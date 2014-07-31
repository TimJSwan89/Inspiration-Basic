#import <Foundation/Foundation.h>
#import "DBToStatementVisitor.h"
#import "Program.h"
#import "Statement.h"
#import "ProgramDB.h"
#import "ElementDB.h"

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

@implementation DBToStatementVisitor
- (id) init {
    if (self = [super init]) {
    }
    return self;
}
- (NSMutableArray *) loadProgramsFromDBContext:(NSManagedObjectContext *)context {
    NSMutableArray * programs = [[NSMutableArray alloc] init];
    
    NSEntityDescription * entityDescription = [NSEntityDescription entityForName:@"ProgramDB" inManagedObjectContext:context];
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSPredicate * predicate = nil;// Gets all //[NSPredicate predicateWithFormat:@"(title = %@)", @"Test Title"];
    [request setPredicate:predicate];
    ProgramDB * matches;
    NSError * error;
    NSArray * objects = [context executeFetchRequest:request error:&error];
    if ([objects count] == 0) {
        NSLog(@"No matches found in memory.");
    } else {
        for (int i = 0; i < objects.count; i++) {
            matches = objects[i];
            Program * program = [[Program alloc] initWithTitle:matches.title];
            for (int i = 0; i < matches.programChild.count; i++) {
                [program.statementList addObject:[self convertToStatement:matches.programChild[i]]];
            }
            [programs addObject:program];
        }
    }
    return programs;
}

- (BoolArrayElement *) getBoolArrayElementVariable:(NSString *)variable indexExpression:(id <IntExpression>)indexExpression {
    return [[BoolArrayElement alloc] initWithVariable:variable andIndexExpression:indexExpression];
}

- (IntArrayElement *) getIntArrayElementVariable:(NSString *)variable indexExpression:(id <IntExpression>)indexExpression {
    return [[IntArrayElement alloc] initWithVariable:variable andIndexExpression:indexExpression];
}

- (id <Statement>) convertToStatement:(ElementDB *) element {
    id <Statement> statement = nil;
    NSLog(@"%@",element.type);
    if ([element.type isEqualToString:@"PrintInt"]) {
        statement = [[PrintInt alloc] initWithExpression:[self convertToIntExpression:element.expression[0]]];
    } else if ([element.type isEqualToString:@"PrintBool"]) {
        statement = [[PrintBool alloc] initWithExpression:[self convertToBoolExpression:element.expression[0]]];
    } else if ([element.type isEqualToString:@"IntAssignment"]) {
        statement = [[IntAssignment alloc] initWith:element.string equals:[self convertToIntExpression:element.expression[0]]];
    } else if ([element.type isEqualToString:@"BoolAssignment"]) {
        statement = [[BoolAssignment alloc] initWith:element.string equals:[self convertToBoolExpression:element.expression[0]]];
    } else if ([element.type isEqualToString:@"IntArrayElementAssignment"]) {
        statement = [[IntArrayElementAssignment alloc] initWith:[self getIntArrayElementVariable:element.string indexExpression:[self convertToIntExpression:element.expression[0]]] equals:[self convertToIntExpression:element.expression[1]]];
    } else if ([element.type isEqualToString:@"BoolArrayElementAssignment"]) {
        statement = [[BoolArrayElementAssignment alloc] initWith:[self getBoolArrayElementVariable:element.string indexExpression:[self convertToIntExpression:element.expression[0]]] equals:[self convertToBoolExpression:element.expression[1]]];
    } else if ([element.type isEqualToString:@"IfThenElseEndIf"]) {
        statement = [[IfThenElseEndIf alloc] initWithIf:[self convertToBoolExpression:element.expression[0]] Then:((StatementList *)[self convertToStatement:element.child[0]]) Else:((StatementList *)[self convertToStatement:element.child[1]])];
    } else if ([element.type isEqualToString:@"IfThenEndIf"]) {
        statement = [[IfThenEndIf alloc] initWithIf:[self convertToBoolExpression:element.expression[0]] Then:((StatementList *)[self convertToStatement:element.child[0]])];
    } else if ([element.type isEqualToString:@"StatementList"]) {
        statement = [[StatementList alloc] init];
        for (int i = 0; i < element.child.count; i++)
             [((StatementList *) statement) addStatement:[self convertToStatement:element.child[i]]];
    } else if ([element.type isEqualToString:@"WhileEndWhile"]) {
        statement = [[WhileEndWhile alloc] initWithWhile:[self convertToBoolExpression:element.expression[0]] Do:((StatementList *)[self convertToStatement:element.child[0]])];
    } else {
        [NSException raise:@"Type does not exist." format:@"Type does not exist."];
    }
    
    return statement;
}

- (id <IntExpression>) convertToIntExpression:(ElementDB *) element {
    id <IntExpression> intExpression = nil;
    NSLog(@"  %@",element.type);
    if ([element.type isEqualToString:@"IntValue"]) {
        NSLog(@"  %d",[element.integer intValue]);
        intExpression = [[IntValue alloc] initWithValue:[element.integer intValue]];
    } else if ([element.type isEqualToString:@"IntVariable"]) {
        intExpression = [[IntVariable alloc] initWithVariable:element.string];
    } else if ([element.type isEqualToString:@"IntArrayElement"]) {
        intExpression = [self getIntArrayElementVariable:element.string indexExpression:[self convertToIntExpression:element.expression[0]]];
    } else if ([element.type isEqualToString:@"IntNegation"]) {
        intExpression = [[IntNegation alloc] initWith:[self convertToIntExpression:element.expression[0]]];
    } else if ([element.type isEqualToString:@"IntSum"]) {
        intExpression = [[IntSum alloc] initWith:[self convertToIntExpression:element.expression[0]] plus:[self convertToIntExpression:element.expression[1]]];
    } else if ([element.type isEqualToString:@"IntDifference"]) {
        intExpression = [[IntDifference alloc] initWith:[self convertToIntExpression:element.expression[0]] plus:[self convertToIntExpression:element.expression[1]]];
    } else if ([element.type isEqualToString:@"IntProduct"]) {
        intExpression = [[IntProduct alloc] initWith:[self convertToIntExpression:element.expression[0]] plus:[self convertToIntExpression:element.expression[1]]];
    } else if ([element.type isEqualToString:@"IntQuotient"]) {
        intExpression = [[IntQuotient alloc] initWith:[self convertToIntExpression:element.expression[0]] plus:[self convertToIntExpression:element.expression[1]]];
    } else if ([element.type isEqualToString:@"IntRemainder"]) {
        intExpression = [[IntRemainder alloc] initWith:[self convertToIntExpression:element.expression[0]] plus:[self convertToIntExpression:element.expression[1]]];
    } else {
        [NSException raise:@"Type does not exist." format:@"Type does not exist."];
    }
    return intExpression;
}

- (id <BoolExpression>) convertToBoolExpression:(ElementDB *) element {
    id <BoolExpression> boolExpression = nil;
    NSLog(@"  %@",element.type);
    if ([element.type isEqualToString:@"BoolValue"]) {
        boolExpression = [[BoolValue alloc] initWithValue:[element.integer intValue] != 0];
    } else if ([element.type isEqualToString:@"BoolVariable"]) {
        boolExpression = [[BoolVariable alloc] initWithVariable:element.string];
    } else if ([element.type isEqualToString:@"BoolArrayElement"]) {
        boolExpression = [self getBoolArrayElementVariable:element.string indexExpression:[self convertToIntExpression:element.expression[0]]];
    } else if ([element.type isEqualToString:@"BoolNegation"]) {
        boolExpression = [[BoolNegation alloc] initWith:[self convertToBoolExpression:element.expression[0]]];
    } else if ([element.type isEqualToString:@"BoolBoolEquals"]) {
        boolExpression = [[BoolBoolEquals alloc] initWith:[self convertToBoolExpression:element.expression[0]] BoolBoolEquals:[self convertToBoolExpression:element.expression[1]]];
    } else if ([element.type isEqualToString:@"BoolBoolDoesNotEqual"]) {
        boolExpression = [[BoolBoolDoesNotEqual alloc] initWith:[self convertToBoolExpression:element.expression[0]] BoolBoolDoesNotEqual:[self convertToBoolExpression:element.expression[1]]];
    } else if ([element.type isEqualToString:@"BoolOr"]) {
        boolExpression = [[BoolOr alloc] initWith:[self convertToBoolExpression:element.expression[0]] BoolOr:[self convertToBoolExpression:element.expression[1]]];
    } else if ([element.type isEqualToString:@"BoolNor"]) {
        boolExpression = [[BoolNor alloc] initWith:[self convertToBoolExpression:element.expression[0]] BoolNor:[self convertToBoolExpression:element.expression[1]]];
    } else if ([element.type isEqualToString:@"BoolAnd"]) {
        boolExpression = [[BoolAnd alloc] initWith:[self convertToBoolExpression:element.expression[0]] BoolAnd:[self convertToBoolExpression:element.expression[1]]];
    } else if ([element.type isEqualToString:@"BoolNand"]) {
        boolExpression = [[BoolNand alloc] initWith:[self convertToBoolExpression:element.expression[0]] BoolNand:[self convertToBoolExpression:element.expression[1]]];
    } else if ([element.type isEqualToString:@"BoolImplies"]) {
        boolExpression = [[BoolImplies alloc] initWith:[self convertToBoolExpression:element.expression[0]] BoolImplies:[self convertToBoolExpression:element.expression[1]]];
    } else if ([element.type isEqualToString:@"BoolNonImplies"]) {
        boolExpression = [[BoolNonImplies alloc] initWith:[self convertToBoolExpression:element.expression[0]] BoolNonImplies:[self convertToBoolExpression:element.expression[1]]];
    } else if ([element.type isEqualToString:@"BoolReverseImplies"]) {
        boolExpression = [[BoolReverseImplies alloc] initWith:[self convertToBoolExpression:element.expression[0]] BoolReverseImplies:[self convertToBoolExpression:element.expression[1]]];
    } else if ([element.type isEqualToString:@"BoolReverseNonImplies"]) {
        boolExpression = [[BoolReverseNonImplies alloc] initWith:[self convertToBoolExpression:element.expression[0]] BoolReverseNonImplies:[self convertToBoolExpression:element.expression[1]]];
    } else if ([element.type isEqualToString:@"BoolIntEquals"]) {
        boolExpression = [[BoolIntEquals alloc] initWith:[self convertToIntExpression:element.expression[0]] IntEquals:[self convertToIntExpression:element.expression[1]]];
    } else if ([element.type isEqualToString:@"BoolIntDoesNotEqual"]) {
        boolExpression = [[BoolIntDoesNotEqual alloc] initWith:[self convertToIntExpression:element.expression[0]] IntDoesNotEqual:[self convertToIntExpression:element.expression[1]]];
    } else if ([element.type isEqualToString:@"BoolLessThan"]) {
        boolExpression = [[BoolLessThan alloc] initWith:[self convertToIntExpression:element.expression[0]] LessThan:[self convertToIntExpression:element.expression[1]]];
    } else if ([element.type isEqualToString:@"BoolLessThanOrEquals"]) {
        boolExpression = [[BoolLessThanOrEquals alloc] initWith:[self convertToIntExpression:element.expression[0]] LessThanOrEquals:[self convertToIntExpression:element.expression[1]]];
    } else if ([element.type isEqualToString:@"BoolGreaterThan"]) {
        boolExpression = [[BoolGreaterThan alloc] initWith:[self convertToIntExpression:element.expression[0]] GreaterThan:[self convertToIntExpression:element.expression[1]]];
    } else if ([element.type isEqualToString:@"BoolGreaterThanOrEquals"]) {
        boolExpression = [[BoolGreaterThanOrEquals alloc] initWith:[self convertToIntExpression:element.expression[0]] GreaterThanOrEquals:[self convertToIntExpression:element.expression[1]]];
    } else {
        [NSException raise:@"Type does not exist." format:@"Type does not exist."];
    }
    return boolExpression;
}
@end
