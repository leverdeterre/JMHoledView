//
//  JMHoledView.m
//  JMHoledView
//
//  Created by jerome morissard on 01/02/2015.
//  Copyright (c) 2015 Jerome Morissard. All rights reserved.
//

#import "JMHoledView.h"

#pragma mark - holes objects

@interface JMHole : NSObject
@property (assign) JMHoleType holeType;
@end

@implementation JMHole
@end

@interface JMCircleHole : JMHole
@property (assign) CGPoint holeCenterPoint;
@property (assign) CGFloat holeDiameter;
@end

@implementation JMCircleHole
@end

@interface JMRectHole : JMHole
@property (assign) CGRect holeRect;
@end

@implementation JMRectHole
@end

@interface JMRoundedRectHole : JMRectHole
@property (assign) CGFloat holeCornerRadius;
@end

@implementation JMRoundedRectHole
@end

@interface JMCustomRectHole : JMRectHole
@property (strong) UIView *customView;
@end

@implementation JMCustomRectHole
@end

@interface JMHoledView ()
@property (strong, nonatomic) NSMutableArray *holes;  //Array of JMHole
@end

@implementation JMHoledView

#pragma mark - LifeCycle

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    _holes = [NSMutableArray new];
    self.backgroundColor = [UIColor clearColor];
    _dimingColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureDetectedForGesture:)];
    [self addGestureRecognizer:tapGesture];
}

- (void)drawRect:(CGRect)rect
{
    [self removeCustomViews];
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (context == nil) {
        return;
    }
    
    [self.dimingColor setFill];
    UIRectFill(rect);
    
    for (JMHole* hole in self.holes) {
        
        [[UIColor clearColor] setFill];
        
        if (hole.holeType == JMHoleTypeRoundedRect) {
            JMRoundedRectHole *rectHole = (JMRoundedRectHole *)hole;
            CGRect holeRectIntersection = CGRectIntersection( rectHole.holeRect, self.frame);
            UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:holeRectIntersection
                                                                  cornerRadius:rectHole.holeCornerRadius];
            
            CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(), [[UIColor clearColor] CGColor]);
            CGContextAddPath(UIGraphicsGetCurrentContext(), bezierPath.CGPath);
            CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeClear);
            CGContextFillPath(UIGraphicsGetCurrentContext());
            
        } else if (hole.holeType == JMHoleTypeRect) {
            JMRectHole *rectHole = (JMRectHole *)hole;
            CGRect holeRectIntersection = CGRectIntersection( rectHole.holeRect, self.frame);
            UIRectFill( holeRectIntersection );
            
        } else if (hole.holeType == JMHoleTypeCirle) {
            JMCircleHole *circleHole = (JMCircleHole *)hole;
            CGRect rectInView = CGRectMake(floorf(circleHole.holeCenterPoint.x - circleHole.holeDiameter*0.5f),
                                           floorf(circleHole.holeCenterPoint.y - circleHole.holeDiameter*0.5f),
                                           circleHole.holeDiameter,
                                           circleHole.holeDiameter);
            CGContextSetFillColorWithColor( context, [UIColor clearColor].CGColor );
            CGContextSetBlendMode(context, kCGBlendModeClear);
            CGContextFillEllipseInRect( context, rectInView );
        }
    }
    
    [self addCustomViews];
}

#pragma mark - Add methods

- (NSInteger)addHoleCircleCenteredOnPosition:(CGPoint)centerPoint andDiameter:(CGFloat)diameter
{
    JMCircleHole *circleHole = [JMCircleHole new];
    circleHole.holeCenterPoint = centerPoint;
    circleHole.holeDiameter = diameter;
    circleHole.holeType = JMHoleTypeCirle;
    [self.holes addObject:circleHole];
    [self setNeedsDisplay];
    
    return [self.holes indexOfObject:circleHole];
}

