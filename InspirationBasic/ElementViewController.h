//
//  StatementViewController.h
//  InspirationBasic
//
//  Created by Timothy Swan on 6/1/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Program.h"
#import "ComponentViewController.h"
#import "ViewSettings.h"

@protocol Reloadable
- (void) reload;
@end

@interface ElementViewController : UITableViewController<ElementAccepter, Reloadable, ScopeFinder, SpecificScopeFinder, VarAccepter>

@property (nonatomic) id element;
@property (nonatomic) long type;
@property NSMutableArray * typesIndex;
@property NSMutableArray * types;
@property NSMutableArray * elements;
@property NSMutableArray * strings;
@property ViewSettings * settings;
@property (nonatomic) id <ElementAccepter, Reloadable, SpecificScopeFinder> delegate;

- (void) initCellModels;
- (void) acceptElement:(id)element;
- (void) reload;
- (NSMutableArray *) getScope:(int)type;
- (void) acceptVar:(NSString *)variable;

@end
