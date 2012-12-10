//
//  ViewController.h
//  SocialMedia
//
//  Created by Paradigm on 12/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TwitterManger;
@interface ViewController : UIViewController
{
    TwitterManger *sharedTwitterSingleton;
    
}
- (IBAction)connectFaceBook:(id)sender;
- (IBAction)connectTwitter:(id)sender;

@end
