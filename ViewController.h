//
//  ViewController.h
//  JavaScriptObjc
//
//  Created by starz on 2017/12/5.
//  Copyright © 2017年 starz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol JSObjcDelegate <JSExport>
- (void)callSystemCamera;
- (void)showAlert:(NSString *)title msg:(NSString *)msg;
- (void)callWithDict:(NSDictionary *)params;
- (void)jsCallObjcAndObjcWithDict:(NSDictionary *)params;
@end

@interface ViewController : UIViewController
@end

@interface SZJSOBjcModel : NSObject <JSObjcDelegate>
@property (nonatomic,weak) JSContext *jsContext;
@property (nonatomic,weak) UIWebView *webView;
@end

