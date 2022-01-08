#import "FlutterAliyunIdentityPlugin.h"
#import <AliyunIdentityManager/AliyunIdentityPublicApi.h>

@implementation FlutterAliyunIdentityPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    
    UIWindow* window = [[[UIApplication sharedApplication] delegate] window];
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"registerWithRegistrar"
                                                                   message:@""
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
        UITextField *login = alert.textFields.firstObject;
    }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * action) {}];
    [alert addAction:cancelAction];
    [alert addAction:defaultAction];
    
    FlutterMethodChannel* channel = [FlutterMethodChannel
                                     methodChannelWithName:@"flutter_aliyun_identity"
                                     binaryMessenger:[registrar messenger]];
    FlutterAliyunIdentityPlugin* instance = [[FlutterAliyunIdentityPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"getPlatformVersion" isEqualToString:call.method]) {
        result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
    } else if ([@"init" isEqualToString:call.method]) {
        [AliyunSdk init];
        result(@{@"code":@(0)});
    } else if ([@"getMetaInfos" isEqualToString:call.method]) {
        NSDictionary *info = [AliyunIdentityManager getMetaInfo];
        result(@{@"code":@(0),@"data":info});
    } else if ([@"verify" isEqualToString:call.method]) {
        NSString *certifyId = call.arguments[@"certifyId"];
        NSMutableDictionary *extParams =  [NSMutableDictionary dictionaryWithDictionary:call.arguments[@"extParams"]];
        UIWindow* window = [[[UIApplication sharedApplication] delegate] window];
        [extParams setValue:window.rootViewController forKey:@"currentCtr"];
        [[AliyunIdentityManager sharedInstance] verifyWith:certifyId extParams:extParams onCompletion:^(ZIMResponse *response) {
            result(@{@"code" : @(response.code), @"reason": response.reason, @"certifyId":certifyId });
        }];
    } else {
        result(FlutterMethodNotImplemented);
    }
}

@end
