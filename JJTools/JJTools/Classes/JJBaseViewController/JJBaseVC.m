//
//  QhgBaseVC.m
//  qhg_ios
//
//  Created by Brain on 2018/4/8.
//  Copyright © 2018年 In-next. All rights reserved.

#import "JJBaseVC.h"
#import "JJMacroDefine.h"
#import "JJFontDefine.h"
#import "JJColorDefine.h"
//#import "UILabel+MasonryLayout.h"
//#import "UIButton+MasonryLayout.h"
//#import "UIImageView+MasonryLayout.h"
//#import "UIView+MasonryLayout.h"
//#import "UITextField+MasonryLayout.h"
//#import "UIImage+JJTools.h"
#import "JJConstants.h"
#import "MBProgressHUD.h"
@interface JJBaseVC ()

@property (nonatomic, strong) MBProgressHUD *progressHud;
@property (nonatomic, strong) void (^completion)(BOOL cancelled);

@end

@implementation JJBaseVC

#pragma mark - 初始化
//配置navibar

- (void)viewWillAppear:(BOOL)animated{
   
    //设置title颜色和大小
    self.navigationController.navigationBar.alpha = 1;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:Color_NavigationBar_TitleColor,NSFontAttributeName:Font_Navigationbar_Title};
    
    
    self.navigationController.navigationBar.barTintColor = Color_Navi_BgColor;
    
    self.navigationController.navigationBar.layer.shadowColor = [UIColor blackColor].CGColor;
    [NotificationCenter addObserver:self selector:@selector(showLogin) name:kNotificationNeedLogin object:nil];
    
    //隐藏黑线
    UIImageView *navBarHairlineImageView;
    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    navBarHairlineImageView.hidden = YES;
    
    //禁止侧滑
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
    [self openUserInterActive];
}


-(instancetype)init{
    if (self = [super init]) {
        self.view.backgroundColor = Color_WhiteColor;
    }
    return self;
}

-(instancetype)initWithVCData:(id)data{
    if (self = [super init]) {
        self.vcData = data;
        self.view.backgroundColor = Color_backgroudColor;
    }
    return self;
}

- (BOOL)isActivity{
    
    return [self isViewLoaded] && self.view.window;
    
}

