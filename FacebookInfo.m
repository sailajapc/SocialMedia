//
//  FacebookInfo.m
//  SocialMedia
//
//  Created by Nagesh Kumar Mishra on 08/01/13.
//
//

#import "FacebookInfo.h"

@implementation FacebookInfo
@synthesize userID;
@synthesize userName;

- (void)dealloc
{
    [userName release];
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
