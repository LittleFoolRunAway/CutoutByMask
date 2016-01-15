//
//  ViewController.m
//  MaskDemo
//
//  Created by dingxin on 16/1/13.
//  Copyright © 2016年 dingxin. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

#import "CutoutMaskView.h"

@interface ViewController ()
{
    UIImageView *_contentImgV;
    
    UIImageView *_coverImgV;
    
    CutoutMaskView *_cutoutV;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _contentImgV = [[UIImageView alloc] initWithFrame:self.view.bounds];
    _contentImgV.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [_contentImgV setImage:[UIImage imageNamed:@"20151124033032915.jpg"]];
    _contentImgV.contentMode = UIViewContentModeScaleAspectFill;
    
    [self.view addSubview:_contentImgV];
    
    
    //Test
//    _coverImgV = [[UIImageView alloc] initWithFrame:self.view.bounds];
//    _coverImgV.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
////    [_coverImgV setImage:[UIImage imageNamed:@""]];
//    _coverImgV.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
//    [self.view addSubview:_coverImgV];
//    
//    UIBezierPath *path = [UIBezierPath bezierPathWithRect:_coverImgV.bounds];
//    // MARK: circlePath
//    [path appendPath:[UIBezierPath bezierPathWithArcCenter:CGPointMake(240, 340) radius:40 startAngle:0 endAngle:2*M_PI clockwise:NO]];
//    
//    // MARK: roundRectanglePath
//    [path appendPath:[[UIBezierPath bezierPathWithRoundedRect:CGRectMake(20, 400, 320 - 2 * 20, 100) cornerRadius:15] bezierPathByReversingPath]];
//    
//  //    UIBezierPath* path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(240, 340) radius:40 startAngle:0 endAngle:2*M_PI clockwise:NO];
//    
//    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
//    shapeLayer.path = path.CGPath;
//    _coverImgV.layer.mask = shapeLayer;
    

    
    _cutoutV= [[CutoutMaskView alloc] initWithFrame:self.view.bounds];
    _cutoutV.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
    [_cutoutV setCutoutCirCle:CGPointMake(240, 340) andRadius:60];
    
    [self.view addSubview:_cutoutV];
    
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [self.view addGestureRecognizer:tapGes];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tapped:(UITapGestureRecognizer *)tapGesture
{
    CGPoint tapPoint = [tapGesture locationInView:self.view];
    
    [_cutoutV setCutoutCirCle:tapPoint andRadius:60];
}

@end