- (void)setupLeftBarButtonWithTitle:(NSString *)title
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.backgroundColor = [UIColor clearColor];
    backButton.frame = CGRectMake(0, 0, 50, 30);
    
    if (title && [title isEqualToString:@"Back"]) {
        
        UIImage *image = [UIImage imageNamed:@"arrow-backPop"];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.userInteractionEnabled = NO;
        imageView.frame = CGRectMake(CGRectGetMinX(backButton.frame),
                                     (CGRectGetHeight(backButton.frame) - image.size.height) / 2.0f + CGRectGetMinY(backButton.frame),
                                     image.size.width, image.size.height);
        [backButton addSubview:imageView];
        [backButton addTarget:self action:@selector(goBackController:) forControlEvents:UIControlEventTouchUpInside];
        
    }else if (title && [title isEqualToString:@"BackDismiss"]){
        UIImage *image = [UIImage imageNamed:@"backPop"];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.userInteractionEnabled = NO;
        imageView.frame = CGRectMake(CGRectGetMinX(backButton.frame),
                                     (CGRectGetHeight(backButton.frame) - image.size.height) / 2.0f + CGRectGetMinY(backButton.frame),
                                     image.size.width, image.size.height);
        [backButton addSubview:imageView];
        [backButton addTarget:self action:@selector(dismissVC) forControlEvents:UIControlEventTouchUpInside];
        
    }
    else if (title && [title isEqualToString:@"close"]) {
        
        [backButton setTitle:@"取消" forState:UIControlStateNormal];
        [backButton setTitle:@"取消" forState:UIControlStateHighlighted];
        [backButton setTitle:@"取消" forState:UIControlStateSelected];
        
        backButton.titleLabel.font = FontSystem(16.f);//[UIFont systemFontOfSize:15.0f];
        [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [backButton addTarget:self action:@selector(dismissVC) forControlEvents:UIControlEventTouchUpInside];
        
        
    } else if (title && [title isEqualToString:@"noBack"]) {
        [backButton setTitle:@"" forState:UIControlStateNormal];
        [backButton setTitle:@"" forState:UIControlStateHighlighted];
        [backButton setTitle:@"" forState:UIControlStateSelected];
        
        backButton.titleLabel.font = FontSystem(15.f);//[UIFont systemFontOfSize:15.0f];
        //        [backButton setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
        
    } else {
        
        [backButton setTitle:title forState:UIControlStateNormal];
        [backButton setTitle:title forState:UIControlStateHighlighted];
        [backButton setTitle:title forState:UIControlStateSelected];
        
        backButton.titleLabel.font = FONT(17);//[UIFont systemFontOfSize:15.0f];
        [backButton setTitleColor:Color_LeftBar_BtnColor forState:UIControlStateNormal];
        [backButton setTitleColor:Color_LeftBar_BtnColor forState:UIControlStateHighlighted];
        [backButton setTitleColor:Color_LeftBar_BtnColor forState:UIControlStateSelected];
        [backButton addTarget:self action:@selector(goBackController:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if (floor(NSFoundationVersionNumber) >= NSFoundationVersionNumber_iOS_7_0) {
        [backButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10.f)];
    }
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)setNavBarTitle:(NSString *)title RightCustomView:(UIView *)customView
{
    [self.navigationController setNavigationBarHidden:NO];
    
    // 中间标题
    //    if (![NSString isNil:title]) {
    //        self.title = title;
    //    }
    
    // 右边样式
    UIBarButtonItem *btn_right = [[UIBarButtonItem alloc] initWithCustomView:customView];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -10;
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, btn_right, nil];
}

- (void)setNavBarTitle:(NSString *)title RightImageItem:(UIImage *)image rightTextItem:(NSString *)text didSelectAction:(SEL)action;
{
    [self.navigationController setNavigationBarHidden:NO];
    
    // 中间标题
        self.title = title;
    
    // 右边样式
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame =CGRectMake(0, 0, 44, 44);
    [rightButton setTitle:text forState:UIControlStateNormal];
    rightButton.titleLabel.font =[UIFont systemFontOfSize:15.0];
    [rightButton setTitleColor:Color_WhiteColor forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
    
    if (image) {
        [rightButton setImage:image forState:UIControlStateNormal];
        [rightButton setImage:image forState:UIControlStateHighlighted];
    }
    if (text) {
        [rightButton setTitle:text forState:UIControlStateNormal];
    }
    if (IOSVERSION >= 11.0) {
        rightButton.contentEdgeInsets =UIEdgeInsetsMake(0, 10,0, 0);
        rightButton.imageEdgeInsets =UIEdgeInsetsMake(0, 5,0, 0);
    }
    UIBarButtonItem *btn_right = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -10;
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, btn_right, nil];
}
#pragma --mark 页面基本设置
/**
 *  页面基本设置,页面背景颜色、页面是否包含返回按钮、对返回按钮做相应的处理
 *
 *  @param gobackType 页面返回类型
 */
- (void)baseSetup:(PageGobackType)gobackType{
    
    //设置页面背景
    self.view.backgroundColor = Color_backgroudColor;
    
    //设置返回按钮
    if (gobackType != PageGobackTypeNone) {
        UIButton *btnLeft = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 27, 32)];//132 156
        [btnLeft setTitle:@"" forState:UIControlStateNormal];
        
        
        
        //        [btnLeft setBackgroundImage:ImageNamed(@"navigationBar_popBack") forState:UIControlStateNormal];
        [btnLeft setImage:ImageNamed(@"backPop") forState:UIControlStateNormal];
        btnLeft.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        if (gobackType == PageGobackTypePop)
        {
            
            [btnLeft addTarget:self action:@selector(popVC) forControlEvents:UIControlEventTouchUpInside];
        }
        else if (gobackType == PageGobackTypeDismiss)
        {
            
            [btnLeft addTarget:self action:@selector(dismissVC) forControlEvents:UIControlEventTouchUpInside];
        }else if (gobackType == PageGobackTypeRoot)
        {
            
            [btnLeft addTarget:self action:@selector(popRootVC) forControlEvents:UIControlEventTouchUpInside];
            
        }else if (gobackType == PageGobackTypeFirst)
        {
            
            [btnLeft addTarget:self action:@selector(popToFirstVC) forControlEvents:UIControlEventTouchUpInside];
        }
        
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:btnLeft];
        
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.width = 0;
        [self.navigationItem setLeftBarButtonItems:@[negativeSpacer,leftItem]];
    }else
    {
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:[UIView new]];
        [self.navigationItem setLeftBarButtonItem:leftItem];
    }
}

