//
//  CutoutMaskView.m
//  MaskDemo
//
//  Created by dingxin on 16/1/13.
//  Copyright © 2016年 dingxin. All rights reserved.
//

#import "CutoutMaskView.h"
#import <QuartzCore/QuartzCore.h>

@implementation CutoutMaskView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        
        _circleDatasAry = [[NSMutableArray alloc] init];
    }
    
    return self;
}

-(void)setCutoutCirCle:(CGPoint)center andRadius:(CGFloat)theRadius
{
//    _circleCenterP = center;
//    _circleRadius = theRadius;
    
    CircleInfoModel *infoM = [[CircleInfoModel alloc] init];
    infoM.circleCenterP = center;
    infoM.circleRadius = theRadius;
    infoM.borderWidth = 4.0;
    infoM.borderColor = [UIColor colorWithWhite:1 alpha:0.3];
    
    [self setCutoutCirCles:@[infoM]];
}

-(void)setCutoutCirCles:(NSArray *)circlesAry
{
    [_circleDatasAry removeAllObjects];
    [_circleDatasAry addObjectsFromArray:circlesAry];
    
    [self setNeedsLayout];
    [self setNeedsDisplay];
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self refreshMaskLayer];
}


-(void)refreshMaskLayer
{
    if (!_shapeMaskLayer) {
        _shapeMaskLayer = [CAShapeLayer layer];
    }
    [_shapeMaskLayer removeFromSuperlayer];
    
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.bounds];
    
    for (int i = 0; i<[_circleDatasAry count]; i++) {
        CircleInfoModel *infoM = [_circleDatasAry objectAtIndex:i];
        
        // MARK: circlePath
        [path appendPath:[UIBezierPath bezierPathWithArcCenter:infoM.circleCenterP radius:infoM.circleRadius startAngle:0 endAngle:2*M_PI clockwise:NO]];
    }

    _shapeMaskLayer.path = path.CGPath;
    
    self.layer.mask = _shapeMaskLayer;
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    
    //画圆滑
    BOOL needDrawBorder = NO;
    for (CircleInfoModel *infoM in _circleDatasAry) {
        if (infoM.borderWidth>0) {
            needDrawBorder = YES;
            break;
        }
    }
    
    if (needDrawBorder) {
        //--->画圆环
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        for (int i = 0; i<[_circleDatasAry count]; i++) {
            CircleInfoModel *infoM = [_circleDatasAry objectAtIndex:i];
            
            if (infoM.borderWidth >0) {
                /*画圆*/
                //边框圆
//                CGContextSetRGBStrokeColor(context,1,1,1,1.0);//画笔线的颜色  
                CGContextSetStrokeColorWithColor(context, infoM.borderColor.CGColor); //画笔线的颜色
                CGContextSetLineWidth(context, infoM.borderWidth);//线的宽度
                //void CGContextAddArc(CGContextRef c,CGFloat x, CGFloat y,CGFloat radius,CGFloat startAngle,CGFloat endAngle, int clockwise)1弧度＝180°/π （≈57.3°） 度＝弧度×180°/π 360°＝360×π/180 ＝2π 弧度
                // x,y为圆点坐标，radius半径，startAngle为开始的弧度，endAngle为 结束的弧度，clockwise 0为顺时针，1为逆时针。
                CGContextAddArc(context, infoM.circleCenterP.x, infoM.circleCenterP.y, infoM.circleRadius+infoM.borderWidth/2, 0, 2*M_PI, NO); //添加一个圆
                CGContextDrawPath(context, kCGPathStroke); //绘制路径
            }
        }
    }
}


@end

@implementation CircleInfoModel


@end
