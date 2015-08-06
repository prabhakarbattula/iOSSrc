//
//  ViewController.m
//  samplewebapp
//
//  Created by Mrudul P on 06/07/15.
//  Copyright (c) 2015 Mrudul P. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *myWebView;
@property (weak, nonatomic) IBOutlet UITextField *txt_searchBox;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btn_searchstop;
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSURL* url = [NSURL URLWithString:@"http://www.google.com"];
    NSURLRequest* urlRequest = [NSURLRequest requestWithURL:url];
    [self.myWebView loadRequest:urlRequest];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onSearchStopClicked:(id)sender {
    NSLog(@"SearchStopClicked");
    NSURL* url = [NSURL URLWithString:self.txt_searchBox.text];
    NSURLRequest* urlRequest = [NSURLRequest requestWithURL:url];
    [self.myWebView loadRequest:urlRequest];
}
- (IBAction)onSearchBoxEntered:(id)sender {
    NSLog(@"SearchBoxEntered");
}


@end
