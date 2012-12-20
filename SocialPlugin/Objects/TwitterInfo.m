//
//  TwitterInfo.m
//  SocialMedia
//
//  Created by Nagesh Kumar Mishra on 10/12/12.
//
//

#import "TwitterInfo.h"

@implementation TwitterInfo
@synthesize userID;
@synthesize imageUrl;
@synthesize userName;

- (void)dealloc
{
    [userName release];
    [imageUrl release];
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self)
    {
    }
    return self;
}

@end
