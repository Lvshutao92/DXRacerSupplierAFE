//
//  WebViewController.m
//  DXRacer
//
//  Created by ilovedxracer on 2017/7/10.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()<UIWebViewDelegate>

@property(nonatomic,strong)UIWebView *webView;

@end

@implementation WebViewController


- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    //    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    btn.frame = CGRectMake(0, 0, 30, 30);
    //    [btn setImage:[UIImage imageNamed:@"backreturn"] forState:UIControlStateNormal];
    //    [btn addTarget:self action:@selector(clickback) forControlEvents:UIControlEventTouchUpInside];
    //    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:btn];
    //    self.navigationItem.leftBarButtonItem = bar;
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width-20, self.view.frame.size.height)];
    self.webView.delegate = self;
    self.webView.scalesPageToFit = YES;
    self.webView.scrollView.backgroundColor = [UIColor clearColor];
    
    
    // 避免WebView最下方出现黑线
     self.webView.opaque = NO;
     self.webView.backgroundColor = [UIColor clearColor];
   
    
    // 去掉webView的滚动条
    for (UIView *subView in [self.webView subviews])
    {
        if ([subView isKindOfClass:[UIScrollView class]])
        {
            // 不显示竖直的滚动条
            [(UIScrollView *)subView setShowsVerticalScrollIndicator:NO];
        }
    }
    
   
    
    
    if (self.str != nil) {
        NSURLRequest *request  = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:self.webStr]];
        [self.webView loadRequest:request];
    }else{
        [self.webView loadHTMLString:self.webStr baseURL:nil];
    }
    
    
    
    
    [self.view addSubview:self.webView];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView{
   
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '300%'"];
    
    if (self.str != nil){
        [_webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '300%'"];
       // _webView.scalesPageToFit = YES;
        [webView stringByEvaluatingJavaScriptFromString:
         @"var script = document.createElement('script');"
         "script.type = 'text/javascript';"
         "script.text = \"function ResizeImages() { "
         "var myimg,oldwidth;"
         "var maxwidth=350;" //缩放系数
         "for(i=0;i <document.images.length;i++){"
         "myimg = document.images[i];"
         "if(myimg.width > maxwidth){"
         "oldwidth = myimg.width;"
         "myimg.width = maxwidth;"
         "myimg.height = myimg.height * (maxwidth/oldwidth);"
         "}"
         "}"
         "}\";"
         "document.getElementsByTagName('head')[0].appendChild(script);"];
        [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
    }

}









@end
