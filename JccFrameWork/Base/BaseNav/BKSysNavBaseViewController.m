//
//  BKSysNavBaseViewController.m
//  JccLibrary
//
//  Created by Jostr on 15/1/8.
//  Copyright (c) 2015年 CHAOFENGJIA. All rights reserved.
//

#import "BKSysNavBaseViewController.h"
#import "BKNavigationController.h"

@interface BKSysNavBaseViewController ()

@property (nonatomic, strong) UIBarButtonItem *leftBarItem;
@property (nonatomic, strong) UIBarButtonItem *rightBarItem;


@end

@implementation BKSysNavBaseViewController

-(instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setTitleView:(UIView *)view
{
    [self.navigationItem setTitleView:view];
}

- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    [self.navigationItem setTitle:title];
}

-(void)setLeftBarItemWithTitle:(NSString *)leftBarItemTitle
{
    [self.leftBarItem setTitle:leftBarItemTitle];
}

-(void)setRightBarItemWithTitle:(NSString *)rightBarItemTitle
{
    [self.rightBarItem setTitle:rightBarItemTitle];
}

-(void)setLeftBarItemTitleColor:(UIColor *)color
{
    [self.leftBarItem setTintColor:color];
}
-(void)setRightBarItemWithTitleColor:(UIColor *)color
{
    [self.rightBarItem setTintColor:color];
}

-(void)setLeftBarItemWithImage:(UIImage *)image
{
    [self.leftBarItem setImage:image];
}

-(void)setRightBarItemWithImage:(UIImage *)image
{
    [self.rightBarItem setImage:image];
}

-(void)setLeftBarItemWithTitle:(NSString *)leftBarItemTitle Color:(UIColor *)color
{
    [self.leftBarItem setTitle:leftBarItemTitle];
    [self.leftBarItem setTintColor:color];
}

-(void)setRightBarItemWithTitle:(NSString *)rightBarItemTitle Color:(UIColor *)color
{
    [self.rightBarItem setTitle:rightBarItemTitle];
    [self.rightBarItem setTintColor:color];
}

-(UIBarButtonItem *)leftBarItem{
    if (_leftBarItem == nil) {
        _leftBarItem = [[UIBarButtonItem alloc]init];
        [self.leftBarItem setTarget:self];
        [self.leftBarItem setAction:@selector(didClickLeftBtnEvent:)];
        [self.navigationItem setLeftBarButtonItem:_leftBarItem];
    }
    return _leftBarItem;
}

-(UIBarButtonItem *)rightBarItem
{
    if (_rightBarItem == nil) {
        _rightBarItem = [[UIBarButtonItem alloc]init];
        [self.rightBarItem setTarget:self];
        [self.rightBarItem setAction:@selector(didClickRightBtnEvent:)];
        [self.navigationItem setRightBarButtonItem:_rightBarItem];
    }
    return _rightBarItem;
}

-(void)setLeftBarItemWithView:(UIView *)view
{
    
}

-(void)setRightBarItemWithView:(UIView *)view
{
    
}


-(void)didClickLeftBtnEvent:(id)sender
{
    //    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)didClickRightBtnEvent:(id)sender
{
    
}

+(UINavigationController *)createNavViewController
{
    UIViewController *vc = [[self alloc]init];
    
    BKNavigationController *nav = [[BKNavigationController alloc]initWithRootViewController:vc];
    
    return nav;
}

@end