- (NSInteger)addHoleRectOnRect:(CGRect)rect
{
    JMRectHole *rectHole = [JMRectHole new];
    rectHole.holeRect = rect;
    rectHole.holeType = JMHoleTypeRect;
    [self.holes addObject:rectHole];
    [self setNeedsDisplay];
    
    return [self.holes indexOfObject:rectHole];
}

- (NSInteger)addHoleRoundedRectOnRect:(CGRect)rect withCornerRadius:(CGFloat)cornerRadius
{
    JMRoundedRectHole *rectHole = [JMRoundedRectHole new];
    rectHole.holeRect = rect;
    rectHole.holeCornerRadius = cornerRadius;
    rectHole.holeType = JMHoleTypeRoundedRect;
    [self.holes addObject:rectHole];
    [self setNeedsDisplay];
    
    return [self.holes indexOfObject:rectHole];
}

- (NSInteger)addHCustomView:(UIView *)customView onRect:(CGRect)rect
{
    JMCustomRectHole *customHole = [JMCustomRectHole new];
    customHole.holeRect = rect;
    customHole.customView = customView;
    customHole.holeType = JMHoleTypeCustomRect;
    [self.holes addObject:customHole];
    [self setNeedsDisplay];
    
    return [self.holes indexOfObject:customHole];
}

- (void)removeHoles
{
    [self removeCustomViews];
    [self.holes removeAllObjects];
    [self setNeedsDisplay];
}

#pragma mark - Overided setter

- (void)setDimingColor:(UIColor *)dimingColor
{
    _dimingColor = dimingColor;
    [self setNeedsDisplay];
}

#pragma mark - Tap Gesture

- (void)tapGestureDetectedForGesture:(UITapGestureRecognizer *)gesture
{
    if ([self.holeViewDelegate respondsToSelector:@selector(holedView:didSelectHoleAtIndex:)]) {
        CGPoint touchLocation = [gesture locationInView:self];
        [self.holeViewDelegate holedView:self didSelectHoleAtIndex:[self holeViewIndexForAtPoint:touchLocation]];
    }
}

- (NSUInteger)holeViewIndexForAtPoint:(CGPoint)touchLocation
{    
    __block NSUInteger idxToReturn = NSNotFound;
    [self.holes enumerateObjectsUsingBlock:^(JMHole *hole, NSUInteger idx, BOOL *stop) {
        if (hole.holeType == JMHoleTypeRoundedRect ||
            hole.holeType == JMHoleTypeRect ||
            hole.holeType == JMHoleTypeCustomRect) {
            JMRectHole *rectHole = (JMRectHole *)hole;
            if (CGRectContainsPoint(rectHole.holeRect, touchLocation)) {
                idxToReturn = idx;
                *stop = YES;
            }
            
        } else if (hole.holeType == JMHoleTypeCirle) {
            JMCircleHole *circleHole = (JMCircleHole *)hole;
            CGRect rectInView = CGRectMake(floorf(circleHole.holeCenterPoint.x - circleHole.holeDiameter*0.5f),
                                           floorf(circleHole.holeCenterPoint.x - circleHole.holeDiameter*0.5f),
                                           circleHole.holeDiameter,
                                           circleHole.holeDiameter);
            if (CGRectContainsPoint(rectInView, touchLocation)) {
                idxToReturn = idx;
                *stop = YES;
            }
        }
    }];
    
    return idxToReturn;
}

#pragma mark - Custom Views

- (void)removeCustomViews
{
    [self.holes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[JMCustomRectHole class]]) {
            JMCustomRectHole *hole = (JMCustomRectHole *)obj;
            [hole.customView removeFromSuperview];
        }
    }];
}

- (void)addCustomViews
{
    [self.holes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[JMCustomRectHole class]]) {
            JMCustomRectHole *hole = (JMCustomRectHole *)obj;
            [hole.customView setFrame:hole.holeRect];
            [self addSubview:hole.customView];
        }
    }];
}

@end
