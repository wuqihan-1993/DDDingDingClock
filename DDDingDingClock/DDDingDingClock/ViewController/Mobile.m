//
//  Mobile.m
//  DDDingDingClock
//
//  Created by wuqh on 2019/3/4.
//  Copyright © 2019 wuqh. All rights reserved.
//

#import "Mobile.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

@implementation Mobile

+ (NSString *)phone {
    return CTSettingCopyMyPhoneNumber();        
}
@end
