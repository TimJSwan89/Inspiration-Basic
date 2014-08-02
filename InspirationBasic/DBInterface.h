#import <Foundation/Foundation.h>
#import "StatementVisitor.h"
#import "ProgramListDB.h"
#import "Program.h"
#import "StatementToDBVisitor.h"

@interface DBInterface : NSObject

@property ProgramListDB * list;
@property NSManagedObjectContext * context;
@property StatementToDBVisitor * visitor;

- (id) initWithContext:(NSManagedObjectContext *)context;
- (NSMutableArray *) loadPrograms;
- (void) removeProgramInDBAtIndex:(int)index;
- (void) moveProgramInDBFromIndex:(int)fromIndex toIndex:(int)toIndex;
- (void) addProgramToDB:(Program *)program;
- (void) replaceProgramInDB:(Program *)program atIndex:(int)index;

@end
