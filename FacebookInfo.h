//
//  FacebookInfo.h
//  SocialMedia
//
//  Created by Nagesh Kumar Mishra on 08/01/13.
//
//

#import <Foundation/Foundation.h>

@interface FacebookInfo : NSObject
{
    NSString *userName;
    int userID;
}

@property (nonatomic,assign) int userID;
@property (nonatomic, retain) NSString *userName;



@end

