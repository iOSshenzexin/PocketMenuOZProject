//
//  ZXLoginMessageModel.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/11/30.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXLoginMessageModel.h"

@interface ZXLoginMessageModel()<NSCoding>

@end

@implementation ZXLoginMessageModel

/*
 "member_email" = "10452502@qq.com";
 "member_id" = 16;
 "member_mobile" = 15192712514;
 "member_name" = st1234567;
 "member_old_login_time" = "";
 */

- (void)encodeWithCoder:(NSCoder*)coder
{
    [coder encodeObject:self.member_email forKey:@"member_email"];
    
    [coder encodeInteger:self.member_id forKey:@"member_id"];
    
    [coder encodeObject:self.member_mobile forKey:@"member_mobile"];
    
    [coder encodeObject:self.member_name forKey:@"member_name"];
    
    [coder encodeObject:self.member_old_login_time forKey:@"member_old_login_time"];
}

- (id)initWithCoder:(NSCoder*)decoder
{
    if (self = [super init])
    {
        self.member_email = [decoder decodeObjectForKey:@"member_email"];
        
        self.member_id = [decoder decodeIntegerForKey:@"member_id"];
        
        self.member_mobile = [decoder decodeObjectForKey:@"member_mobile"];
        
        self.member_name = [decoder decodeObjectForKey:@"member_name"];
        
        self.member_old_login_time = [decoder decodeObjectForKey:@"member_old_login_time"];
    }
    return self;
}



@end