- (void)baseSetup:(PageGobackType)gobackType withTitle:(NSString *)strTitle{
    
    //设置页面背景
    self.view.backgroundColor = Color_backgroudColor;
    
    //设置返回按钮
    if (gobackType != PageGobackTypeNone)
    {
        UIButton *btnLeft = [[UIButton alloc] initWithFrame:CGRectMake(-5, 0, 100, 44)];
        
        [btnLeft setImage:ImageNamed(@"backPop") forState:UIControlStateNormal];
        btnLeft.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        if (gobackType == PageGobackTypePop)
        {
            [btnLeft addTarget:self action:@selector(popVC) forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:btnLeft];
            
            UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                               initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                               target:nil action:nil];
            negativeSpacer.width = 3;
            [btnLeft setTitle:strTitle forState:UIControlStateNormal];
            
            NSMutableAttributedString  *str = [[NSMutableAttributedString    alloc]initWithString:strTitle attributes:@{NSForegroundColorAttributeName:Color_Title_CodeMark,NSFontAttributeName:FONT(13)}];
            [btnLeft setAttributedTitle:str forState:UIControlStateNormal];
            //            btnLeft.titleLabel.font = Font_Navigationbar_Title ;
            //            [btnLeft setTintColor:Color_Title_Black];
            //            btnLeft.titleLabel.textColor = Color_Title_Black;
            
            //            [self.navigationItem setLeftBarButtonItems:@[leftItem]];
            [self.navigationItem setLeftBarButtonItems:@[negativeSpacer,leftItem]];
            
            self.navigationItem.leftBarButtonItem = leftItem;
        }else if (gobackType == PageGobackTypeDismiss)
        {
            [btnLeft addTarget:self action:@selector(dismissVC) forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:btnLeft];
            
            UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                               initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                               target:nil action:nil];
            negativeSpacer.width = 0;
            [self.navigationItem setLeftBarButtonItems:@[negativeSpacer,leftItem]];
        }
        else if (gobackType == PageGobackTypeRoot)
        {
            [btnLeft addTarget:self action:@selector(popRootVC) forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:btnLeft];
            
            UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                               initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                               target:nil action:nil];
            negativeSpacer.width = 0;
            [self.navigationItem setLeftBarButtonItems:@[negativeSpacer,leftItem]];
        }
        else if (gobackType == PageGobackTypeFirst)
        {
            [btnLeft addTarget:self action:@selector(popToFirstVC) forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:btnLeft];
            
            UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                               initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                               target:nil action:nil];
            negativeSpacer.width = 0;
            [self.navigationItem setLeftBarButtonItems:@[negativeSpacer,leftItem]];
        }
        
        
    }
    else
    {
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:[UIView new]];
        [self.navigationItem setLeftBarButtonItem:leftItem];
    }
}

//通过一个方法来找到这个黑线(findHairlineImageViewUnder):
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}


- (void)showMessage:(NSString *)msg{
    if (!msg ) {
        return;
    }
    if (msg.length ==0) {
        return;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.animationType = MBProgressHUDAnimationZoomOut;
    hud.mode = MBProgressHUDModeText;
    //    hud.label.text = [TipMessage shared].tipMessage.tipTitle;
    hud.detailsLabel.text = msg;
    hud.detailsLabel.font = FONT(18);
    hud.margin = 27;
    hud.backgroundView.alpha = 0.5;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:2.0];
}



