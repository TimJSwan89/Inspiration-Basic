#import <Foundation/Foundation.h>
#import "ExpressionVisitor.h"
#import "ElementDB.h"
#import "IntExpression.h"
#import "BoolExpression.h"

@class IntValue;
@class BoolValue;
@class IntVariable;
@class BoolVariable;
@class IntArrayElement;
@class BoolArrayElement;
@class IntNegation;
@class IntSum;
@class IntDifference;
@class IntProduct;
@class IntQuotient;
@class IntRemainder;
@class BoolNegation;
@class BoolBoolEquals;
@class BoolBoolDoesNotEqual;
@class BoolOr;
@class BoolNor;
@class BoolAnd;
@class BoolNand;
@class BoolImplies;
@class BoolNonImplies;
@class BoolReverseImplies;
@class BoolReverseNonImplies;
@class BoolIntEquals;
@class BoolIntDoesNotEqual;
@class BoolLessThan;
@class BoolLessThanOrEquals;
@class BoolGreaterThan;
@class BoolGreaterThanOrEquals;

@interface ExpressionToDBVisitor : NSObject <ExpressionVisitor>

@property NSManagedObjectContext * context;
@property ElementDB * element;

- (id) init;

- (ElementDB *) addIntExpression:(id <IntExpression>)intExpression forContext:(NSManagedObjectContext *)context;
- (ElementDB *) addBoolExpression:(id <BoolExpression>)boolExpression forContext:(NSManagedObjectContext *)context;

- (void) visitIntValue:(IntValue *)intValue;
- (void) visitBoolValue:(BoolValue *)boolValue;
- (void) visitIntVariable:(IntVariable *)intVariable;
- (void) visitBoolVariable:(BoolVariable *)boolVariable;
- (void) visitIntArrayElement:(IntArrayElement *)intArrayElement;
- (void) visitBoolArrayElement:(BoolArrayElement *)boolArrayElement;
- (void) visitIntNegation:(IntNegation *)intNegation;
- (void) visitIntSum:(IntSum *)intSum;
- (void) visitIntDifference:(IntDifference *)intDifference;
- (void) visitIntProduct:(IntProduct *)intProduct;
- (void) visitIntQuotient:(IntQuotient *)intQuotient;
- (void) visitIntRemainder:(IntRemainder *)intRemainder;
- (void) visitBoolNegation:(BoolNegation *)boolNegation;
- (void) visitBoolBoolEquals:(BoolBoolEquals *)boolBoolEquals;
- (void) visitBoolBoolDoesNotEqual:(BoolBoolDoesNotEqual *)boolBoolDoesNotEqual;
- (void) visitBoolOr:(BoolOr *)boolOr;
- (void) visitBoolNor:(BoolNor *)boolNor;
- (void) visitBoolAnd:(BoolAnd *)boolAnd;
- (void) visitBoolNand:(BoolNand *)boolNand;
- (void) visitBoolImplies:(BoolImplies *)boolImplies;
- (void) visitBoolNonImplies:(BoolNonImplies *)boolNonImplies;
- (void) visitBoolReverseImplies:(BoolReverseImplies *)boolReverseImplies;
- (void) visitBoolReverseNonImplies:(BoolReverseNonImplies *)boolReverseNonImplies;
- (void) visitBoolIntEquals:(BoolIntEquals *)boolIntEquals;
- (void) visitBoolIntDoesNotEqual:(BoolIntDoesNotEqual *)boolIntDoesNotEqual;
- (void) visitBoolLessThan:(BoolLessThan *)boolLessThan;
- (void) visitBoolLessThanOrEquals:(BoolLessThanOrEquals *)boolLessThanOrEquals;
- (void) visitBoolGreaterThan:(BoolGreaterThan *)boolGreaterThan;
- (void) visitBoolGreaterThanOrEquals:(BoolGreaterThanOrEquals *)boolGreaterThanOrEquals;

@end
