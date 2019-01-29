//
//  JJBaseRequest.m
//  JJTools
//
//  Created by Brain on 2018/12/12.
//  Copyright © 2018 Brain. All rights reserved.
//
#import "AFNetworking.h"
#import "MBProgressHUD.h"

#import "JJBaseRequest.h"
#import "JJMacroDefine.h"
#import "JJFontDefine.h"
#import "JJColorDefine.h"
#import "JJUrlDefine.h"
#import "JJConstants.h"
#import "UIColor+JJTools.h"
#import "NSString+JJTools.h"
#import "JJTool.h"
#import "JJUserManager.h"
#import "UIDevice+JJDevice.h"
#import "JJReachability.h"

@interface AFHTTPSessionManager (ShareManagerForPreventLeaks)

+ (instancetype)shareManager;

@end
@implementation AFHTTPSessionManager(ShareManagerForPreventLeaks)

+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    static AFHTTPSessionManager *result;
    dispatch_once(&onceToken, ^{
        result = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    });
    return result;
}

@end
@implementation JJBaseRequest


//在url后面拼接版本号等信息
- (NSString *)handleUrlWithParamWithStr:(NSString *)str {
    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc] init];
    [dataDic setObject:APP_NAME forKey:@"appName"];
    [dataDic setObject:@"ios" forKey:@"clientType"];
    [dataDic setObject:AppVersion forKey:@"appVersion"];
    [dataDic setObject:[NSString getUUIDString] forKey:@"deviceId"];
    [dataDic setObject:@"oss" forKey:@"channelName"];
    [dataDic setValue:UserDefaultsGetter(@"userPhone") forKey:@"mobilePhone"];
    
    return [NSString addQueryStringToUrl:str params:dataDic];
}