- (void)hideLoading{
    
    
    [self.progressHud hideAnimated:YES];
    
}

- (void)showLoading:(NSString *)msg{
    
    //    [SVProgressHUD setMinimumDismissTimeInterval:5.0f];
    //    [SVProgressHUD showLoading];
    
    //    if (!self.progressHud) {
    
    
    [self hideLoading];
    
    self.progressHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //    }
    
    
    //    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.progressHud.animationType = MBProgressHUDAnimationZoomOut;
    self.progressHud.mode = MBProgressHUDModeIndeterminate;
    //        hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    
    //    hud.label.text = [TipMessage shared].tipMessage.tipTitle;
    self.progressHud.detailsLabel.text = msg;
    self.progressHud.detailsLabel.font = FONT(18);
    self.progressHud.margin = 15;
    self.progressHud.backgroundView.alpha = 0.8;
    self.progressHud.removeFromSuperViewOnHide = YES;
    //    [hud hideAnimated:YES afterDelay:0.1];
    
    //    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    //
    //    hud.label.textColor = [UIColor whiteColor];
    //
    //    hud.label.text = msg;
    //    //    [self.progressHud show:YES];
    //
    //    [hud  hideAnimated:YES afterDelay:2.f];
    
}

//提示有对号的
- (void)showAlertMessage:(NSString *)strMessage{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    // Set the custom view mode to show any view.
    hud.mode = MBProgressHUDModeCustomView;
    // Set an image view with a checkmark.
    UIImage *image = [[UIImage imageNamed:@"checkmark"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    hud.customView = [[UIImageView alloc] initWithImage:image];
    // Looks a bit nicer if we make it square.
    hud.square = YES;
    // Optional label text.
    hud.label.text = strMessage;
    hud.label.font = FONT(13);
    hud.label.textAlignment = NSTextAlignmentCenter;
    hud.label.numberOfLines = 0;
    hud.label.textColor = Color_WhiteColor;
    hud.label.lineBreakMode = NSLineBreakByWordWrapping;
    
    hud.bezelView.backgroundColor = Color_Hud_BackGroundColor;
    [hud hideAnimated:YES afterDelay:2.f];
}



#pragma mark 弹窗跟新提示

- (void)showAlertWithDic:(NSDictionary *)dicData{//1 建议更新 2强制更新 0 不需要更新
    if ([[NSString stringWithFormat:@"%@",dicData[@"isUpdate"]] isEqualToString:@"0"]) {//不需要更新
        
    }else if ([[NSString stringWithFormat:@"%@",dicData[@"isUpdate"]] isEqualToString:@"1"]){//建议更新
//        @Weak(self);
        [self showAlertWithTitle:@"温馨提示" message:getStringValue(dicData[@"msg"]) knowTitle:@"取消" completion:^(BOOL cancelled) {
            if (cancelled) {
              
            }
            
        }];
        
    }else if([[NSString stringWithFormat:@"%@",dicData[@"isUpdate"]] isEqualToString:@"2"]){
//       @Weak(self);
        [self showAlertWithTitle:@"温馨提示" message:getStringValue(dicData[@"msg"]) knowTitle:@"" completion:^(BOOL cancelled) {
            if (cancelled) {

                
            }
            
        }];
    }
}



#pragma mark - 返回上一级

/**
 *  Pop当前VC到上一级VC
 *
 *  @param sender 被点击的Buttonß
 */
- (void)goBackController:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    [self openUserInterActive];
}
- (void)dismissVC
{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    
    
        UIViewController *vc = self.presentingViewController;
        
        if (!vc.presentingViewController)
        {
            [vc dismissViewControllerAnimated:YES completion:nil];
            return;
        }
    
        
        while (vc.presentingViewController)  {
            vc = vc.presentingViewController;
        }
        
        [vc dismissViewControllerAnimated:YES completion:nil];
    [self openUserInterActive];

}

- (void)showWindowMessage:(NSString *)msg{
    
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    hud.animationType = MBProgressHUDAnimationZoomOut;
    hud.mode = MBProgressHUDModeText;
    //    hud.labelText = [TipMessage shared].tipMessage.tipTitle;
    hud.detailsLabel.text = msg;
    hud.label.font = [UIFont systemFontOfSize:17];
    hud.detailsLabel.font = [UIFont systemFontOfSize:15];
    hud.margin = 10.f;
    hud.bezelView.alpha = 0.8;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:1.2f];
}

