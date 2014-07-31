
#import <Foundation/Foundation.h>
#import "ExpressionToDBVisitor.h"

#import "IntValue.h"
#import "IntValue.h"
#import "BoolValue.h"
#import "IntVariable.h"
#import "BoolVariable.h"
#import "IntArrayElement.h"
#import "BoolArrayElement.h"
#import "IntNegation.h"
#import "IntSum.h"
#import "IntDifference.h"
#import "IntProduct.h"
#import "IntQuotient.h"
#import "IntRemainder.h"
#import "BoolNegation.h"
#import "BoolBoolEquals.h"
#import "BoolBoolDoesNotEqual.h"
#import "BoolOr.h"
#import "BoolNor.h"
#import "BoolAnd.h"
#import "BoolNand.h"
#import "BoolImplies.h"
#import "BoolNonImplies.h"
#import "BoolReverseImplies.h"
#import "BoolReverseNonImplies.h"
#import "BoolIntEquals.h"
#import "BoolIntDoesNotEqual.h"
#import "BoolLessThan.h"
#import "BoolLessThanOrEquals.h"
#import "BoolGreaterThan.h"
#import "BoolGreaterThanOrEquals.h"

@implementation ExpressionToDBVisitor
- (id) init {
    if (self = [super init]) {
    }
    return self;
}

- (ElementDB *) createElementWithType:(NSString *)type {
    ElementDB * element = [NSEntityDescription insertNewObjectForEntityForName:@"ElementDB" inManagedObjectContext:self.context];
    element.type = type;
    element.integer = 0;
    element.string = @"";
    return element;
}

- (ElementDB *) addIntExpression:(id <IntExpression>)intExpression forContext:(NSManagedObjectContext *)context {
    self.context = context;
    return [self addIntExpression:intExpression];
}
- (ElementDB *) addBoolExpression:(id <BoolExpression>)boolExpression forContext:(NSManagedObjectContext *)context {
    self.context = context;
    return [self addBoolExpression:boolExpression];
}
- (ElementDB *) addIntExpression:(id <IntExpression>)intExpression {
    [intExpression accept:self];
    return self.element;
}
- (ElementDB *) addBoolExpression:(id <BoolExpression>)boolExpression {
    [boolExpression accept:self];
    return self.element;
}

