//
//  WKWebImageBlurOperation.m
//  ChuGui01
//
//  Created by wkxx on 2017/4/14.
//  Copyright © 2017年 李战雷. All rights reserved.
//

#import "WKWebImageBlurOperation.h"
#import "FXBlurView.h" 
#import "WKImageScaleTool.h"

#define KBlueImageMaxSize 300

@interface WKWebImageBlurOperation()

//下载图片的地址
@property(nonatomic,strong) UIImage * needBlurImage;

@property (copy, nonatomic) SDWebImageDownloaderCompletedBlock completedBlock;
@property (copy, nonatomic) SDWebImageNoParamsBlock cancelBlock;
//是否正在进行
@property (assign, nonatomic, getter = isExecuting) BOOL executing;

//是否完成
@property (assign, nonatomic, getter = isFinished) BOOL finished;

@property (strong, atomic) NSThread *thread;
// app退到后台时，主线程会被暂停。但想在后台完成一个长期任务，须调用UIApplication的beginBackgroundTaskWithExpirationHandler:实例方法,来向 iOS 借点时间
// UIBackgroundTaskIdentifier相当于一个借据，告诉iOS，程序将要借更多的时间来完成Long-Running Task任务
#if TARGET_OS_IPHONE && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
@property (assign, nonatomic) UIBackgroundTaskIdentifier backgroundTaskId;
#endif
@end

@implementation WKWebImageBlurOperation
@synthesize executing = _executing;
@synthesize finished = _finished;

//重写main方法  操作添加到队列的时候会调用该方法
- (void)start{
    //创建自动释放池：因如果是异步操作，无法访问主线程的自动释放池
    if (self.isCancelled) {
        self.finished = YES;
        [self reset];
        return;
    }
    self.executing = YES;
    self.thread = [NSThread currentThread];
    @autoreleasepool {
        if (self.isCancelled || !self.needBlurImage) {
            self.executing = NO;
            self.finished = YES;
            self.thread = nil;
            return;
        }
        //断言
        NSAssert(self.needBlurImage != nil, @"finishedBlock不能为空");
        //如果图片过大，强行重新绘制图片
        if (self.needBlurImage.size.width > KBlueImageMaxSize && self.needBlurImage.size.height > KBlueImageMaxSize) {
            if (self.needBlurImage.size.width > self.needBlurImage.size.height) {
                self.needBlurImage = [WKImageScaleTool imageWithImageSimple:self.needBlurImage scaledToSize:CGSizeMake(KBlueImageMaxSize , self.needBlurImage.size.height / self.needBlurImage.size.width * KBlueImageMaxSize)];
            }else{
                self.needBlurImage = [WKImageScaleTool imageWithImageSimple:self.needBlurImage scaledToSize:CGSizeMake(self.needBlurImage.size.width / self.needBlurImage.size.height * KBlueImageMaxSize ,  KBlueImageMaxSize)];
            }
        }
        UIImage * blueImage = [self.needBlurImage blurredImageWithRadius:10 iterations:3 tintColor:[UIColor blackColor]];
        self.executing = NO;
        self.finished = YES;
        if (blueImage) {
            if (self.completedBlock) {
                self.completedBlock(blueImage, nil, nil, YES);
            }
        }
        [self reset];
    }
}
- (id)initWithImage:(UIImage *)image
          completed:(SDWebImageDownloaderCompletedBlock)completedBlock
          cancelled:(SDWebImageNoParamsBlock)cancelBlock
{
    if (self = [super init]) {
        self.needBlurImage = image;
        _completedBlock = [completedBlock copy];
        _executing = NO;
        _finished = NO;
    }
    return self;
}
- (void)cancel {
    @synchronized (self) {
        if (self.thread) {
            [self performSelector:@selector(cancelInternalAndStop) onThread:self.thread withObject:nil waitUntilDone:NO];
        }
        else {
            [self cancelInternal];
        }
    }
}

- (void)cancelInternalAndStop {
    if (self.isFinished) return;
    [self cancelInternal];
    CFRunLoopStop(CFRunLoopGetCurrent());
}

- (void)cancelInternal {
    if (self.isFinished) return;
    [super cancel];
    if (self.cancelBlock) self.cancelBlock();
    
    if (self.isExecuting) self.executing = NO;
    if (!self.isFinished) self.finished = YES;
    [self reset];
}

- (void)reset {
    NSLog(@"销毁了当前的线程==== %@", self.thread);
    self.cancelBlock = nil;
    self.completedBlock = nil;
    self.thread = nil;
}

@end
