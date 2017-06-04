//
//  ViewController.m
//  IBeaconDemo
//
//  Created by LPPZ-User01 on 2017/5/10.
//  Copyright © 2017年 LPPZ-User01. All rights reserved.
//

#import "ViewController.h"

static NSString * const kUUID = @"23A01AF0-232A-4518-9C0E-323FB773F5EF";
static NSString * const kIdentifier = @"SomeIdentifier";
static NSString * const kCellIdentifier = @"BeaconCell";

@interface ViewController ()

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLBeaconRegion *beaconRegion;
@property (nonatomic, strong) CBPeripheralManager *peripheralManager;
@property (nonatomic, strong) NSArray *detectedBeacons;
@property (nonatomic, strong) UITableView *beaconTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self startRangingForBeacons];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Beacon ranging
- (void)createBeaconRegion
{
    if (self.beaconRegion)
        return;

    NSUUID *proximityUUID = [[NSUUID alloc] initWithUUIDString:kUUID];
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:proximityUUID identifier:kIdentifier];
}


- (void)startRangingForBeacons {
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.activityType = CLActivityTypeFitness;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;

    [self turnOnRanging];

}

- (void)turnOnRanging {
    NSLog(@"Turning on ranging...");

    if (![CLLocationManager isRangingAvailable]) {
        NSLog(@"Couldn't turn on ranging: Ranging is not available.");
        return;
    }

    if (self.locationManager.rangedRegions.count > 0) {
        NSLog(@"Didn't turn on ranging: Ranging already on.");
        return;
    }
    [self createBeaconRegion];
    [self.locationManager startRangingBeaconsInRegion:self.beaconRegion];
    NSLog(@"Ranging turned on for region: %@.", self.beaconRegion);
}

#pragma mark - Beacon ranging delegate methods
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"Couldn't turn on ranging: Location services are not enabled.");
        return;
    }

    if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedAlways) {
        NSLog(@"Couldn't turn on ranging: Location services not authorised.");
        return;
    }
}

- (void)locationManager:(CLLocationManager *)manager
        didRangeBeacons:(NSArray *)beacons
               inRegion:(CLBeaconRegion *)region {
    if ([beacons count] == 0) {
        NSLog(@"No beacons found nearby.");
    } else {
        NSLog(@"Found beacons!");
    }

    self.detectedBeacons = beacons;
    [self.beaconTableView reloadData];
}

//进入指定区域
- (void)locationManager:(CLLocationManager *)manager
         didEnterRegion:(CLRegion *)region{
    UIAlertView *laert = [[UIAlertView alloc] initWithTitle:@"你大爷" message:@"我看见你了" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [laert show];
}

//离开指定的区域
- (void)locationManager:(CLLocationManager *)manager
          didExitRegion:(CLRegion *)region {
    UIAlertView *laert = [[UIAlertView alloc] initWithTitle:@"你大爷" message:@"离开" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [laert show];
}

//定位失败
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    UIAlertView *laert = [[UIAlertView alloc] initWithTitle:@"你大爷" message:@"离开" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [laert show];
}
//区域定位失败
- (void)locationManager:(CLLocationManager *)manager
monitoringDidFailForRegion:(CLRegion *)region
              withError:(NSError *)error {
    UIAlertView *laert = [[UIAlertView alloc] initWithTitle:@"你大爷" message:@"离开" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [laert show];
}
//开始控制指定的区域
- (void)locationManager:(CLLocationManager *)manager
didStartMonitoringForRegion:(CLRegion *)region {
    UIAlertView *laert = [[UIAlertView alloc] initWithTitle:@"你大爷" message:@"离开" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [laert show];
}
//已经停止位置的更更新
- (void)locationManagerDidPauseLocationUpdates:(CLLocationManager *)manager {
    UIAlertView *laert = [[UIAlertView alloc] initWithTitle:@"你大爷" message:@"离开" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [laert show];
}
//位置定位重新开始定位位置的更新
- (void)locationManagerDidResumeLocationUpdates:(CLLocationManager *)manager {
    UIAlertView *laert = [[UIAlertView alloc] initWithTitle:@"你大爷" message:@"离开" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [laert show];
}
//已经完成了推迟的更新
- (void)locationManager:(CLLocationManager *)manager
didFinishDeferredUpdatesWithError:(NSError *)error {
    UIAlertView *laert = [[UIAlertView alloc] initWithTitle:@"你大爷" message:@"离开" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [laert show];
}
//就是已经访问过的位置，就会调用这个表示已经访问过，这个在栅栏或者定位区域都是使用到的
- (void)locationManager:(CLLocationManager *)manager didVisit:(CLVisit *)visit {
    UIAlertView *laert = [[UIAlertView alloc] initWithTitle:@"你大爷" message:@"离开" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [laert show];
}

#pragma mark - Table view functionality
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CLBeacon *beacon = self.detectedBeacons[indexPath.row];

    UITableViewCell *defaultCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                                          reuseIdentifier:kCellIdentifier];

    defaultCell.textLabel.text = beacon.proximityUUID.UUIDString;

    NSString *proximityString;
    switch (beacon.proximity) {
        case CLProximityNear:
            proximityString = @"Near";
            break;
        case CLProximityImmediate:
            proximityString = @"Immediate";
            break;
        case CLProximityFar:
            proximityString = @"Far";
            break;
        case CLProximityUnknown:
        default:
            proximityString = @"Unknown";
            break;
    }
    defaultCell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@ • %@ • %f • %li",
                                        beacon.major.stringValue, beacon.minor.stringValue, proximityString, beacon.accuracy, (long)beacon.rssi];
    defaultCell.detailTextLabel.textColor = [UIColor grayColor];

    return defaultCell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.detectedBeacons.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Detected beacons";
}

- (UITableView *)beaconTableView {
    if (!_beaconTableView) {
        _beaconTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _beaconTableView.delegate = self;
        _beaconTableView.dataSource = self;
        [self.view addSubview:_beaconTableView];
    }
    return _beaconTableView;
}

@end
