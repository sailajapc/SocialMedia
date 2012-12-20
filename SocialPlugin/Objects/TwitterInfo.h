//
//  TwitterInfo.h
//  SocialMedia
//
//  Created by Nagesh Kumar Mishra on 10/12/12.
//
//

#import <Foundation/Foundation.h>

@interface TwitterInfo : NSObject
{
    NSString *userName;
    NSString *imageUrl;
    int userID;
}

@property (nonatomic,assign) int userID;
@property (nonatomic, retain) NSString *userName;
@property (nonatomic, retain) NSString *imageUrl;



@end