- (void)showMessage:(NSString *)msg yOffset:(CGFloat)yOffset  afterDelay:(NSTimeInterval)delayTime{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.animationType = MBProgressHUDAnimationZoomOut;
    hud.mode = MBProgressHUDModeText;
    hud.label.font = [UIFont systemFontOfSize:17];
    hud.detailsLabel.font = [UIFont systemFontOfSize:15];
    //    hud.yOffset = yOffset;
    [hud setOffset:CGPointMake(0, yOffset)];
    hud.detailsLabel.text = msg;
    hud.margin = 10.f;
    hud.bezelView.alpha = 0.8;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:delayTime];
    
}



-(void)popVC{
    
    [self.navigationController popViewControllerAnimated:YES];
    [self openUserInterActive];
}
-(void)popRootVC{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    [self openUserInterActive];
}
- (void)dismiss
{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self openUserInterActive];
}

- (void)popToFirstVC
{
    if (self.navigationController.viewControllers.count > 0)
    {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    }
    [self openUserInterActive];
}

/**
 *返回任意一个页面
 */
- (void)popToViewControllerAtIndex:(NSInteger)index
{
    if (self.navigationController.viewControllers.count > index)
    {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:index] animated:YES];
    }
    [self openUserInterActive];
}

- (void)dsPushViewController:(UIViewController*)vc animated:(BOOL)animated{
    if (self.navigationController.viewControllers.count == 1) {
        vc.hidesBottomBarWhenPushed = YES;
    }
    [self.navigationController pushViewController:vc animated:animated];
    [self openUserInterActive];
}
-(void)showLogin{
    
//    douyouhn_LoginFirstVC *vcLogin = [[douyouhn_LoginFirstVC alloc] init];
//    douyouhn_NaviController *vcNavigation = [[douyouhn_NaviController alloc] initWithRootViewController:vcLogin];
//    [self presentViewController:vcNavigation animated:YES completion:nil];
    [self openUserInterActive];
}

#pragma mark - 判断是否有网络
//- (BOOL)checkIsHaveNet{

    
//    BOOL isExistenceNetwork = YES;
//
//    JJReachability   *reach = [JJReachability reachabilityWithHostName:@"www.apple.com"];
//
//    NSParameterAssert([reach isKindOfClass:[JJReachability class]]);
//
//    NetworkStatus stats = [reach currentReachabilityStatus];
//
//    if (stats == NotReachable)
//        //没有网络
//        isExistenceNetwork = NO;
//    else if (stats == ReachableViaWiFi)
//        isExistenceNetwork = YES;
//    else if (stats == ReachableViaWWAN)
//        isExistenceNetwork = YES;
//    else if (stats == ReachableViaWiFi)
//        isExistenceNetwork = YES;
//
//    if (!isExistenceNetwork) {
//
//        return NO;
//    }
//
//    return isExistenceNetwork;
    
//}

////添加提示 是否有网络 是否有数据 可添加在tableView 上 可以滑动
//- (void)showTipViewWithData:(NSMutableArray *)arr superView:(UIView *)vSuper{
//    if (![self checkIsHaveNet]) {
//        [vSuper showNetErrorPageViewWithFrame:vSuper.frame];
//    }else {
//        [vSuper hideNetErrorPageView];
//        if (arr.count > 0) {
//            [vSuper hideBlankPageView];
//
//        }else {
//            [vSuper showBlankPageViewWithFrame:vSuper.frame];
//
//        }
//    }
//}
//
//
////添加提示 是否有网络 是否有数据 添加的是self.view 不可以滑动
//- (void)showTipViewWithData:(NSMutableArray *)arr withFrame:(CGRect)frameRect{
//    if (![self checkIsHaveNet]) {
//        [self.view showNetErrorPageViewWithFrame:frameRect];
//    }else {
//        [self.view hideNetErrorPageView];
//        if (arr.count > 0) {
//            [self.view hideBlankPageView];
//
//        }else {
//            [self.view showBlankPageViewWithFrame:frameRect];
//
//        }
//    }
//}

