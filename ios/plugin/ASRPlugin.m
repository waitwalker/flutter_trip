//
//  ASRPlugin.m
//  Runner
//
//  Created by etiantian on 2019/7/3.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import "ASRManager.h"
#import "ASRPlugin.h"

@interface ASRPlugin()
@property (nonatomic, strong) ASRManager *asrManager;
@property (nonatomic, copy) FlutterResult result;

@end

@implementation ASRPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
    FlutterMethodChannel *channel = [FlutterMethodChannel methodChannelWithName:@"asr_plugin" binaryMessenger:[registrar messenger]];
    ASRPlugin *plugin = [ASRPlugin new];
    [registrar addMethodCallDelegate:plugin channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    if ([call.method isEqualToString:@"start"]) {
        self.result = result;
        [self.asrManager start];
    } else if ([call.method isEqualToString:@"stop"]) {
        [self.asrManager stop];
    } else if ([call.method isEqualToString:@"cancel"]) {
        [self.asrManager cancel];
    } else {
        result(FlutterMethodNotImplemented);
    }
}

- (ASRManager *)asrManager {
    if (_asrManager == nil) {
        _asrManager = [ASRManager initWith:^(NSString * _Nonnull message) {
            if (self.result) {
                self.result(message);
                self.result = nil;
            }
        } failure:^(NSString * _Nonnull message) {
            if (self.result) {
                self.result([FlutterError errorWithCode:@"ASR failure" message:message details:nil]);
                self.result = nil;
            }
        }];
    }
    return _asrManager;
}

@end
