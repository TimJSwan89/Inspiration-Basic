//
//  EnvironmentModel.h
//  InspirationBasic
//
//  Created by Timothy Swan on 5/28/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Value.h"
#import "ProgramException.h"
#import "OutputListener.h"
@class ProgramException;

@interface EnvironmentModel : NSObject

@property (nonatomic, retain) NSMutableDictionary *dictionary;
@property (nonatomic, retain) NSMutableDictionary *arrayDictionary;
@property (nonatomic, retain) ProgramException *exception;

@property (nonatomic) id <OutputListener> listener;

-(id) initWithOutputListener:(id <OutputListener>) listener;

-(void)printLine: (NSString *)string;

-(void)setValue: (Value*)value For: (NSString *)variableName;

-(void)setValue: (Value*)value For: (NSString *)variableName atIndex: (int) index;

-(Value*)getValueFor: (NSString *)variableName;

-(Value*)getValueFor: (NSString *)variableName atIndex: (int) index;

@end
