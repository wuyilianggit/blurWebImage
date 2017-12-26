//
//  WKWebImageBlurOperation.h
//  ChuGui01
//
//  Created by wkxx on 2017/4/14.
//  Copyright © 2017年 WYL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WKWebImageBlurOperation : NSOperation<SDWebImageOperation>

- (id)initWithImage:(UIImage *)image
            completed:(SDWebImageDownloaderCompletedBlock)completedBlock
            cancelled:(SDWebImageNoParamsBlock)cancelBlock;

@end
