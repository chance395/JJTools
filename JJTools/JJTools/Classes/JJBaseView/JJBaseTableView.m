//
//  JJBaseTableView.m
//  qhg_ios
//
//  Created by Brain on 2018/9/10.
//  Copyright © 2018 In-next. All rights reserved.
//
#import "DZNEmptyDataSet.h"
#import "JJReachability.h"
#import "JJBaseTableView.h"
#import "NSString+JJTools.h"
#import "JJColorDefine.h"
#import "JJMacroDefine.h"
@interface JJBaseTableView () <DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@end

@implementation JJBaseTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.emptyDataSetSource = self;
        self.emptyDataSetDelegate = self;
        self.emptyImageName =@"";
        self.emptyDescription =@"";
        self.emptyTitle =@"";
    }
    return self;
    
}
- (void)setLoading:(BOOL)loading
{
    if (self.isLoading == loading) {
        return;
    }
    
    _loading = loading;
    
    [self reloadEmptyDataSet];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = [self.emptyTitle isEmptyStr] ? nil :self.emptyTitle;
    
    UIFont *font = nil;
    UIColor *textColor = nil;
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    
    font = [UIFont systemFontOfSize:20.0];
    textColor = Color_TableViewEmpty_TitleColor;
    
    
    if (!text) {
        return nil;
    }
    if (font) [attributes setObject:font forKey:NSFontAttributeName];
    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = [self.emptyDescription isEmptyStr]? nil :self.emptyDescription;
    UIFont *font = nil;
    UIColor *textColor = nil;
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    
    
    if (![self checkIsHaveNet] && [self.emptyDescription isEmptyStr] ) {
        
        text = @"请检查网络";
    }
    if ([self checkIsHaveNet] && [self.emptyDescription isEmptyStr] )
    {
        
        text = @"当前暂无订单";
    }
    
    if (self.isLoading) {
        text = @"";
    }
    
    font = [UIFont systemFontOfSize:16.0];
    textColor = Color_TableViewEmpty_SubTitleColor;
    
    if (!text) {
        return nil;
    }
    
    if (font) [attributes setObject:font forKey:NSFontAttributeName];
    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    if (paragraph) [attributes setObject:paragraph forKey:NSParagraphStyleAttributeName];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
    
    return attributedString;
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    if (self.isLoading) {
        return [UIImage imageNamed:@"" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
    }
    else {
        NSString *imageName =[self.emptyImageName isEmptyStr] ?  @"nodata" : self.emptyImageName;
        
        if (![self checkIsHaveNet] && [self.emptyImageName isEmptyStr]) {
            
            imageName = @"nonet";
        }
        if ([self checkIsHaveNet] && [self.emptyImageName isEmptyStr])
        {
            
            imageName = @"nodata";
        }
        
        UIImage *image = [UIImage imageNamed:imageName inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
        
        return image;
    }
}

#pragma mark - DZNEmptyDataSetDelegate Methods

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView
{
    return self.isLoading;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    self.loading = YES;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.loading = NO;
    });
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button
{
    self.loading = YES;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.loading = NO;
    });
}

- (UIImage *)buttonBackgroundImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    
    
    NSString *imageName = [self.emptyImageName isEmptyStr] ? @"nodata" : self.emptyImageName;
    
    if (![self checkIsHaveNet] && [self.emptyImageName isEmptyStr]) {
        
        imageName = @"nonet";
    }
    if([self checkIsHaveNet] && [self.emptyImageName isEmptyStr])
    {
        
        imageName = @"nodata";
    }
    
    
    if (state == UIControlStateNormal) imageName = [imageName stringByAppendingString:@"_normal"];
    if (state == UIControlStateHighlighted) imageName = [imageName stringByAppendingString:@"_highlight"];
    
    UIEdgeInsets capInsets = UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0);
    UIEdgeInsets rectInsets = UIEdgeInsetsZero;
    
    UIImage *image = [UIImage imageNamed:imageName inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
    
    return [[image resizableImageWithCapInsets:capInsets resizingMode:UIImageResizingModeStretch] imageWithAlignmentRectInsets:rectInsets];
}
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    
    if (self.verticalOffset) {
        
        return self.verticalOffset;
    }
    return - 80.0;
}

#pragma mark - 判断是否有网络
- (BOOL)checkIsHaveNet{
    
    
    BOOL isExistenceNetwork = YES;
    
    JJReachability   *reach = [JJReachability reachabilityWithHostName:@"www.apple.com"];
    
    NSParameterAssert([reach isKindOfClass:[JJReachability class]]);
    
    NetworkStatus stats = [reach currentReachabilityStatus];
    
    if (stats == NotReachable)
        //没有网络
        isExistenceNetwork = NO;
    else if (stats == ReachableViaWiFi)
        isExistenceNetwork = YES;
    else if (stats == ReachableViaWWAN)
        isExistenceNetwork = YES;
    else if (stats == ReachableViaWiFi)
        isExistenceNetwork = YES;
    
    if (!isExistenceNetwork) {
        
        return NO;
    }
    
    return isExistenceNetwork;
    
}


@end
