//
//  ViewController.m
//  JavaScriptObjc
//
//  Created by starz on 2017/12/5.
//  Copyright © 2017年 starz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) JSContext *jsContext;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
}

- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        _webView.scalesPageToFit = YES;
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"test.html" withExtension:nil];
        [_webView loadRequest:[NSURLRequest requestWithURL:url]];
        _webView.delegate = self;
    }
    return _webView;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    SZJSOBjcModel *model = [SZJSOBjcModel new];
    self.jsContext[@"OCModel"] = model;
    model.jsContext = self.jsContext;
    model.webView = self.webView;
    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exception) {
        context.exception = exception;
        NSLog(@"异常信息：%@", exception);
    };
}
@end



@implementation SZJSOBjcModel
- (void)callWithDict:(NSDictionary *)params
{
    NSLog(@"JS 调用了OC方法 参数：%@", params);
}

- (void)callSystemCamera
{
    NSLog(@"JS 调用了相机");
    
    JSValue *jsFunc = self.jsContext[@"jsFunc"];
    [jsFunc callWithArguments:nil];
    
}

- (void)jsCallObjcAndObjcWithDict:(NSDictionary *)params
{
    NSLog(@"JS 调用了OC方法 参数：%@", params);
    JSValue *jsParamFunc = self.jsContext[@"jsParamFunc"];
    [jsParamFunc callWithArguments:@[@{@"age":@10, @"name":@"张大炮",@"height":@180}]];
    
}
- (void)showAlert:(NSString *)title msg:(NSString *)msg
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    });
}

@end
