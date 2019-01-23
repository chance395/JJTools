//
//  UIImageView+MasonryLayout.h
//  qhg_ios
//
//  Created by Brain on 2018/9/9.
//  Copyright © 2018 In-next. All rights reserved.
//

#import <UIKit/UIKit.h>
#import"Masonry.h"

@interface UIImageView (MasonryLayout)

/**
 UIImageView

 @param imageName name
 @param superView superView
 @param block block
 @return UIImageView
 */
+ (UIImageView*)MAGetImageViewWith:(NSString*)imageName superView:(UIView*)superView masonrySet:(void(^)(UIImageView*currentImageView,MASConstraintMaker*make))block;

@end
