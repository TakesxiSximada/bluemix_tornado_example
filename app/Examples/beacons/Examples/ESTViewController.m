//
//  ESTViewController.m
//  Examples
//
//  Created by Grzegorz Krukiewicz-Gacek on 17.03.2014.
//  Copyright (c) 2014 Estimote. All rights reserved.
//

#import "ESTViewController.h"
#import "ESTBeaconTableVC.h"
#import "ESTCloudBeaconTableVC.h"
#import "ESTDistanceDemoVC.h"
#import "ESTProximityDemoVC.h"
#import "ESTNotificationDemoVC.h"
#import "ESTUpdateFirmwareDemoVC.h"
#import "ESTBeaconDetailsDemoVC.h"
#import "ESTTemperatureDemoVC.h"
#import "ESTMotionDetectionDemoVC.h"
#import "ESTMotionUUIDDemoVC.h"
#import "ESTBulkUpdaterDemoVC.h"
#import "ESTBulkUpdaterRemoteDemoVC.h"
#import "ESTSendGPSDemoVC.h"
#import "ESTVirtualBeaconDemoVC.h"

@interface ESTDemoTableViewCell : UITableViewCell

@end

@implementation ESTDemoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
    }
    
    return self;
}

@end

@implementation ESTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    // UIImageViewの初期化
    CGRect rect = CGRectMake(40, 120, 250, 250);
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:rect];
    
    // 画像の読み込み
    imageView.image = [UIImage imageNamed:@"icon_app.png"];
    
    // UIImageViewのインスタンスをビューに追加
    [self.view addSubview:imageView];
    
    self.title = @"BINJO🍴";

    self.tableView.sectionHeaderHeight = 250;
    [self.tableView registerClass:[ESTDemoTableViewCell class] forCellReuseIdentifier:@"DemoCellIdentifier"];
    
    self.beaconDemoList = @[@[@"イタリアンバル BATORAN"]];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.beaconDemoList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.beaconDemoList objectAtIndex:section] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section == 0)
        return @"BINJO🍴";
    
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ESTDemoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DemoCellIdentifier" forIndexPath:indexPath];
    cell.textLabel.text = [[self.beaconDemoList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *demoViewController;
    
    if (indexPath.section == 0)
    {
        switch (indexPath.row)
        {
            case 0:
            {
                demoViewController = [[ESTBeaconTableVC alloc] initWithScanType:ESTScanTypeBeacon
                                                                     completion:^(CLBeacon *beacon) {
                                                                         
                                                                         ESTDistanceDemoVC *distanceDemoVC = [[ESTDistanceDemoVC alloc] initWithBeacon:beacon];
                                                                         [self.navigationController pushViewController:distanceDemoVC animated:YES];
                                                                     }];
                
                break;
            }
            default:
                break;
        }
    }
    else if (indexPath.section == 1)
    {
        switch (indexPath.row)
        {
            case 0:
            {
                demoViewController = [[ESTBeaconTableVC alloc] initWithScanType:ESTScanTypeBeacon
                                                                     completion:^(CLBeacon *beacon) {
                                                                         
                                                                         ESTTemperatureDemoVC *distanceDemoVC = [[ESTTemperatureDemoVC alloc] initWithBeacon:beacon];
                                                                         [self.navigationController pushViewController:distanceDemoVC animated:YES];
                                                                     }];
                
                break;
            }
            case 1:
            {
                demoViewController = [[ESTBeaconTableVC alloc] initWithScanType:ESTScanTypeBeacon
                                                                     completion:^(CLBeacon *beacon) {
                                                                         
                                                                         ESTMotionDetectionDemoVC *proximityDemoVC = [[ESTMotionDetectionDemoVC alloc] initWithBeacon:beacon];
                                                                         [self.navigationController pushViewController:proximityDemoVC animated:YES];
                                                                     }];
                
                break;
            }
            case 2:
            {
                demoViewController = [[ESTBeaconTableVC alloc] initWithScanType:ESTScanTypeBeacon
                                                                     completion:^(CLBeacon *beacon) {
                                                                         
                                                                         ESTMotionUUIDDemoVC *proximityDemoVC = [[ESTMotionUUIDDemoVC alloc] initWithBeacon:beacon];
                                                                         [self.navigationController pushViewController:proximityDemoVC animated:YES];
                                                                     }];
                
                break;
            }
            default:
                break;
        }
    }
    else if (indexPath.section == 2)
    {
        switch (indexPath.row)
        {
            case 0:
            {
                demoViewController = [[ESTBeaconTableVC alloc] initWithScanType:ESTScanTypeBluetooth
                                                                     completion:^(ESTBluetoothBeacon *beacon) {
                                                                         
                                                                         ESTBeaconDetailsDemoVC *beaconDetailsVC = [[ESTBeaconDetailsDemoVC alloc] initWithMacAddress:beacon.macAddress];
                                                                         [self.navigationController pushViewController:beaconDetailsVC animated:YES];
                                                                     }];
                break;
            }
            case 1:
            {
                demoViewController = [[ESTBeaconTableVC alloc] initWithScanType:ESTScanTypeBluetooth
                                                                     completion:^(ESTBluetoothBeacon *beacon) {
                                                                         
                                                                         ESTUpdateFirmwareDemoVC *updateFirmwareVC = [[ESTUpdateFirmwareDemoVC alloc] initWithMacAddress:beacon.macAddress];
                                                                         [self.navigationController pushViewController:updateFirmwareVC animated:YES];
                                                                     }];
                break;
            }
            case 2:
            {
                demoViewController = [[ESTBeaconTableVC alloc] initWithScanType:ESTScanTypeBluetooth
                                                                     completion:^(ESTBluetoothBeacon *beacon) {
                                                                         
                                                                         ESTBulkUpdaterDemoVC *bulkDemoVC = [[ESTBulkUpdaterDemoVC alloc] initWithBeacon:beacon];
                                                                         [self.navigationController pushViewController:bulkDemoVC animated:YES];
                                                                     }];
                break;
            }
            case 3:
            {
                demoViewController = [[ESTBulkUpdaterRemoteDemoVC alloc] init];
                                                                    
                break;
            }

            default:
                break;
        }
    }
    else if (indexPath.section == 3)
    {
        switch (indexPath.row)
        {
            case 0:
            {
                demoViewController = [ESTCloudBeaconTableVC new];
                
                break;
            }
            case 1:
            {
                demoViewController = [[ESTBeaconTableVC alloc] initWithScanType:ESTScanTypeBeacon
                                                                     completion:^(CLBeacon *beacon) {
                                                                         
                                                                         ESTSendGPSDemoVC *demoVC = [[ESTSendGPSDemoVC alloc] initWithBeacon:beacon];
                                                                         [self.navigationController pushViewController:demoVC animated:YES];
                                                                     }];
                
                break;
            }
                
            default:
                break;
        }
    }

    if (demoViewController)
    {
        [self.navigationController pushViewController:demoViewController animated:YES];
    }
}

@end
