//
//  UIImageView+MasonryLayout.m
//  qhg_ios
//
//  Created by Brain on 2018/9/9.
//  Copyright © 2018 In-next. All rights reserved.
//

#import "UIImageView+MasonryLayout.h"

@implementation UIImageView (MasonryLayout)

+ (UIImageView*)MAGetImageViewWith:(NSString*)imageName superView:(UIView*)superView masonrySet:(void(^)(UIImageView*currentImageView,MASConstraintMaker*make))block
{
    UIImageView *imageView;
    if (!imageName || [imageName isEqualToString:@""]) {
        imageView =[[UIImageView alloc]init];
    }
    else{
        imageView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
    }
    imageView.translatesAutoresizingMaskIntoConstraints =NO;
    [superView addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (block) {
            block(imageView,make);
        }
    }];
    return imageView;
}

@end
