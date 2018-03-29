//
//  CJLocationInfo.m
//  CommonProject
//
//  Created by 仁和Mac on 2018/2/9.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "CJLocationInfo.h"

@implementation CJLocationInfo


-(void)setLocationInfo:(NSString *)locationInfo {
   _locationInfo =  [locationInfo stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
}

@end
