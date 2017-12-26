//
//  WKWebBlurImageLoder.m
//  ChuGui01
//
//  Created by wkxx on 2017/4/14.
//  Copyright © 2017年 李战雷. All rights reserved.
//

#import "WKWebBlurImageLoder.h"



static NSString *const kProgressCallbackKey = @"progress";
static NSString *const kCompletedCallbackKey = @"completed";

@interface WKWebBlurImageLoder ()

@property (strong, nonatomic) NSOperationQueue *downloadQueue;
@property (assign, nonatomic) Class operationClass;

@end


@implementation WKWebBlurImageLoder

+ (WKWebBlurImageLoder *)sharedDownloader {
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}

- (id)init {
    if ((self = [super init])) {
        _operationClass = [WKWebImageBlurOperation class];
        _downloadQueue = [NSOperationQueue new];
        _downloadQueue.maxConcurrentOperationCount = 6;
    }
    return self;
}

- (void)dealloc {
    [self.downloadQueue cancelAllOperations];
    SDDispatchQueueRelease(_barrierQueue);
}
- (void)setMaxConcurrentDownloads:(NSInteger)maxConcurrentDownloads {
    _downloadQueue.maxConcurrentOperationCount = maxConcurrentDownloads;
}

- (NSUInteger)currentDownloadCount {
    return _downloadQueue.operationCount;
}

- (NSInteger)maxConcurrentDownloads {
    return _downloadQueue.maxConcurrentOperationCount;
}

- (void)setOperationClass:(Class)operationClass {
    _operationClass = operationClass ?: [WKWebImageBlurOperation class];
}
- (id <SDWebImageOperation>)downloadImageWithURL:(NSURL *)url needDealWithImage:(UIImage *)image
                                         options:(SDWebImageDownloaderOptions)options
                                        progress:(SDWebImageDownloaderProgressBlock)progressBlock
                                       completed:(SDWebImageDownloaderCompletedBlock)completedBlock
{
    __block WKWebImageBlurOperation *operation;
    __weak WKWebBlurImageLoder * wself = self;
     operation = [[wself.operationClass alloc]initWithImage:image completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
         if (completedBlock) {
             completedBlock(image, data, error, finished);
         }
     } cancelled:^{
         
     }];
    [self.downloadQueue addOperation:operation];
    NSLog(@"当前图片处理线程个数 ===== --- === %lu", (unsigned long)self.downloadQueue.operationCount);
    return operation;
}

- (void)setSuspended:(BOOL)suspended {
    [self.downloadQueue setSuspended:suspended];
}

@end
