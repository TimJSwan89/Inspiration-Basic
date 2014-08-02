//
//  ProgramListDB.h
//  InspirationBasic
//
//  Created by Timothy Swan on 8/1/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ProgramDB;

@interface ProgramListDB : NSManagedObject

@property (nonatomic, retain) NSOrderedSet *program;
@end

@interface ProgramListDB (CoreDataGeneratedAccessors)

- (void)insertObject:(ProgramDB *)value inProgramAtIndex:(NSUInteger)idx;
- (void)removeObjectFromProgramAtIndex:(NSUInteger)idx;
- (void)insertProgram:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeProgramAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInProgramAtIndex:(NSUInteger)idx withObject:(ProgramDB *)value;
- (void)replaceProgramAtIndexes:(NSIndexSet *)indexes withProgram:(NSArray *)values;
- (void)addProgramObject:(ProgramDB *)value;
- (void)removeProgramObject:(ProgramDB *)value;
- (void)addProgram:(NSOrderedSet *)values;
- (void)removeProgram:(NSOrderedSet *)values;
@end
