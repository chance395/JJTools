//
//  JJBaseTableView.m
//  qhg_ios
//
//  Created by Brain on 2018/9/10.
//  Copyright © 2018 In-next. All rights reserved.
//
#import "DZNEmptyDataSet.h"
#import "Masonry.h"
#import "JJMacroDefine.h"
#import "JJFontDefine.h"
#import "JJColorDefine.h"
#import "UIColor+JJTools.h"
#import "UILabel+MasonryLayout.h"
#import "UIButton+MasonryLayout.h"
#import "UIImageView+MasonryLayout.h"
#import "UIView+MasonryLayout.h"
#import "UITextField+MasonryLayout.h"
#import "UIImage+JJTools.h"
#import "JJReachability.h"
#import "JJBaseTableView.h"

@interface JJBaseTableView () <DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@end

@implementation JJBaseTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.emptyDataSetSource = self;
        self.emptyDataSetDelegate = self;
        self.emptyImageName =@"";
        self.emptySubtitle =@"";
        self.emptyTitle =@"";
        self.emptyButtonTitle =@"";
        self.emptyButtonColor =nil;
        self.emptyButtonImageStr =@"";
        self.emptyCustomView =nil;
    }
    return self;
    
}
/** for xib
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self =[super initWithCoder:aDecoder];
    if (self) {
        self.emptyDataSetSource = self;
        self.emptyDataSetDelegate = self;
        self.emptyImageName =@"";
        self.emptySubtitle =@"";
        self.emptyTitle =@"";
        self.emptyButtonTitle =@"";
        self.emptyButtonColor =nil;
        self.emptyButtonImageStr =@"";
        self.emptyCustomView =nil;
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
    NSString *text = self.emptyTitle.length == 0 ? nil :self.emptyTitle;
    
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
    NSString *text = self.emptySubtitle.length  == 0? nil :self.emptySubtitle;
    UIFont *font = nil;
    UIColor *textColor = nil;
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    if (![self checkIsHaveNet]) {
        
        text = @"请检查网络";
    }
    if ([self checkIsHaveNet] && self.emptySubtitle.length == 0 )
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
        NSString *imageName =self.emptyImageName.length == 0 ?  @"nodata" : self.emptyImageName;
        
        if (![self checkIsHaveNet] ) {
            
            imageName = @"nonet";
        }
        if ([self checkIsHaveNet] && self.emptyImageName.length == 0)
        {
            
            imageName = @"nodata";
        }
        
        UIImage *image = [UIImage imageNamed:imageName inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
        
        return image;
    }
}


/**
 title for btn
 
 @param scrollView scrollView
 @param state state
 @return atttitle
 */
- (nullable NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.emptyButtonTitle attributes:nil];
    
    return  self.emptyButtonTitle.length == 0? nil :attributedString ;
}


/**
 the image For btn
 
 @param scrollView scrollView
 @param state controllstate
 @return uiimage
 */
- (nullable UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state;
{
    
    return  self.emptyButtonImageStr.length == 0? nil :[UIImage imageNamed:self.emptyButtonImageStr] ;
    
}

- (UIImage *)buttonBackgroundImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    return nil;
}


/**
 in here must use autolay ,tableView.customView =customView and then layout...
 
 @param scrollView scroView or tablView
 @return customView
 */

- (nullable UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView;
{
    
    return self.emptyCustomView ? self.emptyCustomView :nil;
    
}


/**
 added based on the original
 
 @param scrollView scrollView
 @param state state
 @return color
 */
-(UIColor *)buttonBackgroundColorForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    return self.emptyButtonColor ? self.emptyButtonColor :nil;
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
    
    if (self.refreshDelegate && [self.refreshDelegate respondsToSelector:@selector(tabelViewRefreshBtnDidClicked:)])
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.refreshDelegate tabelViewRefreshBtnDidClicked:self];
        });
        
    }
    
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    
    if (self.verticalOffset) {
        
        return self.verticalOffset;
    }
    return - 80.0;
}

#pragma mark - 判断是否有网络
- (BOOL)checkIsHaveNet{
    
    BOOL isExistenceNetwork = NO;
    
    JJReachability   *reach = [JJReachability reachabilityWithHostName:@"www.apple.com"];
    
    NSParameterAssert([reach isKindOfClass:[JJReachability class]]);
    
    NetworkStatus stats = [reach currentReachabilityStatus];
    
    if (stats == ReachableViaWiFi || stats == ReachableViaWWAN)
    {
        //没有网络
        isExistenceNetwork = YES;
    }
    
    return isExistenceNetwork;
    
}


@end
