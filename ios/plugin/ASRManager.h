//
//  ASRManager.h
//  Runner
//
//  Created by etiantian on 2019/7/2.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^AsrCallBack)(NSString *message);

@interface ASRManager : NSObject

+ (instancetype)initWith:(AsrCallBack)success failure:(AsrCallBack)failure;

/**
 开始录音
 */
- (void)start;


/**
 停止录音
 */
- (void)stop;

/**
 停止录音
 */
- (void)cancel;

@end

NS_ASSUME_NONNULL_END
