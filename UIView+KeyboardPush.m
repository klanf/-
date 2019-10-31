//
//  UIView+KeyboardPush.m
//  Face Recognition
//
//  Created by jaime on 2019/8/12.
//  Copyright © 2019 foxconn.ios. All rights reserved.
//

#import "UIView+KeyboardPush.h"
#import <objc/runtime.h>

@implementation UIView (KeyboardPush)

- (void)registerKeyboardPushNotification {
    
    //注册观察键盘的变化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(transformView:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)resignKeyboardPushNotification {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}

//移动UIView
- (void)transformView:(NSNotification *)aNSNotification {
    
    [self traverseAllSubviews:self];
    UITextField *textField =  objc_getAssociatedObject(self, @"TextField");
    CGRect frame = [textField convertRect:textField.frame toView:self];

    //获取键盘弹出后的Rect
    NSValue *keyBoardEndBounds = [[aNSNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect endRect = [keyBoardEndBounds CGRectValue];
    
    //获取键盘位置变化前后纵坐标Y的变化值
    CGFloat deltaY = CGRectGetMaxY(frame) - endRect.origin.y;
   
    if (deltaY > 0) {
        //添加个动画
        [UIView animateWithDuration:0.25 animations:^{
            self.transform = CGAffineTransformMakeTranslation(0, -deltaY);
        }];
    } else {
        [UIView animateWithDuration:0.25 animations:^{
            self.transform = CGAffineTransformIdentity;
        }];
    }
}

/** 遍历所有子视图 **/
- (void)traverseAllSubviews:(UIView *)view {
    
    for (UIView *subView in view.subviews) {
        if (subView.subviews.count) {
            [self traverseAllSubviews:subView];
        }
        if ([subView isKindOfClass:[UITextField class]]) {
            
            UITextField *tf = (UITextField *)subView;

            if (tf.isFirstResponder) {
                
                objc_setAssociatedObject(self, @"TextField", tf, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
        }
    }
}

@end
