//
//  StatementCell.h
//  InspirationBasic
//
//  Created by Timothy Swan on 8/8/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StatementCell : UITableViewCell
@property int reduceBy;
@property bool hasXButton;
- (void) reduceSize:(int)i;

@end
