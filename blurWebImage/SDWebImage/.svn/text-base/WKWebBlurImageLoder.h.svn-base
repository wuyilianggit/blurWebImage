//
//  WKWebBlurImageLoder.h
//  ChuGui01
//
//  Created by wkxx on 2017/4/14.
//  Copyright © 2017年 李战雷. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDWebImageCompat.h"
#import "WKWebImageBlurOperation.h"

@interface WKWebBlurImageLoder : NSObject
@property (assign, nonatomic) NSInteger maxConcurrentDownloads;

/**
 * Shows the current amount of downloads that still need to be downloaded
 */

@property (readonly, nonatomic) NSUInteger currentDownloadCount;

/**
 *  Singleton method, returns the shared instance
 *
 *  @return global shared instance of downloader class
 */
+ (WKWebBlurImageLoder *)sharedDownloader;

/**
 * Set username
 */
@property (strong, nonatomic) NSString *username;

/**
 * Set password
 */
@property (strong, nonatomic) NSString *password;

- (void)setOperationClass:(Class)operationClass;

/**
 * Creates a SDWebImageDownloader async downloader instance with a given URL
 *
 * The delegate will be informed when the image is finish downloaded or an error has happen.
 *
 * @see SDWebImageDownloaderDelegate
 *
 * @param url            The URL to the image to download
 * @param options        The options to be used for this download
 * @param progressBlock  A block called repeatedly while the image is downloading
 * @param completedBlock A block called once the download is completed.
 *                       If the download succeeded, the image parameter is set, in case of error,
 *                       error parameter is set with the error. The last parameter is always YES
 *                       if SDWebImageDownloaderProgressiveDownload isn't use. With the
 *                       SDWebImageDownloaderProgressiveDownload option, this block is called
 *                       repeatedly with the partial image object and the finished argument set to NO
 *                       before to be called a last time with the full image and finished argument
 *                       set to YES. In case of error, the finished argument is always YES.
 *
 * @return A cancellable SDWebImageOperation
 */
- (id <SDWebImageOperation>)downloadImageWithURL:(NSURL *)url needDealWithImage:(UIImage *)image
                                         options:(SDWebImageDownloaderOptions)options
                                        progress:(SDWebImageDownloaderProgressBlock)progressBlock
                                       completed:(SDWebImageDownloaderCompletedBlock)completedBlock;

/**
 * Sets the download queue suspension state
 */
- (void)setSuspended:(BOOL)suspended;
@end
