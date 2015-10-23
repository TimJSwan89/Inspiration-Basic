//
//  QuickSegue.m
//  InspirationBasic
//
//  Created by Timothy Swan on 8/10/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import "QuickSegue.h"

@implementation QuickSegue

-(void) perform{
//    UIViewController *sourceViewController = (UIViewController*)[self sourceViewController];
//    UIViewController *destinationController = (UIViewController*)[self destinationViewController];
//    
//    CATransition* transition = [CATransition animation];
//    transition.duration = .06;
//    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    transition.type = kCATransitionPush; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
//    transition.subtype = kCATransitionFromRight; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
//    
//    
//    
//    [sourceViewController.navigationController.view.layer addAnimation:transition
//                                                                forKey:kCATransition];
//    
//    [sourceViewController.navigationController pushViewController:destinationController animated:NO];
    
    [[[self sourceViewController] navigationController] pushViewController:[self   destinationViewController] animated:NO];
}

@end