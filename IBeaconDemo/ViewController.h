//
//  ViewController.h
//  IBeaconDemo
//
//  Created by LPPZ-User01 on 2017/5/10.
//  Copyright © 2017年 LPPZ-User01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface ViewController : UIViewController<CLLocationManagerDelegate, CBPeripheralManagerDelegate, UITableViewDataSource, UITableViewDelegate>


@end

