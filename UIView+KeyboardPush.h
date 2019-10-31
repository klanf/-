//
//  UIView+KeyboardPush.h
//  Face Recognition
//
//  Created by jaime on 2019/8/12.
//  Copyright © 2019 foxconn.ios. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (KeyboardPush)

- (void)registerKeyboardPushNotification;
- (void)resignKeyboardPushNotification;

@end

NS_ASSUME_NONNULL_END
