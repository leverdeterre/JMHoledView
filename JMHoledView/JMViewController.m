//
//  JMViewController.m
//  JMHoledView
//
//  Created by jerome morissard on 01/02/2015.
//  Copyright (c) 2015 Jerome Morissard. All rights reserved.
//

#import "JMViewController.h"
#import "JMHoledView.h"

@interface JMViewController () <UIWebViewDelegate, JMHoledViewDelegate>
@property (weak) IBOutlet JMHoledView *holedView;
@property (weak) IBOutlet UIWebView *webView;
@end

@implementation JMViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSURL *url = [NSURL URLWithString:@"http://www.google.fr"];
    NSURLRequest *rquest = [[NSURLRequest alloc] initWithURL:url];
    [self.webView loadRequest:rquest];
    self.webView.delegate = self;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.holedView.holeViewDelegate = self;
    [self.holedView addHoleCircleCenteredOnPosition:CGPointMake(25.0f, 25.0f) diameter:40.0f];
    [self.holedView addHoleRectOnRect:CGRectMake(10.0f, 250.0f, 300.0f, 30.0f)];
    [self.holedView addHCustomView:[self viewForDemo] onRect:CGRectMake(60.0f, 350.0f, 200.0f, 50.0f)];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    self.holedView.holeViewDelegate = self;
    [self.holedView addHoleCircleCenteredOnPosition:CGPointMake(150.0f, 50.0f) diameter:40.0f text:@"Left text!\n*conditions apply" onPosition:JMPositionLeft margin:10.0f];
    [self.holedView addHoleCircleCenteredOnPosition:CGPointMake(150.0f, 100.0f) diameter:40.0f text:@"Right Text" onPosition:JMPositionRight margin:10.0f];
    [self.holedView addHoleCircleCenteredOnPosition:CGPointMake(150.0f, 160.0f) diameter:40.0f text:@"Top Text" onPosition:JMPositionTop margin:0];
    [self.holedView addHoleCircleCenteredOnPosition:CGPointMake(150.0f, 210.0f) diameter:40.0f text:@"Bottom Text" onPosition:JMPositionBottom margin:0];
    
    // test add oval hole at bottom without label, so no delegate fire for this
    [self.holedView addHoleCircleCenteredOnPosition:CGPointMake(150.0f, 450.0f) diameter:50 hScale:0.5f];
    
    [self.holedView addHoleCircleCenteredOnPosition:CGPointMake(100.0f, 300.0f) diameter:40.0f text:@"Top Left" onPosition:JMPositionTopLeftCorner margin:0];
    [self.holedView addHoleCircleCenteredOnPosition:CGPointMake(200.0f, 300.0f) diameter:40.0f text:@"Top Right" onPosition:JMPositionTopRightCorner margin:0];
    [self.holedView addHoleCircleCenteredOnPosition:CGPointMake(100.0f, 350.0f) diameter:40.0f text:@"Bottom Left" onPosition:JMPositionBottomLeftCorner margin:0];
    [self.holedView addHoleCircleCenteredOnPosition:CGPointMake(200.0f, 350.0f) diameter:40.0f text:@"Bottom Right" onPosition:JMPositionBottomRightCorner margin:0];
    
}

#pragma mark - JMHoledViewDelegate

- (void)holedView:(JMHoledView *)holedView didSelectHoleAtIndex:(NSUInteger)index
{
    NSLog(@"%s %ld", __PRETTY_FUNCTION__,(long)index);
}

-(void)holedView:(JMHoledView *)holedView willAddLabel:(UILabel *)label atIndex:(NSUInteger)index
{
    if (index == 0)
    {
        label.layer.cornerRadius = 3.f;
        label.layer.borderWidth = 1.f;
        label.layer.borderColor = [UIColor whiteColor].CGColor;
        
        CGFloat margin = label.layer.borderWidth + 4;
        CGRect frame = label.frame;
        frame.origin.x -= margin;
        frame.origin.y -= margin;
        frame.size.width += margin*2;
        frame.size.height += margin*2;
        label.frame = frame;
    }
    
}

#pragma marl - helper

- (UIView *)viewForDemo
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 350.0F, 200.0f, 50.0f)];
    [label setBackgroundColor:[UIColor clearColor]];
    label.layer.borderColor = [UIColor whiteColor].CGColor;
    label.layer.borderWidth = 1.0f;
    label.layer.cornerRadius = 10.0f;
    [label setTextColor:[UIColor whiteColor]];
    label.text = @"This control can be use to Highlight informations.";
    label.numberOfLines = 2;
    label.font = [UIFont systemFontOfSize:14.0f];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

@end
