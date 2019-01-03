//
//  ToastManager.m
//  RNToast
//
//  Created by zhaoxx on 2019/1/2.
//  Copyright © 2019年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ToastManager.h"
#import "UILabel+EdgeInsetsLabel.h"

@implementation ToastManager

/**
 toast单例，只有一个toast显示
 */
static ToastManager* _instance = nil;

+(instancetype) shareInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init] ;
    }) ;
    
    return _instance ;
}

- (id)init
{
    if ((self = [super init]))
    {
        self.view = NULL;
    }
    return self;
}

/**
 text 文本信息
 font 字体大小
 backgroundColor 背景色
 textColor 文字颜色
 borderColor 边框颜色
 borderWidth 边框粗细
 cornerRadius 边框圆角
 edgeInsets 内边距 top上 left左 bottom下 right右
 interval 动画时长
 transformY y轴变换距离
 endAlpha 结束时的透明度
 */
-(void)showToast:(NSDictionary*)dict
{
    [self hideToast];
    
    UIView* uiWindow = [[UIApplication sharedApplication] keyWindow];
    if(uiWindow == NULL){
        return;
    }
    
    NSString* text = [dict objectForKey:@"text"]?[dict objectForKey:@"text"]:@"";
    UIFont* font = [dict objectForKey:@"font"]?[UIFont systemFontOfSize:[[dict objectForKey:@"font"] doubleValue]]:[UIFont systemFontOfSize:20];
    UIColor* backgroundColor = [dict objectForKey:@"backgroundColor"]?[self colorWithHextColorString:[dict objectForKey:@"backgroundColor"] alpha:1.0f]:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
    UIColor* textColor = [dict objectForKey:@"textColor"]?[self colorWithHextColorString:[dict objectForKey:@"textColor"] alpha:1.0f]:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    CGColorRef borderColor = [[self colorWithHextColorString:[dict objectForKey:@"borderColor"] alpha:1.0f] CGColor];
    CGFloat borderWidth = [[dict objectForKey:@"borderWidth"] doubleValue];
    CGFloat cornerRadius = [[dict objectForKey:@"cornerRadius"] doubleValue];
    NSDictionary* dictEdg = [dict objectForKey:@"edgeInsets"];
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake([[dictEdg objectForKey:@"top"] doubleValue],
                                               [[dictEdg objectForKey:@"left"] doubleValue],
                                               [[dictEdg objectForKey:@"bottom"] doubleValue],
                                               [[dictEdg objectForKey:@"right"] doubleValue]);
    NSTimeInterval interval = [dict objectForKey:@"interval"]?[[dict objectForKey:@"interval"] doubleValue]:2;
    float transformY = [[dict objectForKey:@"transformY"] doubleValue];
    float endAlpha = [[dict objectForKey:@"endAlpha"] doubleValue];
    
    EdgeInsetsLabel* label = [[EdgeInsetsLabel alloc] initWithFrame:CGRectMake(0, 0, uiWindow.bounds.size.width, uiWindow.bounds.size.height)];
    label.text = text;
    label.font = font;
    label.backgroundColor = backgroundColor;
    label.textColor = textColor;
    label.layer.masksToBounds = YES;
    label.layer.borderColor = borderColor;
    label.layer.borderWidth = borderWidth;
    label.layer.cornerRadius = cornerRadius;
    label.edgeInsets = edgeInsets;
    [label setNumberOfLines:0];
    [label sizeToFit];
    [label setTextAlignment:NSTextAlignmentCenter];
    
    [uiWindow addSubview:label];
    label.center = CGPointMake(uiWindow.bounds.size.width/2,uiWindow.bounds.size.height/2);
    
    self.view = label;
    
    [UIView animateWithDuration:interval animations:^{
        label.alpha = endAlpha;
        label.frame = CGRectMake(label.frame.origin.x, label.frame.origin.y-transformY, label.frame.size.width, label.frame.size.height);
    } completion:^(BOOL finished){
        if(finished && self.view != NULL){
            [self.view removeFromSuperview];
            self.view = NULL;
        }
    }];
}

-(void)hideToast{
    if(self.view != NULL){
        [self.view removeFromSuperview];
        self.view = NULL;
    }
}

//支持rgb,argb
- (UIColor *)colorWithHextColorString:(NSString *)hexColorString alpha:(CGFloat)alphaValue {
    UIColor *result = nil;
    unsigned int colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    //排除掉  @\"
    if ([hexColorString hasPrefix:@"@\""]) {
        hexColorString = [hexColorString substringWithRange:NSMakeRange(2, hexColorString.length-3)];
    }
    
    //排除掉 #
    if ([hexColorString hasPrefix:@"#"]) {
        hexColorString = [hexColorString substringFromIndex:1];
    }
    
    if (nil != hexColorString)
    {
        NSScanner *scanner = [NSScanner scannerWithString:hexColorString];
        (void) [scanner scanHexInt:&colorCode]; // ignore error
    }
    redByte = (unsigned char) (colorCode >> 16);
    greenByte = (unsigned char) (colorCode >> 8);
    blueByte = (unsigned char) (colorCode); // masks off high bits
    
    if ([hexColorString length]==8) {   //如果是8位，就那其中的alpha
        alphaValue = (float)(unsigned char)(colorCode>>24)/0xff;
    }
    
    NSLog(@"alpha:%f----r:%f----g:%f----b:%f",alphaValue,(float)redByte/0xff,(float)greenByte/0xff,(float)blueByte/0xff);
    result = [UIColor
              colorWithRed: (float)redByte / 0xff
              green: (float)greenByte/ 0xff
              blue: (float)blueByte / 0xff
              alpha:alphaValue];
    return result;
    
}
@end

