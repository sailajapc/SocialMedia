//
//  Utilites.h
//  TwitterApp
//
//  Created by Nagesh Kumar Mishra on 07/12/12.
//  Copyright (c) 2012 Nagesh Kumar Mishra. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utilites : NSObject

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message delegate:(id <UIAlertViewDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION ;

@end