- (void) visitIntValue:(IntValue *)intValue {
    ElementDB * element = [self createElementWithType:@"IntValue"];
    element.integer = [[NSNumber alloc] initWithInt:intValue.value];
    self.element = element;
}
- (void) visitBoolValue:(BoolValue *)boolValue {
    ElementDB * element = [self createElementWithType:@"BoolValue"];
    element.integer = [[NSNumber alloc] initWithInt:boolValue.value ? 1 : 0];
    self.element = element;
}
- (void) visitIntVariable:(IntVariable *)intVariable {
    ElementDB * element = [self createElementWithType:@"IntVariable"];
    element.string = intVariable.variable;
    self.element = element;
}
- (void) visitBoolVariable:(BoolVariable *)boolVariable {
    ElementDB * element = [self createElementWithType:@"BoolVariable"];
    element.string = boolVariable.variable;
    self.element = element;
}
- (void) visitIntArrayElement:(IntArrayElement *)intArrayElement {
    ElementDB * element = [self createElementWithType:@"IntArrayElement"];
    element.string = intArrayElement.variable;
    
    //The following is a necessary hack for the next commented line.
    NSMutableOrderedSet * tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:element.expression];
    [tempSet addObject:[self addIntExpression:intArrayElement.indexExpression]];
    element.expression = tempSet;
    //[element addExpressionObject:[self addIntExpression:intArrayElement.indexExpression]];
    
    self.element = element;
}
- (void) visitBoolArrayElement:(BoolArrayElement *)boolArrayElement {
    ElementDB * element = [self createElementWithType:@"BoolArrayElement"];
    element.string = boolArrayElement.variable;
    
    //The following is a necessary hack for the next commented line.
    NSMutableOrderedSet * tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:element.expression];
    [tempSet addObject:[self addIntExpression:boolArrayElement.indexExpression]];
    element.expression = tempSet;
    //[element addExpressionObject:[self addIntExpression:boolArrayElement.indexExpression]];
    
    self.element = element;
}
- (void) visitIntNegation:(IntNegation *)intNegation {
    ElementDB * element = [self createElementWithType:@"IntNegation"];
    
    //The following is a necessary hack for the next commented line.
    NSMutableOrderedSet * tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:element.expression];
    [tempSet addObject:[self addIntExpression:intNegation.expression]];
    element.expression = tempSet;
    //[element addExpressionObject:[self addIntExpression:intNegation.expression]];
    
    self.element = element;
}
- (void) visitIntSum:(IntSum *)intSum {
    ElementDB * element = [self createElementWithType:@"IntSum"];
    
    //The following is a necessary hack for the next commented lines.
    NSMutableOrderedSet * tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:element.expression];
    [tempSet addObject:[self addIntExpression:intSum.expression1]];
    [tempSet addObject:[self addIntExpression:intSum.expression2]];
    element.expression = tempSet;
    //[element addExpressionObject:[self addIntExpression:intSum.expression1]];
    //[element addExpressionObject:[self addIntExpression:intSum.expression2]];
    
    self.element = element;
}
- (void) visitIntDifference:(IntDifference *)intDifference {
    ElementDB * element = [self createElementWithType:@"IntDifference"];
    
    //The following is a necessary hack for the next commented lines.
    NSMutableOrderedSet * tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:element.expression];
    [tempSet addObject:[self addIntExpression:intDifference.expression1]];
    [tempSet addObject:[self addIntExpression:intDifference.expression2]];
    element.expression = tempSet;
    //[element addExpressionObject:[self addIntExpression:intDifference.expression1]];
    //[element addExpressionObject:[self addIntExpression:intDifference.expression2]];
    
    self.element = element;
}
- (void) visitIntProduct:(IntProduct *)intProduct {
    ElementDB * element = [self createElementWithType:@"IntProduct"];
    
    //The following is a necessary hack for the next commented lines.
    NSMutableOrderedSet * tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:element.expression];
    [tempSet addObject:[self addIntExpression:intProduct.expression1]];
    [tempSet addObject:[self addIntExpression:intProduct.expression2]];
    element.expression = tempSet;
    //[element addExpressionObject:[self addIntExpression:intProduct.expression1]];
    //[element addExpressionObject:[self addIntExpression:intProduct.expression2]];
    
    self.element = element;
}
- (void) visitIntQuotient:(IntQuotient *)intQuotient {
    ElementDB * element = [self createElementWithType:@"IntQuotient"];
    
    //The following is a necessary hack for the next commented lines.
    NSMutableOrderedSet * tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:element.expression];
    [tempSet addObject:[self addIntExpression:intQuotient.expression1]];
    [tempSet addObject:[self addIntExpression:intQuotient.expression2]];
    element.expression = tempSet;
    //[element addExpressionObject:[self addIntExpression:intQuotient.expression1]];
    //[element addExpressionObject:[self addIntExpression:intQuotient.expression2]];
    
    self.element = element;
}
- (void) visitIntRemainder:(IntRemainder *)intRemainder {
    ElementDB * element = [self createElementWithType:@"IntRemainder"];
    
    //The following is a necessary hack for the next commented lines.
    NSMutableOrderedSet * tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:element.expression];
    [tempSet addObject:[self addIntExpression:intRemainder.expression1]];
    [tempSet addObject:[self addIntExpression:intRemainder.expression2]];
    element.expression = tempSet;
    //[element addExpressionObject:[self addIntExpression:intRemainder.expression1]];
    //[element addExpressionObject:[self addIntExpression:intRemainder.expression2]];
    
    self.element = element;
}
- (void) visitBoolNegation:(BoolNegation *)boolNegation {
    ElementDB * element = [self createElementWithType:@"BoolNegation"];
    
    //The following is a necessary hack for the next commented line.
    NSMutableOrderedSet * tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:element.expression];
    [tempSet addObject:[self addBoolExpression:boolNegation.expression]];
    element.expression = tempSet;
    //[element addExpressionObject:[self addBoolExpression:intRemainder.expression]];
    
    self.element = element;
}
- (void) visitBoolBoolEquals:(BoolBoolEquals *)boolBoolEquals {
    ElementDB * element = [self createElementWithType:@"BoolBoolEquals"];
    
    //The following is a necessary hack for the next commented lines.
    NSMutableOrderedSet * tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:element.expression];
    [tempSet addObject:[self addBoolExpression:boolBoolEquals.expression1]];
    [tempSet addObject:[self addBoolExpression:boolBoolEquals.expression2]];
    element.expression = tempSet;
    //[element addExpressionObject:[self addBoolExpression:boolBoolEquals.expression1]];
    //[element addExpressionObject:[self addBoolExpression:boolBoolEquals.expression2]];
    
    self.element = element;
}
- (void) visitBoolBoolDoesNotEqual:(BoolBoolDoesNotEqual *)boolBoolDoesNotEqual {
    ElementDB * element = [self createElementWithType:@"BoolBoolDoesNotEqual"];
    
    //The following is a necessary hack for the next commented lines.
    NSMutableOrderedSet * tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:element.expression];
    [tempSet addObject:[self addBoolExpression:boolBoolDoesNotEqual.expression1]];
    [tempSet addObject:[self addBoolExpression:boolBoolDoesNotEqual.expression2]];
    element.expression = tempSet;
    //[element addExpressionObject:[self addBoolExpression:boolBoolDoesNotEqual.expression1]];
    //[element addExpressionObject:[self addBoolExpression:boolBoolDoesNotEqual.expression2]];
    
    self.element = element;
}
- (void) visitBoolOr:(BoolOr *)boolOr {
    ElementDB * element = [self createElementWithType:@"BoolOr"];
    
    //The following is a necessary hack for the next commented lines.
    NSMutableOrderedSet * tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:element.expression];
    [tempSet addObject:[self addBoolExpression:boolOr.expression1]];
    [tempSet addObject:[self addBoolExpression:boolOr.expression2]];
    element.expression = tempSet;
    //[element addExpressionObject:[self addBoolExpression:boolOr.expression1]];
    //[element addExpressionObject:[self addBoolExpression:boolOr.expression2]];
    
    self.element = element;
}
- (void) visitBoolNor:(BoolNor *)boolNor {
    ElementDB * element = [self createElementWithType:@"BoolNor"];
    
    //The following is a necessary hack for the next commented lines.
    NSMutableOrderedSet * tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:element.expression];
    [tempSet addObject:[self addBoolExpression:boolNor.expression1]];
    [tempSet addObject:[self addBoolExpression:boolNor.expression2]];
    element.expression = tempSet;
    //[element addExpressionObject:[self addBoolExpression:boolNor.expression1]];
    //[element addExpressionObject:[self addBoolExpression:boolNor.expression2]];
    
    self.element = element;
}
- (void) visitBoolAnd:(BoolAnd *)boolAnd {
    ElementDB * element = [self createElementWithType:@"BoolAnd"];
    
    //The following is a necessary hack for the next commented lines.
    NSMutableOrderedSet * tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:element.expression];
    [tempSet addObject:[self addBoolExpression:boolAnd.expression1]];
    [tempSet addObject:[self addBoolExpression:boolAnd.expression2]];
    element.expression = tempSet;
    //[element addExpressionObject:[self addBoolExpression:boolAnd.expression1]];
    //[element addExpressionObject:[self addBoolExpression:boolAnd.expression2]];
    
    self.element = element;
}
- (void) visitBoolNand:(BoolNand *)boolNand {
    ElementDB * element = [self createElementWithType:@"BoolNand"];
    
    //The following is a necessary hack for the next commented lines.
    NSMutableOrderedSet * tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:element.expression];
    [tempSet addObject:[self addBoolExpression:boolNand.expression1]];
    [tempSet addObject:[self addBoolExpression:boolNand.expression2]];
    element.expression = tempSet;
    //[element addExpressionObject:[self addBoolExpression:boolNand.expression1]];
    //[element addExpressionObject:[self addBoolExpression:boolNand.expression2]];
    
    self.element = element;
}
- (void) visitBoolImplies:(BoolImplies *)boolImplies {
    ElementDB * element = [self createElementWithType:@"BoolImplies"];
    
    //The following is a necessary hack for the next commented lines.
    NSMutableOrderedSet * tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:element.expression];
    [tempSet addObject:[self addBoolExpression:boolImplies.expression1]];
    [tempSet addObject:[self addBoolExpression:boolImplies.expression2]];
    element.expression = tempSet;
    //[element addExpressionObject:[self addBoolExpression:boolImplies.expression1]];
    //[element addExpressionObject:[self addBoolExpression:boolImplies.expression2]];
    
    self.element = element;
}
- (void) visitBoolNonImplies:(BoolNonImplies *)boolNonImplies {
    ElementDB * element = [self createElementWithType:@"BoolNonImplies"];
    
    //The following is a necessary hack for the next commented lines.
    NSMutableOrderedSet * tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:element.expression];
    [tempSet addObject:[self addBoolExpression:boolNonImplies.expression1]];
    [tempSet addObject:[self addBoolExpression:boolNonImplies.expression2]];
    element.expression = tempSet;
    //[element addExpressionObject:[self addBoolExpression:boolNonImplies.expression1]];
    //[element addExpressionObject:[self addBoolExpression:boolNonImplies.expression2]];
    
    self.element = element;
}
- (void) visitBoolReverseImplies:(BoolReverseImplies *)boolReverseImplies {
    ElementDB * element = [self createElementWithType:@"BoolReverseImplies"];
    
    //The following is a necessary hack for the next commented lines.
    NSMutableOrderedSet * tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:element.expression];
    [tempSet addObject:[self addBoolExpression:boolReverseImplies.expression1]];
    [tempSet addObject:[self addBoolExpression:boolReverseImplies.expression2]];
    element.expression = tempSet;
    //[element addExpressionObject:[self addBoolExpression:boolReverseImplies.expression1]];
    //[element addExpressionObject:[self addBoolExpression:boolReverseImplies.expression2]];
    
    self.element = element;
}
- (void) visitBoolReverseNonImplies:(BoolReverseNonImplies *)boolReverseNonImplies {
    ElementDB * element = [self createElementWithType:@"BoolReverseNonImplies"];
    
    //The following is a necessary hack for the next commented lines.
    NSMutableOrderedSet * tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:element.expression];
    [tempSet addObject:[self addBoolExpression:boolReverseNonImplies.expression1]];
    [tempSet addObject:[self addBoolExpression:boolReverseNonImplies.expression2]];
    element.expression = tempSet;
    //[element addExpressionObject:[self addBoolExpression:boolReverseNonImplies.expression1]];
    //[element addExpressionObject:[self addBoolExpression:boolReverseNonImplies.expression2]];
    
    self.element = element;
}
- (void) visitBoolIntEquals:(BoolIntEquals *)boolIntEquals {
    ElementDB * element = [self createElementWithType:@"BoolIntEquals"];
    
    //The following is a necessary hack for the next commented lines.
    NSMutableOrderedSet * tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:element.expression];
    [tempSet addObject:[self addIntExpression:boolIntEquals.expression1]];
    [tempSet addObject:[self addIntExpression:boolIntEquals.expression2]];
    element.expression = tempSet;
    //[element addExpressionObject:[self addIntExpression:boolIntEquals.expression1]];
    //[element addExpressionObject:[self addIntExpression:boolIntEquals.expression2]];
    
    self.element = element;
}
- (void) visitBoolIntDoesNotEqual:(BoolIntDoesNotEqual *)boolIntDoesNotEqual {
    ElementDB * element = [self createElementWithType:@"BoolIntDoesNotEqual"];
    
    //The following is a necessary hack for the next commented lines.
    NSMutableOrderedSet * tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:element.expression];
    [tempSet addObject:[self addIntExpression:boolIntDoesNotEqual.expression1]];
    [tempSet addObject:[self addIntExpression:boolIntDoesNotEqual.expression2]];
    element.expression = tempSet;
    //[element addExpressionObject:[self addIntExpression:boolIntDoesNotEqual.expression1]];
    //[element addExpressionObject:[self addIntExpression:boolIntDoesNotEqual.expression2]];
    
    self.element = element;
}
- (void) visitBoolLessThan:(BoolLessThan *)boolLessThan {
    ElementDB * element = [self createElementWithType:@"BoolLessThan"];
    
    //The following is a necessary hack for the next commented lines.
    NSMutableOrderedSet * tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:element.expression];
    [tempSet addObject:[self addIntExpression:boolLessThan.expression1]];
    [tempSet addObject:[self addIntExpression:boolLessThan.expression2]];
    element.expression = tempSet;
    //[element addExpressionObject:[self addIntExpression:boolLessThan.expression1]];
    //[element addExpressionObject:[self addIntExpression:boolLessThan.expression2]];
    
    self.element = element;
}
- (void) visitBoolLessThanOrEquals:(BoolLessThanOrEquals *)boolLessThanOrEquals {
    ElementDB * element = [self createElementWithType:@"BoolLessThanOrEquals"];
    
    //The following is a necessary hack for the next commented lines.
    NSMutableOrderedSet * tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:element.expression];
    [tempSet addObject:[self addIntExpression:boolLessThanOrEquals.expression1]];
    [tempSet addObject:[self addIntExpression:boolLessThanOrEquals.expression2]];
    element.expression = tempSet;
    //[element addExpressionObject:[self addIntExpression:boolLessThanOrEquals.expression1]];
    //[element addExpressionObject:[self addIntExpression:boolLessThanOrEquals.expression2]];
    
    self.element = element;
}
- (void) visitBoolGreaterThan:(BoolGreaterThan *)boolGreaterThan {
    ElementDB * element = [self createElementWithType:@"BoolGreaterThan"];
    
    //The following is a necessary hack for the next commented lines.
    NSMutableOrderedSet * tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:element.expression];
    [tempSet addObject:[self addIntExpression:boolGreaterThan.expression1]];
    [tempSet addObject:[self addIntExpression:boolGreaterThan.expression2]];
    element.expression = tempSet;
    //[element addExpressionObject:[self addIntExpression:boolGreaterThan.expression1]];
    //[element addExpressionObject:[self addIntExpression:boolGreaterThan.expression2]];
    
    self.element = element;
}
- (void) visitBoolGreaterThanOrEquals:(BoolGreaterThanOrEquals *)boolGreaterThanOrEquals {
    ElementDB * element = [self createElementWithType:@"BoolGreaterThanOrEquals"];
    
    //The following is a necessary hack for the next commented lines.
    NSMutableOrderedSet * tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:element.expression];
    [tempSet addObject:[self addIntExpression:boolGreaterThanOrEquals.expression1]];
    [tempSet addObject:[self addIntExpression:boolGreaterThanOrEquals.expression2]];
    element.expression = tempSet;
    //[element addExpressionObject:[self addIntExpression:boolGreaterThanOrEquals.expression1]];
    //[element addExpressionObject:[self addIntExpression:boolGreaterThanOrEquals.expression2]];
    
    self.element = element;
}

@end
