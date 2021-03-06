//
//  JJWKWebViewController.m
//  WKWebViewDemo
//
//  Created by Brain on 2019/3/10.
//  Copyright © 2019 justinjing. All rights reserved.
//
#import <WebKit/WebKit.h>
#import "JJWKWebViewController.h"
#import "Masonry.h"
#import "JJMacroDefine.h"
#import "JJColorDefine.h"
#import "UIButton+MasonryLayout.h"
#define  wkwebViewMargin 26
#define  wkwebViewBtnWidth 23
#define  isIPhonexUp [UIScreen mainScreen].bounds.size.height >= 812
static void *WkwebBrowserContext = &WkwebBrowserContext;
@interface JJWKWebViewController ()<WKNavigationDelegate, WKUIDelegate,WKScriptMessageHandler,UIScrollViewDelegate>
{
    CGFloat wkwebViewBottomViewHeight;
}

@property (strong,nonatomic) WKWebView       *wkWebView;
@property (strong,nonatomic) UIProgressView  *progressView;
@property (strong,nonatomic) UIBarButtonItem *customBackBarItem;
@property (strong,nonatomic) UIBarButtonItem *closeButtonItem;
@property (nonatomic,strong) UIButton        *bottom_homeBtn;
@property (nonatomic,strong) UIButton        *bottom_backBtn;
@property (nonatomic,strong) UIButton        *bottom_forwardBtn;
@property (nonatomic,strong) UIButton        *bottom_refreshBtn;
@property (nonatomic,strong) UIButton        *bottom_clearcacheBtn;
@property (nonatomic,strong) UIButton        *bottom_safariBtn;
@property (nonatomic,strong) UIView          *bottomView;
@property (nonatomic,strong) NSURL           *currentUrl;
@end

@implementation JJWKWebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.wkWebView];
    [self.view addSubview:self.progressView];
    wkwebViewBottomViewHeight = [UIScreen mainScreen].bounds.size.height >= 812 ? 55 :40;
    CGFloat height =NAVIGATIONBAR_HEIGHT;
    if (self.navigationController.viewControllers.count == 0)
    {
        if (self.statuBarMargin) {
            height =isIPhonexUp ? 35 :20;
        }
        else{
            height =0;
        }
    }
    [self.wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(self.view).mas_offset(height);
        make.bottom.equalTo(self.view.mas_bottom).mas_offset(!self.isHideBottom ? -self->wkwebViewBottomViewHeight :0);
    }];
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(self.view);
        make.height.mas_equalTo(2);
    }];
    if (!self.isHideBottom)
    {
        [self.view addSubview:self.bottomView];
        [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.bottom.equalTo(self.view);
            make.height.mas_equalTo(self->wkwebViewBottomViewHeight);
        }];
        [self settupBottomView];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = !self.isHideNav ? NO :YES;
    
    if (@available(iOS 9.0, *)) {
        [self.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[self.absUrlStr stringByRemovingPercentEncoding]]]];
    }
    else
    {
        [self.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[self.absUrlStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
    }
    if (self.resetBottom) {
        [self resetBottomView];
    }
}

#pragma mark-- Lazy loading
- (WKWebView *)wkWebView{
    if (!_wkWebView) {
        //设置网页的配置文件
        WKWebViewConfiguration * Configuration = [[WKWebViewConfiguration alloc]init];
        //允许视频播
        if (@available(iOS 9.0, *))
        {
            Configuration.allowsAirPlayForMediaPlayback = YES;
        }
        
        // 允许在线播放
        Configuration.allowsInlineMediaPlayback = YES;
        // 允许可以与网页交互，选择视图
        Configuration.selectionGranularity = YES;
        // web内容处理池
        Configuration.processPool = [[WKProcessPool alloc] init];
        //自定义配置,一般用于 js调用oc方法(OC拦截URL中的数据做自定义操作)
        WKUserContentController * UserContentController = [[WKUserContentController alloc]init];
        // 添加消息处理，注意：self指代的对象需要遵守WKScriptMessageHandler协议，结束时需要移除
        //        [UserContentController addScriptMessageHandler:self name:@"WXPay"];
        // 是否支持记忆读取
        Configuration.suppressesIncrementalRendering = YES;
        // 允许用户更改网页的设置
        Configuration.userContentController = UserContentController;
        _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0,20, SCREEN_WIDTH, SCREEN_HEIGHT-20) configuration:Configuration];
        _wkWebView.backgroundColor =[UIColor redColor];
        _wkWebView.backgroundColor = [UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1.0];
        // 设置代理
        _wkWebView.navigationDelegate = self;
        _wkWebView.UIDelegate = self;
        _wkWebView.scrollView.delegate =self;
        //kvo 添加进度监控
        [_wkWebView addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:0 context:WkwebBrowserContext];
        //开启手势触摸
        _wkWebView.allowsBackForwardNavigationGestures = YES;
        // 设置 可以前进 和 后退
        //适应你设定的尺寸
        [_wkWebView sizeToFit];
    }
    return _wkWebView;
}

