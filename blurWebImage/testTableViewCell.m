//
//  testTableViewCell.m
//  blurWebImage
//
//  Created by wkxx on 2017/12/26.
//  Copyright © 2017年 WYL. All rights reserved.
//

#import "testTableViewCell.h"

@implementation testTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bigImageView.layer.masksToBounds = YES;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
