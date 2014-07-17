//
//  Program.h
//  InspirationBasic
//
//  Created by Timothy Swan on 6/1/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StatementList.h"
#import "EnvironmentModel.h"

@interface Program : StatementList <Statement>

@property (nonatomic) NSString * title;

//@property (nonatomic) EnvironmentModel * environment;

- (id) initWithTitle: (NSString *)title;

- (void) executeWithListener: (id <OutputListener>) listener;

- (void) executeProgramAgainst:(EnvironmentModel *)environment; // For debugging/testing

@end