- (UIProgressView *)progressView
{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
        if (self.isHideNav) {
            _progressView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 3);
        }else{
            _progressView.frame = CGRectMake(0, 64, self.view.bounds.size.width, 3);
        }
        // 设置进度条的色彩
        [_progressView setTrackTintColor:[UIColor colorWithRed:76.0/255 green:128.0/255 blue:243.0/255 alpha:1.0]];
        
        _progressView.progressTintColor = self.progressTintColor ? self.progressTintColor: [UIColor greenColor];
    }
    return _progressView;
}

-(UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView =[[UIView alloc]initWithFrame:CGRectZero];
        _bottomView.backgroundColor =Color_White;
    }
    return _bottomView;
}


-(UIBarButtonItem*)customBackBarItem{
    if (!_customBackBarItem) {
        
        _customBackBarItem =[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(customBackItemClicked)];
        [_customBackBarItem setTintColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1]];
        
    }
    return _customBackBarItem;
}

-(UIBarButtonItem*)closeButtonItem{
    if (!_closeButtonItem) {
        _closeButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(closeItemClicked)];
        [_closeButtonItem setTintColor:[UIColor colorWithRed:255/255.0 green:102/255.0 blue:102/255.0 alpha:1]];
    }
    return _closeButtonItem;
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.wkWebView.configuration.userContentController removeScriptMessageHandlerForName:@"WXPay"];
    [self.wkWebView setNavigationDelegate:nil];
    [self.wkWebView setUIDelegate:nil];
    self.navigationController.navigationBarHidden = NO;
}

