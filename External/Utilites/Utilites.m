//
//  Utilites.m
//  TwitterApp
//
//  Created by Nagesh Kumar Mishra on 07/12/12.
//  Copyright (c) 2012 Nagesh Kumar Mishra. All rights reserved.
//

#import "Utilites.h"

@implementation Utilites

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message delegate:(id <UIAlertViewDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
    
    if (otherButtonTitles != nil) {
        [alertView addButtonWithTitle:otherButtonTitles];
        va_list args;
        va_start(args, otherButtonTitles);
        NSString * title = va_arg(args,NSString*);
        while(title) {
            [alertView addButtonWithTitle:title];
        }
        va_end(args);
    }
    
    [alertView show];
    [alertView release];

}


@end
