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

@property (nonatomic, retain) NSMutableDictionary * intDictionary;
@property (nonatomic, retain) NSMutableDictionary * boolDictionary;
@property (nonatomic, retain) NSMutableDictionary * intArrayDictionary;
@property (nonatomic, retain) NSMutableDictionary * boolArrayDictionary;
@property (nonatomic, retain) ProgramException * exception;

@property (nonatomic) id <OutputListener> listener;

-(id) initWithOutputListener:(id <OutputListener>) listener;

-(void)printLine: (NSString *)string;

-(void)setInt: (Value *)value For: (NSString *)variableName;
-(void)setBool: (Value *)value For: (NSString *)variableName;
-(void)setInt: (Value *)value For: (NSString *)variableName atIndex: (int) index;
-(void)setBool: (Value *)value For: (NSString *)variableName atIndex: (int) index;
-(Value*)getIntFor: (NSString *)variableName;
-(Value*)getBoolFor: (NSString *)variableName;
-(Value*)getIntFor: (NSString *)variableName atIndex: (int) index;
-(Value*)getBoolFor: (NSString *)variableName atIndex: (int) index;
@end