#pragma mark - 是否显示导航底部的那条线
- (void )showNaviBottomLine{
    UIImageView *navBarHairlineImageView;
    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    navBarHairlineImageView.hidden = NO;
}


- (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message knowTitle:(NSString *)knowTitle
                completion:(void(^) (BOOL cancelled))completion
{
    if (completion) {
        _completion = completion;
    }
    UIAlertController *alerVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    if (message && message.length > 0)
    {
        message = [NSString stringWithFormat:@"%@",[message stringByReplacingOccurrencesOfString:@"\\n\\n" withString:@" \r\n" ]];
        NSMutableAttributedString *Message = [[NSMutableAttributedString alloc] initWithString:message];
        [Message addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, [Message length])];
        [Message addAttribute:NSFontAttributeName value:FONT(14) range:NSMakeRange(0, [Message length])];
        
        NSMutableParagraphStyle *paragtaphStyle = [[NSMutableParagraphStyle alloc] init];
        
        paragtaphStyle.alignment = NSTextAlignmentCenter;
        
        paragtaphStyle.lineBreakMode = NSLineBreakByCharWrapping;
        
        NSDictionary *dic = @{
                              
                              NSFontAttributeName:FONT(14),
                              NSParagraphStyleAttributeName:paragtaphStyle,
                              
                              NSUnderlineStyleAttributeName:@(NSUnderlineStyleNone)
                              
                              };
        [Message addAttributes:dic range:NSMakeRange(0, message.length)];
        
        [ alerVC setValue:Message forKey:@"attributedMessage"];
        
    }
    
    if (title && title.length >0)
    {
        NSMutableAttributedString *Title = [[NSMutableAttributedString alloc] initWithString:title];
        [Title addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, [Title length])];
        [Title addAttribute:NSFontAttributeName value:FONT(14) range:NSMakeRange(0, [Title length])];
        
        [ alerVC setValue:Title forKey:@"attributedTitle"];
        
    }
   
    knowTitle = (knowTitle && knowTitle.length >0)? knowTitle :@"知道了";
    
    if (knowTitle && knowTitle.length >0)
    {
        // 2.创建并添加按钮
        __weak typeof(self) wSelf = self;

        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:knowTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"Cancel Action");
            if (completion) {
                wSelf.completion(NO);
            }
            
        }];
        if (IOSVERSION >= 8.3)
        {
            [cancelAction setValue:Color_App_topic forKey:@"_titleTextColor"];
        }

       [alerVC  addAction:cancelAction];
        
    }
  
    alerVC.view.backgroundColor = Color_WhiteColor;
    alerVC.view.layer.cornerRadius = 4;
    alerVC.view.clipsToBounds = YES;
    UILabel *appearanceLabel = [UILabel appearanceWhenContainedIn:UIAlertController.class, nil];
    UIFont *font = [UIFont systemFontOfSize:14];
    appearanceLabel.font = font;
    [self presentViewController:alerVC animated:YES completion:nil];
    
}

