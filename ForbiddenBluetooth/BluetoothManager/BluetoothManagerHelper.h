//
//  BluetoothManagerHelper.h
//  ForbiddenBluetooth
//
//  Created by Murilo da Paixão on 31/05/19.
//  Copyright © 2019 Murilo Paixão. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BluetoothManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface BluetoothManagerHelper : NSObject

+ (BluetoothManager *)shared;

@end

NS_ASSUME_NONNULL_END
