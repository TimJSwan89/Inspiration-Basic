//
//  WrappedProgram.h
//  InspirationBasic
//
//  Created by Timothy Swan on 8/10/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Program.h"
#import "ProgramViewController.h"
@interface WrappedProgram : NSObject
@property Program * program;
@property bool executing;
@property ProgramViewController * pvc;
@end
