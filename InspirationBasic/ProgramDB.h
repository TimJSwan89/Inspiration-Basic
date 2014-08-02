//
//  ProgramDB.h
//  InspirationBasic
//
//  Created by Timothy Swan on 8/1/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ElementDB, ProgramListDB;

@interface ProgramDB : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSOrderedSet *programChild;
@property (nonatomic, retain) ProgramListDB *programList;
@end

@interface ProgramDB (CoreDataGeneratedAccessors)

- (void)insertObject:(ElementDB *)value inProgramChildAtIndex:(NSUInteger)idx;
- (void)removeObjectFromProgramChildAtIndex:(NSUInteger)idx;
- (void)insertProgramChild:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeProgramChildAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInProgramChildAtIndex:(NSUInteger)idx withObject:(ElementDB *)value;
- (void)replaceProgramChildAtIndexes:(NSIndexSet *)indexes withProgramChild:(NSArray *)values;
- (void)addProgramChildObject:(ElementDB *)value;
- (void)removeProgramChildObject:(ElementDB *)value;
- (void)addProgramChild:(NSOrderedSet *)values;
- (void)removeProgramChild:(NSOrderedSet *)values;
@end
