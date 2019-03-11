//
//  Mobile.h
//  DDDingDingClock
//
//  Created by wuqh on 2019/3/4.
//  Copyright © 2019 wuqh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString *CTSettingCopyMyPhoneNumber();

@interface Mobile : NSObject

+ (NSString*)phone;

@end

NS_ASSUME_NONNULL_END
