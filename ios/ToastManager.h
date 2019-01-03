//
//  ToastManager.h
//  RNToast
//
//  Created by zhaoxx on 2019/1/2.
//  Copyright © 2019年 Facebook. All rights reserved.
//

#ifndef ToastManager_h
#define ToastManager_h
#import <UIKit/UIKit.h>

@interface ToastManager : NSObject
@property UIView* view;
+(instancetype) shareInstance;
-(void)showToast:(NSDictionary*)dict;
-(void)hideToast;
- (UIColor *)colorWithHextColorString:(NSString *)hexColorString alpha:(CGFloat)alphaValue;
@end

#endif /* ToastManager_h */
