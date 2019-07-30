//
//  JJUIWebIViewViewController.m
//  qhg_ios
//
//  Created by Brian on 2019/7/9.
//  Copyright © 2019 In-next. All rights reserved.
//

#import "JJUIWebIViewViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "Masonry.h"
@interface JJUIWebIViewViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, assign) BOOL                   verified;
@end

@implementation JJUIWebIViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView* webView = [[UIWebView alloc]init];
    webView.scalesPageToFit = YES;        //自动对页面进行缩放以适应屏幕
    webView.backgroundColor =[UIColor lightGrayColor];
    self.webView = webView;
    
    [self.view addSubview:_webView];
    
    self.webView.delegate = self;   //设置代理（ 先遵守协议<UIWebViewDelegate>
    
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:self.vcData]];
    [self.webView loadRequest:request];
    
    [self baseSetup:PageGobackTypePop];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {

    NSLog(@"url:%@",webView.request.URL.absoluteString);
    self.title=[webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [self addMoxieBridge];
    
}
-(void)addMoxieBridge
{
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"]; //如果要在block内赋值给self请⽤用weakself，否则会导致当前controller⽆无法释放
    __weak JJUIWebIViewViewController *weakself = self;
    //云桥任务状态bridge-api
    context[@"mxStatus"] = ^() {
        NSLog(@"mxStatus");
        JSValue *value = [JSContext currentArguments].firstObject;
        NSData *data = [value.toString dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error;
        NSDictionary *infoDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        if(error == nil && infoDic != nil){
            //该任务的task_id
            NSString *task_id = infoDic[@"task_id"];
            //当前描述语
            NSString *description = infoDic[@"description"];
            //任务阶段，具体判断请参考⽂文档
            NSString *phase = infoDic[@"phase"];
            //任务当前状态，具体判断请参考⽂文档
            NSString *phase_status = infoDic[@"phase_status"];
            //任务假如出错的error_code，详情请参考各业务⽂文档
            NSString *error_code = infoDic[@"error_code"];
            //该任务是否已结束
            BOOL finished = [infoDic[@"finished"] boolValue];
            NSLog(@"task_id:%@,description:%@,phase:%@,phase_status:%@,error_code:%@,finished:%d",task_id,description,phase,phase_status,error_code,finished);
            if (finished ||[phase isEqualToString:@"RECEIVE"]) {
                
                weakself.verified =YES;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakself popVC];
                });
                
            }
        }
    };
    
}



@end
