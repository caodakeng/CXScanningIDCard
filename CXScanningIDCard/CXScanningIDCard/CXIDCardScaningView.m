//
//  CXIDCardScaningView.m
//  CXScanningIDCard
//
//  Created by 曹翔 on 2019/8/1.
//  Copyright © 2019 CX. All rights reserved.
//

#import "CXIDCardScaningView.h"

#define kScale     [UIScreen mainScreen].scale

@interface CXIDCardScaningView (){
    CAShapeLayer *_IDCardScaningWindowLayer;
    NSTimer      *_timer;
}

@end

@implementation CXIDCardScaningView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self initSubViews];
        [self addTimer];
    }
    return self;
}

-(void)initSubViews{
    _IDCardScaningWindowLayer = [CAShapeLayer layer];
    _IDCardScaningWindowLayer.position = self.layer.position;
    CGFloat width = kScale==2?270:300;
    _IDCardScaningWindowLayer.bounds = (CGRect){CGPointZero,{width ,width*1.574}};
    _IDCardScaningWindowLayer.cornerRadius = 15;
    _IDCardScaningWindowLayer.borderColor = [UIColor whiteColor].CGColor;
    _IDCardScaningWindowLayer.borderWidth = 1.5;
    [self.layer addSublayer:_IDCardScaningWindowLayer];
    
    //最里层镂空
    UIBezierPath *transparentRoundedRectPath = [UIBezierPath bezierPathWithRoundedRect:_IDCardScaningWindowLayer.frame cornerRadius:_IDCardScaningWindowLayer.cornerRadius];
    
    //最外层背景
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.frame];
    [path appendPath:transparentRoundedRectPath];
    [path setUsesEvenOddFillRule:YES];
    
    CAShapeLayer *fillLayer = [CAShapeLayer layer];
    fillLayer.path = path.CGPath;
    fillLayer.fillRule = kCAFillRuleEvenOdd;
    fillLayer.fillColor = [UIColor blackColor].CGColor;
    fillLayer.opacity = 0.6;
    [self.layer addSublayer:fillLayer];
    
    CGFloat facePathWidth = kScale==2?150:180;
    CGFloat facePathHeight = facePathWidth * 0.812;
    CGRect rect = _IDCardScaningWindowLayer.frame;
    self.facePathRect = (CGRect){CGRectGetMaxX(rect)-facePathWidth-35,CGRectGetMaxY(rect) - facePathHeight-25,facePathWidth,facePathHeight};
    
    //提示标签
    CGPoint center = self.center;
    center.x = CGRectGetMaxX(_IDCardScaningWindowLayer.frame)+20;
    [self addTipLabelWithText:@"将身份证人像面置于此区域内，头像对准，扫描" center:center];
    
    //人像
    UIImageView *headImg = [[UIImageView alloc] initWithFrame:_facePathRect];
    headImg.image = [UIImage imageNamed:@"idcard_first_head"];
    headImg.transform = CGAffineTransformMakeRotation(M_PI * 0.5);
    headImg.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:headImg];
    
}

-(void)addTipLabelWithText:(NSString *)text center:(CGPoint)center {
    UILabel *tipLabel = [UILabel new];
    
    tipLabel.text = text;
    tipLabel.textColor = [UIColor whiteColor];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.transform = CGAffineTransformMakeRotation(M_PI * 0.5);
    [tipLabel sizeToFit];
    tipLabel.center = center;
    [self addSubview:tipLabel];
}

-(void)addTimer{
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(timerFire) userInfo:nil repeats:YES];
    [_timer fire];
}

-(void)timerFire{
    [self setNeedsDisplay];
}

-(void)dealloc{
    [_timer invalidate];
}

-(void)drawRect:(CGRect)rect{
    rect = _IDCardScaningWindowLayer.frame;
    
    //人像提示框
    UIBezierPath *facePath = [UIBezierPath bezierPathWithRect:_facePathRect];
    facePath.lineWidth = 1.5;
    [[UIColor whiteColor] set];
    [facePath stroke];
    
    //水平扫描线
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    static CGFloat moveX = 0;
    static CGFloat distanceX = 0;
    
    CGContextBeginPath(context);
    CGContextSetLineWidth(context, 2);
    CGContextSetRGBStrokeColor(context, 0.3, 0.8, 0.3, 0.8);
    CGPoint p1 , p2;//p1 p2连成水平扫描线
    
    moveX += distanceX;
    if (moveX >= CGRectGetWidth(rect) - 2) {
        distanceX = -2;
    } else if (moveX <= 2) {
        distanceX =  2;
    }
    
    p1 = CGPointMake(CGRectGetMaxX(rect) - moveX, rect.origin.y);
    p2 = CGPointMake(CGRectGetMaxX(rect) - moveX, rect.origin.y + rect.size.height);
    
    CGContextMoveToPoint(context, p1.x, p1.y);
    CGContextAddLineToPoint(context, p2.x, p2.y);
    
    CGContextStrokePath(context);
}

@end
