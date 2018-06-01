//
//  CJLocationManager.h
//  CommonProject
//
//  Created by 仁和Mac on 2018/2/9.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "CJLocationInfo.h"

typedef void(^CJLocationComplement)(CJLocationInfo *locationInfo);
typedef void(^CJLocationFailed)(NSError *error);

@interface CJLocationManager : NSObject

@property(nonatomic, strong) CLLocationManager *locationManager;

/// 授权状态
@property (nonatomic, assign, readonly) CLAuthorizationStatus authorizationStatus;

/// 是否允许后台定位
@property(nonatomic, assign) BOOL allowsBackgroundLocationUpdates API_AVAILABLE(ios(9.0));

/// 定位精度，默认kCLLocationAccuracyBest
@property (nonatomic, assign) CLLocationAccuracy desiredAccuracy;

/// 移动多少位置，重新定位，默认kCLDistanceFilterNone
@property (nonatomic, assign) CLLocationDistance distanceFilter;


/**
 初始化

 @return self
 */
+(instancetype)shareLocationManager;


/**
 开始定位，默认定位一次

 @param complement 成功
 @param failed 失败
 */
-(void)startUpdateLocationComplement:(CJLocationComplement)complement
                              failed:(CJLocationFailed)failed;


/**
 开始定位

 @param shouldRepeat 是否重复获取
 @param complement 成功
 @param failed 失败
 */
-(void)startUpdateLocationRepeatCount:(BOOL)shouldRepeat
                           Complement:(CJLocationComplement)complement
                               failed:(CJLocationFailed)failed;


/**
 停止定位
 */
-(void)stopUpdateLocation;
@end





