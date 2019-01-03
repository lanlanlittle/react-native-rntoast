
#import "RNToast.h"
#import "ToastManager.h"

@implementation RNToast

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}
RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(show:(NSDictionary*)dict)
{
    [[ToastManager shareInstance] showToast:dict];
}

RCT_EXPORT_METHOD(hide)
{
    [[ToastManager shareInstance] hideToast];
}

@end
  
