//
//  ElementDB.h
//  InspirationBasic
//
//  Created by Timothy Swan on 8/1/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ElementDB, ProgramDB;

@interface ElementDB : NSManagedObject

@property (nonatomic, retain) NSNumber * integer;
@property (nonatomic, retain) NSString * string;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSOrderedSet *child;
@property (nonatomic, retain) NSOrderedSet *expression;
@property (nonatomic, retain) ElementDB *expressionContainer;
@property (nonatomic, retain) ElementDB *parent;
@property (nonatomic, retain) ProgramDB *programParent;
@end

@interface ElementDB (CoreDataGeneratedAccessors)

- (void)insertObject:(ElementDB *)value inChildAtIndex:(NSUInteger)idx;
- (void)removeObjectFromChildAtIndex:(NSUInteger)idx;
- (void)insertChild:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeChildAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInChildAtIndex:(NSUInteger)idx withObject:(ElementDB *)value;
- (void)replaceChildAtIndexes:(NSIndexSet *)indexes withChild:(NSArray *)values;
- (void)addChildObject:(ElementDB *)value;
- (void)removeChildObject:(ElementDB *)value;
- (void)addChild:(NSOrderedSet *)values;
- (void)removeChild:(NSOrderedSet *)values;
- (void)insertObject:(ElementDB *)value inExpressionAtIndex:(NSUInteger)idx;
- (void)removeObjectFromExpressionAtIndex:(NSUInteger)idx;
- (void)insertExpression:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeExpressionAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInExpressionAtIndex:(NSUInteger)idx withObject:(ElementDB *)value;
- (void)replaceExpressionAtIndexes:(NSIndexSet *)indexes withExpression:(NSArray *)values;
- (void)addExpressionObject:(ElementDB *)value;
- (void)removeExpressionObject:(ElementDB *)value;
- (void)addExpression:(NSOrderedSet *)values;
- (void)removeExpression:(NSOrderedSet *)values;
@end
