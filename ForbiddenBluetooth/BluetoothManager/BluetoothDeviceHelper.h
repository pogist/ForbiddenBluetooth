//
//  BluetoothDeviceHelper.h
//  ForbiddenBluetooth
//
//  Created by Murilo da Paixão on 31/05/19.
//  Copyright © 2019 Murilo Paixão. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BluetoothDevice.h"

@interface BluetoothDeviceHelper : NSObject

+ (BluetoothDevice *)deviceFromNotification:(NSNotification *)notification;

@end
