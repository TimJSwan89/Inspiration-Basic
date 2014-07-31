#import <Foundation/Foundation.h>
#import "StatementVisitor.h"

@interface DBToStatementVisitor : NSObject

- (id) init;
- (NSMutableArray *) loadProgramsFromDBContext:(NSManagedObjectContext *)context;

@end