//注意，观察的移除
-(void)dealloc
{
    [self.wkWebView removeObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
}

#pragma mark--action

-(void)customBackItemClicked
{
    if (self.wkWebView.goBack)
    {
        [self.wkWebView goBack];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)closeItemClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark --layout
-(void)updateNavigationItems
{
    if (!self.isHideLeftItems)
    {
        if (self.wkWebView.canGoBack)
        {
            UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
            spaceButtonItem.width = -6.5;
            
            [self.navigationItem setLeftBarButtonItems:@[spaceButtonItem,self.customBackBarItem,self.closeButtonItem] animated:NO];
        }else
        {
            self.navigationController.interactivePopGestureRecognizer.enabled = YES;
            [self.navigationItem setLeftBarButtonItems:@[self.customBackBarItem]];
        }
    }
    
}

-(void)settupBottomView
{
    if (self.bottom_backBtn == nil) {
        
        NSBundle *bundle =[NSBundle bundleForClass:[self class]];
        NSURL *url =[bundle URLForResource:@"JJToolsSource" withExtension:@"bundle"];
        bundle =[NSBundle bundleWithURL:url];
        UIImage *image;
        image =[UIImage imageNamed:@"wk_activeHome" inBundle:bundle compatibleWithTraitCollection:nil];
        
        self.bottom_homeBtn =[UIButton MAGetButtonWithImage:@"" superView:self.bottomView target:self action:@selector(toolBarItemHomeBtnClick:) masonrySet:^(UIButton *currentBtn, MASConstraintMaker *make) {
            make.centerY.equalTo(self.bottomView);
            make.left.mas_equalTo(wkwebViewMargin);
            make.width.with.height.mas_equalTo(wkwebViewBtnWidth);
            [currentBtn setEnlargedEdge:10];
            [currentBtn setImage:image forState:UIControlStateNormal];
        }];
        
        image =[UIImage imageNamed:@"wk_activeBack" inBundle:bundle compatibleWithTraitCollection:nil];
        
        self.bottom_backBtn =[UIButton MAGetButtonWithImage:@"" superView:self.bottomView target:self action:@selector(toolBarItemBackBtnClick:) masonrySet:^(UIButton *currentBtn, MASConstraintMaker *make) {
            make.centerY.equalTo(self.bottomView);
            make.left.equalTo(self.bottom_homeBtn.mas_right).mas_offset((SCREEN_WIDTH-2*wkwebViewMargin-6*wkwebViewBtnWidth)/5);
            make.width.with.height.mas_equalTo(wkwebViewBtnWidth);
            [currentBtn setEnlargedEdge:10];
            [currentBtn setImage:image forState:UIControlStateNormal];
        }];
        
        image =[UIImage imageNamed:@"wk_activeForward.png" inBundle:bundle compatibleWithTraitCollection:nil];
        
        self.bottom_forwardBtn =[UIButton MAGetButtonWithImage:@"" superView:self.bottomView target:self action:@selector(toolBarItemForwardBtnClick:) masonrySet:^(UIButton *currentBtn, MASConstraintMaker *make) {
            make.centerY.equalTo(self.bottomView);
            make.left.equalTo(self.bottom_backBtn.mas_right).mas_offset((SCREEN_WIDTH-2*wkwebViewMargin-6*wkwebViewBtnWidth)/5);
            make.width.with.height.mas_equalTo(wkwebViewBtnWidth);
            [currentBtn setEnlargedEdge:10];
            [currentBtn setImage:image forState:UIControlStateNormal];
        }];
        
        image =[UIImage imageNamed:@"wk_activeRefresh" inBundle:bundle compatibleWithTraitCollection:nil];
        self.bottom_refreshBtn =[UIButton MAGetButtonWithImage:@"" superView:self.bottomView target:self action:@selector(toolBarItemRefreshBtnClick:) masonrySet:^(UIButton *currentBtn, MASConstraintMaker *make) {
            make.centerY.equalTo(self.bottomView);
            make.left.equalTo(self.bottom_forwardBtn.mas_right).mas_offset((SCREEN_WIDTH-2*wkwebViewMargin-6*wkwebViewBtnWidth)/5);
            make.width.with.height.mas_equalTo(wkwebViewBtnWidth);
            [currentBtn setEnlargedEdge:10];
            [currentBtn setImage:image forState:UIControlStateNormal];
        }];
        
        image =[UIImage imageNamed:@"wk_activeClear" inBundle:bundle compatibleWithTraitCollection:nil];
        
        self.bottom_clearcacheBtn =[UIButton MAGetButtonWithImage:@"" superView:self.bottomView target:self action:@selector(toolBarItemClearBtnClick:) masonrySet:^(UIButton *currentBtn, MASConstraintMaker *make) {
            make.centerY.equalTo(self.bottomView);
            make.left.equalTo(self.bottom_refreshBtn.mas_right).mas_offset((SCREEN_WIDTH-2*wkwebViewMargin-6*wkwebViewBtnWidth)/5);
            make.width.with.height.mas_equalTo(wkwebViewBtnWidth);
            [currentBtn setEnlargedEdge:10];
            [currentBtn setImage:image forState:UIControlStateNormal];
        }];
        
        image =[UIImage imageNamed:@"wk_safari" inBundle:bundle compatibleWithTraitCollection:nil];
        self.bottom_safariBtn =[UIButton MAGetButtonWithImage:@"" superView:self.bottomView target:self action:@selector(toolBarItemSafariBtnClick:) masonrySet:^(UIButton *currentBtn, MASConstraintMaker *make) {
            make.centerY.equalTo(self.bottomView);
            make.left.equalTo(self.bottom_clearcacheBtn.mas_right).mas_offset((SCREEN_WIDTH-2*wkwebViewMargin-6*wkwebViewBtnWidth)/5);
            make.width.with.height.mas_equalTo(wkwebViewBtnWidth);
            [currentBtn setEnlargedEdge:10];
            [currentBtn setImage:image forState:UIControlStateNormal];
        }];
        
    }
}

-(void)toolBarItemHomeBtnClick:(UIButton*)sender
{
    [self.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.absUrlStr]]];
}

-(void)toolBarItemBackBtnClick:(UIButton*)sender
{
    if (self.wkWebView.canGoBack)
    {
        [self.wkWebView goBack];
        [self refreshButtonsStatus];
    }
}

