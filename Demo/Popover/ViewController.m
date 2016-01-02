//
//  ViewController.m
//  Popover
//
//  Created by Yaroslav Arsenkin on 27.05.15.
//  Copyright (c) 2015 Iaroslav Arsenkin.
//  Website: http://arsenkin.com
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//    
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "ViewController.h"
#import "ARSPopover.h"


@interface ViewController () <ARSPopoverDelegate>

@property (nonatomic, weak) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIButton *buttonWithWebView;

@end


@implementation ViewController

- (IBAction)showPopover:(id)sender {
    ARSPopover *popoverController = [ARSPopover new];
    popoverController.sourceView = self.button;
    popoverController.sourceRect = CGRectMake(CGRectGetMidX(self.button.bounds), CGRectGetMaxY(self.button.bounds), 0, 0);
    popoverController.contentSize = CGSizeMake(100, 50);
    popoverController.arrowDirection = UIPopoverArrowDirectionUp;
    
    [self presentViewController:popoverController animated:YES completion:^{
        [popoverController insertContentIntoPopover:^(ARSPopover *popover, CGSize popoverPresentedSize, CGFloat popoverArrowHeight) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [button setTitle:@"Close" forState:UIControlStateNormal];
            [button sizeToFit];
            [button setCenter:CGPointMake(50, 25)];
            [button addTarget:popover action:@selector(closePopover) forControlEvents:UIControlEventTouchUpInside];
            
            [popover.view addSubview:button];
        }];
    }];
}

- (IBAction)showPopoverWithWebView:(id)sender {
    ARSPopover *popoverController = [ARSPopover new];
    popoverController.sourceView = self.buttonWithWebView;
    popoverController.sourceRect = CGRectMake(CGRectGetMidX(self.buttonWithWebView.bounds), CGRectGetMaxY(self.buttonWithWebView.bounds), 0, 0);
    popoverController.contentSize = CGSizeMake(400, 600);
    popoverController.arrowDirection = UIPopoverArrowDirectionUp;
    
    [self presentViewController:popoverController animated:YES completion:^{
        [popoverController insertContentIntoPopover:^(ARSPopover *popover, CGSize popoverPresentedSize, CGFloat popoverArrowHeight) {
            CGFloat originX = 0;
            CGFloat originY = 0;
            CGFloat width = popoverPresentedSize.width;
            CGFloat height = popoverPresentedSize.height - popoverArrowHeight;
            
            CGRect frame = CGRectMake(originX, originY, width, height);
            UIWebView *webView = [[UIWebView alloc] initWithFrame:frame];
            webView.scalesPageToFit = YES;
            [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://google.com"]]];
            [popover.view addSubview:webView];
        }];
    }];
}

#pragma mark <ARSPopoverDelegate>

- (void)popoverPresentationController:(UIPopoverPresentationController *)popoverPresentationController willRepositionPopoverToRect:(inout CGRect *)rect inView:(inout UIView *__autoreleasing *)view {
    // delegate for you to use.
}

- (void)popoverPresentationControllerDidDismissPopover:(UIPopoverPresentationController *)popoverPresentationController {
    // delegate for you to use.
}

- (BOOL)popoverPresentationControllerShouldDismissPopover:(UIPopoverPresentationController *)popoverPresentationController {
    // delegate for you to use.
    return YES;
}

@end
