//
//  CJLocationManager.m
//  CommonProject
//
//  Created by zhuChaojun的Mac on 2016/2/9.
//  Copyright © 2016年 zhucj. All rights reserved.
//

#import "CJLocationManager.h"
#import "CJLocationInfo.h"

#ifdef DEBUG
#define CJLog(...) NSLog(@"%s\n %@\n\n", __func__, [NSString stringWithFormat:__VA_ARGS__])
#else
#define CJLog(...)
#endif
@interface CJLocationManager ()<CLLocationManagerDelegate>

@property(nonatomic, assign, readwrite) CLAuthorizationStatus authorizationStatus;

@property(nonatomic, copy)CJLocationComplement locationComplement;
@property(nonatomic, copy)CJLocationFailed locationFailed;

@property(nonatomic, strong) CLGeocoder *geocoder;
@end

static CJLocationManager *_manager = nil;
@implementation CJLocationManager

+(instancetype)shareLocationManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[CJLocationManager alloc] init];
    });
    return _manager;
}

-(instancetype)init {
    self = [super init];
    if (!self) { return nil;}
    _locationManager = [CLLocationManager new];
    _locationManager.delegate = self;
    
    self.desiredAccuracy = kCLLocationAccuracyBest;
    self.distanceFilter  = kCLDistanceFilterNone;
    
    return self;
}

-(void)startUpdateLocationComplement:(CJLocationComplement)complement failed:(CJLocationFailed)failed {
    [self startUpdateLocationRepeatCount:NO Complement:complement failed:failed];
}

-(void)startUpdateLocationRepeatCount:(BOOL)shouldRepeat Complement:(CJLocationComplement)complement failed:(CJLocationFailed)failed {

    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.distanceFilter  = kCLDistanceFilterNone;

    if (shouldRepeat) {
        [_locationManager startUpdatingLocation];
    }else {
        [_locationManager requestLocation];
    }
    
    _locationComplement = [complement copy];
    _locationFailed     = [failed copy];
}

-(void)stopUpdateLocation {
    if (!_locationManager) { return; }
    
    [_locationManager stopUpdatingLocation];
}



#pragma mark ---- CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    _authorizationStatus = status;

    switch (status) {
        case kCLAuthorizationStatusDenied:
        case kCLAuthorizationStatusRestricted:
            CJLog(@"设置->隐私->定位服务，打开相应app的定位功能");
            break;
        case kCLAuthorizationStatusNotDetermined:
        {
            BOOL hasAlwaysKey    = ([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"] != nil)
            || ([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationAlwaysAndWhenInUseUsageDescription"] != nil)
            ;
            if (hasAlwaysKey) {
                [_locationManager requestAlwaysAuthorization];
            }else {
                [_locationManager requestWhenInUseAuthorization];
            }
     
        }
            break;
        default:
            break;
    }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *location = locations.lastObject;
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error) {
            CJLog(@"%@",error);
            return;
        }
        CLPlacemark *mark = placemarks.firstObject;
        
        CJLocationInfo *locationInfo = [[CJLocationInfo alloc] init];
        locationInfo.country    = mark.country;
        locationInfo.province   = mark.administrativeArea;
        locationInfo.city       = mark.locality;
        locationInfo.district   = mark.subLocality;
        locationInfo.street     = mark.thoroughfare;
        locationInfo.subSteet   = mark.subThoroughfare;
        locationInfo.postalCode = mark.postalCode;
        locationInfo.longitude  = location.coordinate.longitude;
        locationInfo.latitude   = location.coordinate.latitude;
        locationInfo.specificLocation = mark.name;
        locationInfo.locationInfo     = [NSString stringWithFormat:@"%@%@%@%@%@%@%@",mark.country,mark.administrativeArea,mark.locality,mark.subLocality,mark.thoroughfare,mark.subThoroughfare,mark.name];
        _locationComplement(locationInfo);
    }];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    _locationFailed(error);
}

#pragma mark --- setter && getter
-(void)setAllowsBackgroundLocationUpdates:(BOOL)allowsBackgroundLocationUpdates {
    if (@available(iOS 9.0, *)) {
        _allowsBackgroundLocationUpdates = allowsBackgroundLocationUpdates;
        _locationManager.allowsBackgroundLocationUpdates = allowsBackgroundLocationUpdates;
    }else {
        NSAssert(0, @"allowsBackgroundLocationUpdates only support above ios 9.0");
    }
}

-(void)setDistanceFilter:(CLLocationDistance)distanceFilter {
    _locationManager.distanceFilter = distanceFilter;
}

-(void)setDesiredAccuracy:(CLLocationAccuracy)desiredAccuracy {
    _locationManager.desiredAccuracy = desiredAccuracy;
}

#pragma mark --- lazy
-(CLGeocoder *)geocoder {
    if (!_geocoder) {
        _geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}
@end
