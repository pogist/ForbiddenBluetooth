//
//  BluetoothDeviceHelper.m
//  ForbiddenBluetooth
//
//  Created by Murilo da Paixão on 31/05/19.
//  Copyright © 2019 Murilo Paixão. All rights reserved.
//

#import "BluetoothDeviceHelper.h"

@implementation BluetoothDeviceHelper

+ (BluetoothDevice *)deviceFromNotification:(NSNotification *)notification
{
  return (BluetoothDevice *)notification.object;
}

@end
