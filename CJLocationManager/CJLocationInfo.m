//
//  CJLocationInfo.m
//  CommonProject
//
//  Created by zhuChaojun的Mac on 2016/2/9.
//  Copyright © 2016年 zhucj. All rights reserved.
//

#import "CJLocationInfo.h"

@implementation CJLocationInfo


-(void)setLocationInfo:(NSString *)locationInfo {
   _locationInfo =  [locationInfo stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
}

@end