- (void)doHttpWithUrl:(NSString *)url andMetohd:(NSString *)method andParameters:(NSDictionary *)parameters andHeaders:(NSDictionary *)headers withSuccessHandler:(successHandler)successHandler andFailHandler:(failHandler)failHandler{
    //url 地址 后半部分
    NSString *strUrlPadding = [url substringFromIndex:Url_Server.length];
    
    url = [self handleUrlWithParamWithStr:url];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    if ([JJNetWorkStatus sharedNetWorkStatus].netWorkStatus == NotReachable) {
        failHandler(nil,-200,@"网络连接已断开");
        return;
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager shareManager];
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    [manager setResponseSerializer:responseSerializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"application/x-json",@"text/html", @"text/plain", nil];
    for (NSString*key in headers) {
        [manager.requestSerializer setValue:headers[key] forHTTPHeaderField:key];
    }
    NSString *userJsessionid = [UserDefaults objectForKey:@"jesessionId"];
    NSString *userToken = [UserDefaults objectForKey:@"token"];
    if (userJsessionid.length>11) {
        [manager.requestSerializer setValue:userJsessionid forHTTPHeaderField:@"Cookie"];
    }
    if (userToken.length!=0) {
        [manager.requestSerializer setValue:userToken forHTTPHeaderField:@"token"];
    }
    
    [manager.requestSerializer setValue:@"iOSApp" forHTTPHeaderField:@"Request-From"];
    
    
    NSString *strDate = [JJTool getCurrentTimestamp];
    
    //10位随机数
    NSString *strRandom = @"";
    
    for(int i=0; i<10; i++)
    {
        strRandom = [ strRandom stringByAppendingFormat:@"%i",(arc4random() % 9)];
    }
    
    // 签名
    NSString *signature = [NSString stringWithFormat:@"%@%@%@",strUrlPadding,strDate,strRandom];
    
//    NSString *strDataSigntureNew = [NSString  HmacSha1:kSaltShA1Key data:signature];
    
    NSString *strDataSigntureNew =signature;
    
    if (strDataSigntureNew && ![strDataSigntureNew isEmptyStr])
    {
        [manager.requestSerializer setValue:strDataSigntureNew forHTTPHeaderField:@"signature"];
    }
    
    [manager.requestSerializer setValue:strRandom forHTTPHeaderField:@"echostr"];
    [manager.requestSerializer setValue:strDate  forHTTPHeaderField:@"timestamp"];
    
    void(^af_success_cb)(NSHTTPURLResponse *response, id responseObject) = ^(NSHTTPURLResponse *response, id responseObject) {
        NSDictionary * dict = responseObject;
     
       if ([[dict[@"code"] description] isEqualToString:@"401"])//token失效的时候
        {
            [[JJUserManager sharedUserManager] logout];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNeedLogin object:nil];
            
            successHandler(responseObject,response.statusCode);
        }
        else{
            if ([[dict[@"code"] description] isEqualToString:@"-2"]) {
                [[JJUserManager sharedUserManager] logout];
            }
            successHandler(responseObject,response.statusCode);
        }
        
    };
    void(^af_error_cb)(NSHTTPURLResponse *response, NSError *error) = ^(NSHTTPURLResponse *response, NSError *error) {
        
        NSString *strErrorMsg;
        NSString *strTitle;
        if (response.statusCode == 401) {
            [[JJUserManager sharedUserManager] logout];
            strErrorMsg = @"请登录";
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNeedLogin object:nil];
        }
        else if (response.statusCode/100 == 5) {
            
            strTitle =[NSString stringWithFormat:@"%@\n请求失败,请稍后再试",[error localizedDescription]];
        }
        
        else if (response.statusCode/100 == 3) {
            strTitle =@"服务器跳转中\n请求失败,请稍后再试";
        }
        else {
            strTitle = [NSString stringWithFormat:@"%@\n请求失败,请稍后再试",[error localizedDescription]];
            
        }
        
        if ([[error localizedDescription]containsString:@"重新登录"])
        {
            [[JJUserManager sharedUserManager] logout];
            strTitle = @"请登录";
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNeedLogin object:nil];
        }
        else if ([[error localizedDescription]containsString:@"未能"])
        {
            strTitle = [NSString stringWithFormat:@"后台正在发版\n请稍后再试"];
        }
        
        NSDate *date=[NSDate date];
        NSDateFormatter *format1=[[NSDateFormatter alloc] init];
        [format1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *dateStr;
        dateStr=[format1 stringFromDate:date];
        
        NSData * data = error.userInfo[@"com.alamofire.serialization.response.error.data"];
        NSString * str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        str = str.length >0? str :@"errorData return nil";
        NSString * deviceID =[NSString getUUIDString];
        NSString* phoneStr =UserDefaultsGetter(@"userPhone")? UserDefaultsGetter(@"userPhone"):@"未登录";
        NSString* iosVersion=[NSString stringWithFormat:@"%.1lf",IOSVERSION];
        NSString *deviceType =[[[UIDevice alloc]init]machineModelName];
        strErrorMsg =[NSString stringWithFormat:@"%@\nuserPhone:%@\nappTime:%@\nerrorData:%@\ndeviceId:%@\niosVersion:%@\ndeviceType:%@",strTitle,phoneStr,dateStr,str,deviceID,iosVersion,deviceType];
        
        failHandler(error,response.statusCode,strErrorMsg);
    };
    
    if ([[method lowercaseString] isEqualToString:@"get"]) {
        [manager GET:url parameters:parameters progress:^(NSProgress *downloadProgress) {
            
        } success:^(NSURLSessionDataTask *task, id responseObject) {
            af_success_cb((NSHTTPURLResponse*)task.response,responseObject);
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            af_error_cb((NSHTTPURLResponse*)task.response,error);
        }];
    } else   if ([[method lowercaseString] isEqualToString:@"patch"]||[[method lowercaseString] isEqualToString:@"put"]) {
        NSMutableURLRequest *req  = [manager.requestSerializer requestWithMethod:[method uppercaseString] URLString:url parameters:parameters error:nil];
        NSString *jsonString = [self convertToJsonData:parameters];
        
        [req setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
        
        [[manager dataTaskWithRequest:req uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
            
        } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
            
        } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            if (!error) {//请求成功
                if (responseObject) {
                    
                    af_success_cb((NSHTTPURLResponse*)response,responseObject);// 统一调用上面的成功回调
                    return ;
                }
                else{
                    
                    af_error_cb((NSHTTPURLResponse*)response,error);// 统一调用上面的失败回调
                }
                NSLog(@"Error: %@, %@, %@", error, response, responseObject);
            }
            
        }] resume];
       
    } else if ([[method lowercaseString] isEqual:@"post"]) {
        
        [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"post请求成功:%@", responseObject);
            
            if (responseObject) {
                af_success_cb((NSHTTPURLResponse*)task.response,responseObject);
                return ;
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"post请求失败:%@", error);
            af_error_cb((NSHTTPURLResponse*)task.response,error);
            
        }];
    }
}

