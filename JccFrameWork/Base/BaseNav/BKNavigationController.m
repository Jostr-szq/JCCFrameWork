//
//  BKNavigationController.m
//  JccLibrary
//
//  Created by Jostr on 15/1/8.
//  Copyright (c) 2015年 CHAOFENGJIA. All rights reserved.
//

#import "BKNavigationController.h"

@interface BKNavigationController ()

@end

@implementation BKNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
    self.interactivePopGestureRecognizer.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)stopTheMoveGesture
{
    self.interactivePopGestureRecognizer.delegate = nil;
}

-(void)startTheMoveGesture
{
    self.interactivePopGestureRecognizer.delegate = self;
}

@end
