//
//  CJLocationInfo.h
//  CommonProject
//
//  Created by 仁和Mac on 2018/2/9.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CJLocationInfo : NSObject

/// 国家
@property(nonatomic, strong) NSString *country;

/// 省
@property(nonatomic, strong) NSString *province;

/// 市
@property(nonatomic, strong) NSString *city;

/// 区
@property(nonatomic, strong) NSString *district;

/// 街道
@property(nonatomic, strong) NSString *street;

/// 子街道
@property(nonatomic, strong) NSString *subSteet;

/// 邮编
@property(nonatomic, strong) NSString *postalCode;

/// 经度
@property(nonatomic, assign) CGFloat  longitude;

/// 维度
@property(nonatomic, assign) CGFloat latitude;

/// 具体位置
@property(nonatomic, strong) NSString *specificLocation;

/// 位置信息
@property(nonatomic, strong) NSString *locationInfo;

@end