-(void)toolBarItemForwardBtnClick:(UIButton*)sender
{
    if (self.wkWebView.canGoForward)
    {
        [self.wkWebView goForward];
        [self refreshButtonsStatus];
    }
}

-(void)toolBarItemRefreshBtnClick:(UIButton*)sender
{
    [self refreshContentView];
}

-(void)refreshContentView
{
    [self.wkWebView reload];
    [self refreshButtonsStatus];
}

-(void)toolBarItemSafariBtnClick:(UIButton*)sender
{
    UIApplication *app = [UIApplication sharedApplication];
    
    if ([app canOpenURL:self.currentUrl]) {
        if (@available(iOS 10.0, *)) {
            [app openURL:self.currentUrl options:@{} completionHandler:^(BOOL success) {
            }];
        } else {
            [app openURL:self.currentUrl];
            
        }
    }
}

-(void)toolBarItemClearBtnClick:(UIButton*)sender
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"警告" message:@"将清除缓存数据" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //清理缓存技术
        if (@available(iOS 9.0, *)) {
            NSArray * types =@[WKWebsiteDataTypeMemoryCache,WKWebsiteDataTypeDiskCache]; // 9.0之后才有的
            NSSet *websiteDataTypes = [NSSet setWithArray:types];
            NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
            [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
                
            }];
        }else{
            NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask,YES) objectAtIndex:0];
            NSString *cookiesFolderPath = [libraryPath stringByAppendingString:@"/Cookies"];
            NSLog(@"%@", cookiesFolderPath);
            NSError *errors;
            [[NSFileManager defaultManager] removeItemAtPath:cookiesFolderPath error:&errors];
        }
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"点击取消");
        
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)refreshButtonsStatus
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSBundle *bundle =[NSBundle bundleForClass:[self class]];
        NSURL *url =[bundle URLForResource:@"JJToolsSource" withExtension:@"bundle"];
        bundle =[NSBundle bundleWithURL:url];
        UIImage *image;
        image = self.wkWebView.canGoBack ? [UIImage imageNamed:@"wk_activeBack" inBundle:bundle compatibleWithTraitCollection:nil] :[UIImage imageNamed:@"wk_inactiveBack" inBundle:bundle compatibleWithTraitCollection:nil];
        [self.bottom_backBtn setImage:image forState:UIControlStateNormal];
        
        image = self.wkWebView.canGoForward ? [UIImage imageNamed:@"wk_activeForward" inBundle:bundle compatibleWithTraitCollection:nil] :[UIImage imageNamed:@"wk_inactiveForward" inBundle:bundle compatibleWithTraitCollection:nil];
        [self.bottom_forwardBtn setImage:image forState:UIControlStateNormal];
    });
}



#pragma mark ================ WKNavigationDelegate ================

//这个是网页加载完成，导航的变化
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
    [self refreshButtonsStatus];
    self.title = self.wkWebView.title;// 获取加载网页的标题
    self.isHideNav  ? :[self updateNavigationItems];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    [webView evaluateJavaScript:@"document.documentElement.style.webkitUserSelect='none'" completionHandler:nil];
    
    [webView evaluateJavaScript:@"document.documentElement.style.webkitTouchCallout='none'" completionHandler:nil];
}

//开始加载
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    //开始加载的时候，让加载进度条显示
    self.progressView.hidden = NO;
}

//内容返回时调用
-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    
}

//服务器请求跳转的时候调用
-(void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation
{
    
}

//服务器开始请求的时候调用
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    if(webView != self.wkWebView) {
        decisionHandler(WKNavigationActionPolicyAllow);
        return;
    }
    NSURL  * url = navigationAction.request.URL;
    self.currentUrl =url;
    UIApplication *app = [UIApplication sharedApplication];
    
    if ([url.absoluteString containsString:@"itunes.apple.com"]||[url.absoluteString containsString:@"ad-ma"])
    {
        if ([app canOpenURL:url])
        {
            if (@available(iOS 10.0, *)) {
                [app openURL:url options:@{} completionHandler:^(BOOL success) {
                    
                }];
            } else {
                [app openURL:url];
            }
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
    }
    if (!navigationAction.targetFrame.isMainFrame) {
        [self.wkWebView loadRequest:navigationAction.request];
    }
    
    decisionHandler(WKNavigationActionPolicyAllow);
}


-(void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    decisionHandler(WKNavigationResponsePolicyAllow);
    //    NSLog(@"navigationResponse.response.URL--------->>>>>%@",navigationResponse.response.URL);
    
}

// 内容加载失败时候调用
-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    NSLog(@"页面加载失败");
}