- (void)uploadImageWithUrl:(NSString*)url dicParama:(NSDictionary *)paramDict imageData:(NSData *)imageData fileName:(NSString *)fileName key:(NSString *)key withSuccessHandler:(successHandler)successHandler andFailHandler:(failHandler)failHandler {
    NSString *strUrlPadding = [url substringFromIndex:Url_Server.length];
    
    url = [self handleUrlWithParamWithStr:url];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    if ([JJNetWorkStatus sharedNetWorkStatus].netWorkStatus == NotReachable) {
        failHandler(nil,-200,@"网络连接已断开");
        return;
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager shareManager];
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    [manager setResponseSerializer:responseSerializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    NSString *strDate = [JJTool getCurrentTimestamp];
    
    //10位随机数
    NSString *strRandom = @"";
    
    for(int i=0; i<10; i++)
    {
        strRandom = [ strRandom stringByAppendingFormat:@"%i",(arc4random() % 9)];
    }
    
    // 签名
    NSString *signature = [NSString stringWithFormat:@"%@%@%@",strUrlPadding,strDate,strRandom];
    
    NSString *strDataSigntureNew =signature;
//    NSString *strDataSigntureNew = [NSString  HmacSha1:kSaltShA1Key data:signature];

    [manager.requestSerializer setValue:strDataSigntureNew forHTTPHeaderField:@"signature"];

    [manager.requestSerializer setValue:strRandom forHTTPHeaderField:@"echostr"];
    [manager.requestSerializer setValue:strDate  forHTTPHeaderField:@"timestamp"];
    
    NSString *userJsessionid = [UserDefaults objectForKey:@"token"];
    if (userJsessionid.length!=0) {
        [manager.requestSerializer setValue:userJsessionid forHTTPHeaderField:@"token"];
    }
    
    [manager.requestSerializer setValue:@"iOSApp" forHTTPHeaderField:@"Request-From"];
    [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:paramDict error:nil];
    void(^af_success_cb)(NSHTTPURLResponse *response, id responseObject) = ^(NSHTTPURLResponse *response, id responseObject) {
        
        NSDictionary * dict = responseObject;
        
        if ([[dict[@"code"] description] isEqualToString:@"401"])//token失效的时候
        {
            [[JJUserManager sharedUserManager] logout];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNeedLogin object:nil];
            
            successHandler(responseObject,response.statusCode);
        }
        else{
            if ([[dict[@"code"] description] isEqualToString:@"-2"]) {
                [[JJUserManager sharedUserManager] logout];
            }
            successHandler(responseObject,response.statusCode);
        }
    };
    void(^af_error_cb)(NSHTTPURLResponse *response, NSError *error) = ^(NSHTTPURLResponse *response, NSError *error) {
        NSString *strErrorMsg;
        NSString *strTitle;
        if (response.statusCode == 401) {
            [[JJUserManager sharedUserManager] logout];
            strErrorMsg = @"请登录";
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNeedLogin object:nil];
        }
        else if (response.statusCode/100 == 5) {
            
            strTitle =[NSString stringWithFormat:@"%@\n请求失败,请稍后再试",[error localizedDescription]];
        }
        
        else if (response.statusCode/100 == 3) {
            
            strTitle =@"服务器跳转中\n请求失败,请稍后再试";
        }
        else {
            strTitle = [NSString stringWithFormat:@"%@\n请求失败,请稍后再试",[error localizedDescription]];
        }
        if ([[error localizedDescription]containsString:@"重新登录"])
        {
            [[JJUserManager sharedUserManager] logout];
            strTitle = @"请登录";
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNeedLogin object:nil];
        }
        else if ([[error localizedDescription]containsString:@"未能"] && ![[error localizedDescription]containsString:@"未能完成"])
        {
            strTitle = [NSString stringWithFormat:@"后台正在发版\n请稍后再试"];
        }
        
        NSDate *date=[NSDate date];
        NSDateFormatter *format1=[[NSDateFormatter alloc] init];
        [format1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *dateStr;
        dateStr=[format1 stringFromDate:date];
        
        NSData * data = error.userInfo[@"com.alamofire.serialization.response.error.data"];
        NSString * str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        str = str.length >0? str :@"errorData return nil";
        NSString * deviceID =[NSString getUUIDString];
        NSString* phoneStr =UserDefaultsGetter(@"userPhone")? UserDefaultsGetter(@"userPhone"):@"未登录";
        NSString* iosVersion=[NSString stringWithFormat:@"%.1lf",IOSVERSION];
        NSString *deviceType =[[[UIDevice alloc]init]machineModelName];
        strErrorMsg =[NSString stringWithFormat:@"%@\nuserPhone:%@\nappTime:%@\nerrorData:%@\ndeviceId:%@\niosVersion:%@\ndeviceType:%@",strTitle,phoneStr,dateStr,str,deviceID,iosVersion,deviceType];
        failHandler(error,response.statusCode,strErrorMsg);
    };
    
    [manager POST:url parameters:paramDict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:imageData name:key fileName:fileName mimeType:@"image/jpeg"];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        af_success_cb((NSHTTPURLResponse*)task.response,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        af_error_cb((NSHTTPURLResponse*)task.response,error);
    }];
}

-(NSString *)convertToJsonData:(NSDictionary *)dict{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];

    return mutStr;
}

#pragma mark - 提示消息
- (void)showMessage:(NSString *)msg{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.animationType = MBProgressHUDAnimationZoomOut;
    hud.mode = MBProgressHUDModeText;
    //    hud.labelText = [TipMessage shared].tipMessage.tipTitle;
    //Customize bezelView properties instead
    hud.detailsLabel.text = msg;
    hud.margin = 10.f;
    hud.bezelView.alpha = 0.5;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:0.8];
}

@end