- (void)showDelayOrderAlertWithTitle:(NSString *)title
                             message:(NSString *)message knowTitle:(NSString *)knowTitle
                          completion:(void(^) (BOOL cancelled))completion
{
    if (completion) {
        _completion = completion;
    }
    UIAlertController *alerVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    if (message && message.length >0)
    {
        message = [NSString stringWithFormat:@"%@",[message stringByReplacingOccurrencesOfString:@"\\n\\n" withString:@" \r\n" ]];
        NSMutableAttributedString *Message = [[NSMutableAttributedString alloc] initWithString:message];
        //        [Message addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, [Message length])];
        [Message addAttribute:NSFontAttributeName value:FONT(14) range:NSMakeRange(0, [Message length])];
        [Message addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, [Message length])];
        NSMutableParagraphStyle *paragtaphStyle = [[NSMutableParagraphStyle alloc] init];
        
        paragtaphStyle.alignment = NSTextAlignmentCenter;
        
        paragtaphStyle.lineBreakMode = NSLineBreakByCharWrapping;
        
        NSDictionary *dic = @{
                              
                              NSFontAttributeName:FONT(14),
                              NSParagraphStyleAttributeName:paragtaphStyle,
                              
                              NSUnderlineStyleAttributeName:@(NSUnderlineStyleNone)
                              
                              };
        [Message addAttributes:dic range:NSMakeRange(0, message.length)];
        
        [ alerVC setValue:Message forKey:@"attributedMessage"];
        
    }
    
    if (title && title.length>0)
    {
        NSMutableAttributedString *Title = [[NSMutableAttributedString alloc] initWithString:title];
        [Title addAttribute:NSForegroundColorAttributeName value:Color_Alert_Message range:NSMakeRange(0, [Title length])];
        [Title addAttribute:NSFontAttributeName value:FONT(14) range:NSMakeRange(0, [Title length])];
        
        [ alerVC setValue:Title forKey:@"attributedTitle"];
        
    }
    
    knowTitle = (knowTitle && knowTitle.length >0)? knowTitle :@"知道了";
    
    if (knowTitle && knowTitle.length>0)
    {
        // 2.创建并添加按钮
        __weak typeof(self) wSelf = self;
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:knowTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"Cancel Action");
            if (completion) {
                wSelf.completion(NO);
            }
            
        }];
        if (IOSVERSION >= 8.3)
        {
            [cancelAction setValue:Color_App_topic forKey:@"_titleTextColor"];
        }
        
        [alerVC  addAction:cancelAction];
        
    }
    
    alerVC.view.backgroundColor = Color_WhiteColor;
    alerVC.view.layer.cornerRadius = 4;
    alerVC.view.clipsToBounds = YES;
    UILabel *appearanceLabel = [UILabel appearanceWhenContainedIn:UIAlertController.class, nil];
    UIFont *font = [UIFont systemFontOfSize:14];
    appearanceLabel.font = font;
    [self presentViewController:alerVC animated:YES completion:nil];
    
}

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
                completion:(void(^) (BOOL cancelled))completion{
    
    if (completion) {
        _completion = completion;
    }
    
    UIAlertController *alerVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    if (message && message.length>0)
    {
        NSMutableAttributedString *Message = [[NSMutableAttributedString alloc] initWithString:message];
        [Message addAttribute:NSForegroundColorAttributeName value:Color_Alert_Message range:NSMakeRange(0, [Message length])];
        [Message addAttribute:NSFontAttributeName value:FONT(14) range:NSMakeRange(0, [Message length])];
        
        [ alerVC setValue:Message forKey:@"attributedMessage"];
        
    }
    if (title && title.length>0)
    {
        NSMutableAttributedString *Title = [[NSMutableAttributedString alloc] initWithString:title];
        [Title addAttribute:NSForegroundColorAttributeName value:Color_Alert_Message range:NSMakeRange(0, [Title length])];
        [Title addAttribute:NSFontAttributeName value:FONT(14) range:NSMakeRange(0, [Title length])];
        
        [ alerVC setValue:Title forKey:@"attributedTitle"];
    }
    
      __weak typeof(self) wSelf = self;
    
    if (strOk && strOk.length>0)
    {
        // 2.创建并添加按钮
      
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:strOk style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"OK Action");
            //        if (completion) {
            wSelf.completion(YES);
            //        }
        }];
        if (IOSVERSION >= 8.3)
        {
            [okAction setValue:Color_App_topic forKey:@"_titleTextColor"];
        }
        [alerVC addAction:okAction];
        
    }

    alerVC.view.backgroundColor = Color_WhiteColor;
    alerVC.view.layer.cornerRadius = 4;
    alerVC.view.clipsToBounds = YES;
    UILabel *appearanceLabel = [UILabel appearanceWhenContainedIn:UIAlertController.class, nil];
    UIFont *font = [UIFont systemFontOfSize:14];
    appearanceLabel.font = font;
   
    if (cancel && cancel.length >0)
    {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancel style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"Cancel Action");
            //        if (completion) {
            wSelf.completion(NO);
            //        }
            
        }];
        if (IOSVERSION >= 8.3)
        {
            [cancelAction setValue:Color_Alert_Gray forKey:@"_titleTextColor"];
        }
           [alerVC  addAction:cancelAction];
    }
    
     [self presentViewController:alerVC animated:YES completion:nil];
    
}

