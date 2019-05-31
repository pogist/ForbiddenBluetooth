//
//  BluetoothManagerHelper.m
//  ForbiddenBluetooth
//
//  Created by Murilo da Paixão on 31/05/19.
//  Copyright © 2019 Murilo Paixão. All rights reserved.
//

#import "BluetoothManagerHelper.h"

static BluetoothManager *_manager;

@implementation BluetoothManagerHelper

+ (BluetoothManager *)shared
{
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    NSBundle *bundle = [NSBundle bundleWithPath:@"/System/Library/PrivateFrameworks/BluetoothManager.framework"];
    if (![bundle load]) {
      NSLog(@"Failed to load bundle at %@", bundle.bundlePath);
    } else {
      _manager = [NSClassFromString(@"BluetoothManager") valueForKey:@"sharedInstance"];
    }
  });

  return _manager;
}

@end
