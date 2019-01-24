//
//  QhgBaseVC.h
//  qhg_ios
//
//  Created by Brain on 2018/4/8.
//  Copyright © 2018年 In-next. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,PageGobackType)
{
    PageGobackTypeNone,
    PageGobackTypeDismiss,
    PageGobackTypePop,
    PageGobackTypeRoot,
    PageGobackTypeFirst
    
};

@interface JJBaseVC : UIViewController

@property (nonatomic, strong) id vcData;//用于控制器之间传递数据
@property (assign, nonatomic) BOOL isRequestProcessing;//请求是否在处理中
@property (nonatomic, assign, getter=isUserInterActive) BOOL userInterActive;

//版本更新接口
//-(void)requestAppVersionStatus;

/**
 *  页面基本设置
 *
 *  @param gobackType 页面返回类型
 */
- (void)baseSetup:(PageGobackType)gobackType;
//添加页面返回设置
- (void)baseSetup:(PageGobackType)gobackType withTitle:(NSString *)strTitle;

- (instancetype)initWithVCData:(id)data;

/**
 检测当前VC是否处于课件状态
 
 @return YES：可见  NO：不可见
 */
- (BOOL)isActivity;
/**
 *  根据指定的不同的title生成不同的LeftBarButton。
 *  @note  当title为back时，生成倒背景图为倒三角的button；<br>
 *         当title为close时，生成背景图为X的button；<br>
 *         当title为其他字符时，生成与title相同的Title的button。
 *
 *  @param title 特定的title
 */
- (void)setupLeftBarButtonWithTitle:(NSString *)title;

/**
 *  设置title,自定义右侧item
 */
- (void)setNavBarTitle:(NSString *)title RightCustomView:(UIView *)customView;

/**
 *  设置title,定义文本/图片右侧item
 *  @param title controller标题
 *  @param image rightItem 展示图片(当不需要是传nil)
 *  @param text rightItem 展示文本(当不需要时传nil)
 *  @param action rightItem 点击事件
 */
- (void)setNavBarTitle:(NSString *)title
        RightImageItem:(UIImage *)image
         rightTextItem:(NSString *)text
       didSelectAction:(SEL)action;

- (void)dismissVC;
- (void)showLoading:(NSString *)msg;
- (void)showMessage:(NSString *)msg;
- (void)showMessage:(NSString *)msg yOffset:(CGFloat)yOffset  afterDelay:(NSTimeInterval)delayTime;
- (void)showWindowMessage:(NSString *)msg;


- (void)hideLoading;
-(void)popVC;
-(void)popRootVC;
-(void)dismiss;

- (void)popToFirstVC;

//提示有对号的
- (void)showAlertMessage:(NSString *)strMessage;

/**
 *返回任意一个页面
 */
- (void)popToViewControllerAtIndex:(NSInteger)index;
//界面跳转
- (void)dsPushViewController:(UIViewController*)vc animated:(BOOL)animated;

//判断是否有网络
//- (BOOL)checkIsHaveNet;

//添加提示 是否有网络 是否有数据 可添加在tableView 上 可以滑动
//- (void)showTipViewWithData:(NSMutableArray *)arr superView:(UIView *)vSuper;
//
////添加提示 是否有网络 是否有数据 添加的是self.view 不可以滑动
//- (void)showTipViewWithData:(NSMutableArray *)arr withFrame:(CGRect)frameRect;

//显示底部导航栏
- (void )showNaviBottomLine;

//是否显示touchid
- (void)showTouchVC;

//打开用户交互
- (void)openUserInterActive;

//关闭用户交互
- (void)closeUserInterActive;

/**
 调试利器

 @return 调试利器
 */
#ifdef DEBUG
- (void)injected;
#endif
/**
 *  定制弹窗alertVC
 *  @param title   标题
 *  @param message 信息
 *  @param knowTitle 取消标题(如果需要取消按钮 该值不能为空；不需要取消按钮该值设为@"")
 *  @param completion 点击事件
 *  用法士例
 
 */

- (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message knowTitle:(NSString *)knowTitle
                completion:(void(^) (BOOL cancelled))completion;

- (void)showDelayOrderAlertWithTitle:(NSString *)title
                             message:(NSString *)message knowTitle:(NSString *)knowTitle
                          completion:(void(^) (BOOL cancelled))completion;
/**
 *  定制弹窗alertVC
 *  @param title   标题
 *  @param message 信息
 *  @param  cancel 取消标题
 *  @param  strOk  确定按钮
 *  @param completion 点击事件
 */

- (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message cancelTitle:(NSString *)cancel okTitle:(NSString *)strOk
                completion:(void(^) (BOOL cancelled))completion;


- (void)showDelayOrderAlertWithTitle:(NSString *)title
                             message:(NSString *)message cancelTitle:(NSString *)cancel okTitle:(NSString *)strOk
                          completion:(void(^) (BOOL cancelled))completion;

@end