- (void)showDelayOrderAlertWithTitle:(NSString *)title
                             message:(NSString *)message cancelTitle:(NSString *)cancel okTitle:(NSString *)strOk
                          completion:(void(^) (BOOL cancelled))completion
{
    
    if (completion) {
        _completion = completion;
    }
    
    UIAlertController *alerVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    if (message && message.length >0)
    {
        NSMutableAttributedString *Message = [[NSMutableAttributedString alloc] initWithString:message];
        [Message addAttribute:NSForegroundColorAttributeName value:Color_Alert_Red range:NSMakeRange(3, 4)];
        [Message addAttribute:NSFontAttributeName value:FONT(14) range:NSMakeRange(0, [Message length])];
        
        [ alerVC setValue:Message forKey:@"attributedMessage"];
        
    }
    if (title && title.length >0)
    {
        NSMutableAttributedString *Title = [[NSMutableAttributedString alloc] initWithString:title];
        [Title addAttribute:NSForegroundColorAttributeName value:Color_Alert_Message range:NSMakeRange(0, [Title length])];
        [Title addAttribute:NSFontAttributeName value:FONT(14) range:NSMakeRange(0, [Title length])];
        
        [ alerVC setValue:Title forKey:@"attributedTitle"];
    }
    
    __weak typeof(self) wSelf = self;
    
    if (strOk && strOk.length >0)
    {
        // 2.创建并添加按钮
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:strOk style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"OK Action");
            //        if (completion) {
            wSelf.completion(YES);
            //        }
        }];
        if (IOSVERSION >= 8.3)
        {
            [okAction setValue:Color_App_topic forKey:@"_titleTextColor"];
        }
        [alerVC addAction:okAction];
        
    }
    
    alerVC.view.backgroundColor = Color_WhiteColor;
    alerVC.view.layer.cornerRadius = 4;
    alerVC.view.clipsToBounds = YES;
    UILabel *appearanceLabel = [UILabel appearanceWhenContainedIn:UIAlertController.class, nil];
    UIFont *font = [UIFont systemFontOfSize:14];
    appearanceLabel.font = font;
    
    if (cancel && cancel.length >0)
    {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancel style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"Cancel Action");
            //        if (completion) {
            wSelf.completion(NO);
            //        }
            
        }];
        if (IOSVERSION >= 8.3)
        {
            [cancelAction setValue:Color_Alert_Gray forKey:@"_titleTextColor"];
        }
        [alerVC  addAction:cancelAction];
    }
    
    [self presentViewController:alerVC animated:YES completion:nil];
}

- (void)showTouchVC{
    
//    if ([xz_store_channel boolValue] && [[UserDefaults   objectForKey:@"running_status"] isEqualToString:@"0"] ) {
//        if ([[UserDefaults objectForKey:@"userPhone"] length] > 0 &&[[NSString stringWithFormat:@"%@",[UserDefaults objectForKey:@"lockChain"]] isEqualToString:@"1"]) {
//            douyouhn_loginNewVC*vcLogin = [[douyouhn_loginNewVC alloc] init];
//            douyouhn_NaviController *vcNavigation = [[douyouhn_NaviController alloc] initWithRootViewController:vcLogin];
//
//            [self presentViewController:vcNavigation animated:YES completion:nil];
//        }
//
//    }
}




//打开用户交互
- (void)openUserInterActive
{
    [self.view endEditing:NO];
    self.userInterActive =YES;
}

//关闭用户交互
- (void)closeUserInterActive
{
    [self.view endEditing:YES];
    self.userInterActive =NO;
}


#ifdef DEBUG
- (void)injected
{
    [self viewDidLoad];
}
#endif

@end