//跳转失败的时候调用
-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    
}

//进度条
-(void)webViewWebContentProcessDidTerminate:(WKWebView *)webView
{
    
}


#pragma mark ================ WKUIDelegate ================

// 获取js 里面的提示
-(void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    
    [self presentViewController:alert animated:YES completion:NULL];
}

// js 信息的交流
-(void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }]];
    [self presentViewController:alert animated:YES completion:NULL];
}

// 交互。可输入的文本。
-(void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"textinput" message:@"JS调用输入框" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.textColor = [UIColor redColor];
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler([[alert.textFields lastObject] text]);
    }]];
    
    [self presentViewController:alert animated:YES completion:NULL];
    
}

//KVO监听进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))] && object == self.wkWebView) {
        [self.progressView setAlpha:1.0f];
        BOOL animated = self.wkWebView.estimatedProgress > self.progressView.progress;
        [self.progressView setProgress:self.wkWebView.estimatedProgress animated:animated];
        
        // Once complete, fade out UIProgressView
        if(self.wkWebView.estimatedProgress >= 1.0f) {
            [UIView animateWithDuration:0.3f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0f animated:NO];
            }];
        }
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark ================ WKScriptMessageHandler ================

//拦截执行网页中的JS方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    
    //服务器固定格式写法 window.webkit.messageHandlers.名字.postMessage(内容);
    //客户端写法 message.name isEqualToString:@"名字"]
    //    if ([message.name isEqualToString:@"WXPay"]) {
    //        NSLog(@"%@", message.body);
    //调用微信支付方法
    //        [self WXPayWithParam:message.body];
    //    }
}

#pragma  mark --uiscrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (!self.isCancelSuspension)
    {
        CGFloat translation = [scrollView.panGestureRecognizer translationInView:scrollView.superview].y;
        BOOL scrollingUp = (translation > 0.0f);
        if (!self.wkWebView.isLoading)
        {
            [self setToolbarVisible:scrollingUp];
        }
    }
}

- (void)setToolbarVisible:(BOOL)visible
{
    if (self.isHideBottom) {
        return;
    }
    else
    {
        if (visible) {
            
            [UIView animateWithDuration:1.5 animations:^{
                [self.wkWebView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.bottom.equalTo(self.view.mas_bottom).mas_offset(-self->wkwebViewBottomViewHeight);
                }];
                self.bottomView.hidden =NO;
            }];
            
            NSBundle *bundle =[NSBundle bundleForClass:[self class]];
            NSURL *url =[bundle URLForResource:@"JJToolsSource" withExtension:@"bundle"];
            bundle =[NSBundle bundleWithURL:url];
            UIImage *image;
            image = self.wkWebView.canGoBack ? [UIImage imageNamed:@"wk_activeBack" inBundle:bundle compatibleWithTraitCollection:nil] :[UIImage imageNamed:@"wk_inactiveBack" inBundle:bundle compatibleWithTraitCollection:nil];
            [self.bottom_backBtn setImage:image forState:UIControlStateNormal];
            
            image = self.wkWebView.canGoForward ? [UIImage imageNamed:@"wk_activeForward" inBundle:bundle compatibleWithTraitCollection:nil] :[UIImage imageNamed:@"wk_inactiveForward" inBundle:bundle compatibleWithTraitCollection:nil];
            [self.bottom_forwardBtn setImage:image forState:UIControlStateNormal];
        }
        else
        {
            [UIView animateWithDuration:1.5 animations:^{
                [self.wkWebView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.bottom.equalTo(self.view.mas_bottom);
                }];
                self.bottomView.hidden =YES;
            }];
            
        }
        
    }
}

-(void)resetBottomView
{
    [self.wkWebView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.view.mas_bottom).mas_offset(!self.isHideBottom ? -self->wkwebViewBottomViewHeight :0);
    }];
    
    if (!self.isHideBottom)
    {
        [self.view addSubview:self.bottomView];
        [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.bottom.equalTo(self.view);
            make.height.mas_equalTo(self->wkwebViewBottomViewHeight);
        }];
        [self settupBottomView];
    }
    else
    {
        [self.bottomView removeFromSuperview];
    }
}

@end
