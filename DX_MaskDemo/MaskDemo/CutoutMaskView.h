//
//  CutoutMaskView.h
//  MaskDemo
//
//  Created by dingxin on 16/1/13.
//  Copyright © 2016年 dingxin. All rights reserved.
//  镂空，透视效果，目前只支持圆形镂空，可以实现指定位置圆形透明遮罩效果

#import <UIKit/UIKit.h>

@interface CutoutMaskView : UIView
{
    CAShapeLayer *_shapeMaskLayer;
    
//    CGPoint _circleCenterP;
//    CGFloat _circleRadius;
    
    NSMutableArray *_circleDatasAry;
}

-(void)setCutoutCirCle:(CGPoint)center andRadius:(CGFloat)theRadius;

-(void)setCutoutCirCles:(NSArray *)circlesAry;

@end


@interface CircleInfoModel : NSObject
@property (nonatomic, assign) CGPoint circleCenterP;
@property (nonatomic, assign) CGFloat circleRadius;

@property (nonatomic, assign) CGFloat borderWidth;
@property (nonatomic, strong) UIColor *borderColor;

@end