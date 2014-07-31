#import <Foundation/Foundation.h>
#import "StatementVisitor.h"
#import "Program.h"
#import "ElementDB.h"
@class StatementList;
@class PrintInt;
@class PrintBool;
@class IntAssignment;
@class BoolAssignment;
@class IntArrayElementAssignment;
@class BoolArrayElementAssignment;
@class IfThenElseEndIf;
@class IfThenEndIf;
@class WhileEndWhile;

@interface StatementToDBVisitor : NSObject <StatementVisitor>

@property ElementDB * element;
@property NSManagedObjectContext * context;

- (id) init;
- (void) saveProgramToDB:(Program *)program context:(NSManagedObjectContext *)context;
- (void) visitPrintInt:(PrintInt *)printInt;
- (void) visitPrintBool:(PrintBool *)printBool;
- (void) visitIntAssigment:(IntAssignment *)intAssignment;
- (void) visitBoolAssigment:(BoolAssignment *)boolAssignment;
- (void) visitIntArrayElementAssignment:(IntArrayElementAssignment *)intArrayElementAssignment;
- (void) visitBoolArrayElementAssignment:(BoolArrayElementAssignment *)boolArrayElementAssignment;
- (void) visitIfThenElseEndIf:(IfThenElseEndIf *)ifThenElseEndIf;
- (void) visitIfThenEndIf:(IfThenEndIf *)ifThenEndIf;
- (void) visitStatementList:(StatementList *)statementList;
- (void) visitWhileEndWhile:(WhileEndWhile *)whileEndWhile;

@end
