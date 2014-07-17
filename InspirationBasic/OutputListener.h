//
//  OutputListener.h
//  InspirationBasic
//
//  Created by Timothy Swan on 6/15/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OutputListener <NSObject>

- (void) postOutput:(NSString *) string;

@end
