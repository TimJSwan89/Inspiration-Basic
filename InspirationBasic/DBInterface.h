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
- (void) removeProgramInDBAtIndex:(long)index;
- (void) moveProgramInDBFromIndex:(long)fromIndex toIndex:(long)toIndex;
- (void) addProgramToDB:(Program *)program;
- (void) replaceProgramInDB:(Program *)program atIndex:(long)index;

@end
