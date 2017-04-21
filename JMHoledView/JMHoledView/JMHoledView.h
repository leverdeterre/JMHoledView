//
//  JMHoledView.h
//  JMHoledView
//
//  Created by jerome morissard on 01/02/2015.
//  Copyright (c) 2015 Jerome Morissard. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, JMHoleType)
{
    JMHoleTypeCirle,
    JMHoleTypeRect,
    JMHoleTypeRoundedRect,
    JMHoleTypeCustomRect
};
typedef NS_ENUM(NSInteger, JMHolePosition)
{
    JMPositionTop,
    JMPositionTopRightCorner,
    JMPositionRight,
    JMPositionBottomRightCorner,
    JMPositionBottom,
    JMPositionBottomLeftCorner,
    JMPositionLeft,
    JMPositionTopLeftCorner
};

@class JMHoledView;
@protocol JMHoledViewDelegate <NSObject>

- (void)holedView:(JMHoledView *)holedView didSelectHoleAtIndex:(NSUInteger)index;

@end


@interface JMHoledView : UIView

@property (strong, nonatomic) UIColor *dimingColor;
@property (weak, nonatomic) id <JMHoledViewDelegate> holeViewDelegate;

- (NSInteger)addHoleCircleCenteredOnPosition:(CGPoint)centerPoint andDiameter:(CGFloat)diamter;
- (NSInteger)addHoleCircleCenteredOnPosition:(CGPoint)centerPoint andDiameter:(CGFloat)diameter WithHScale:(CGFloat)hScale;
- (NSInteger)addHoleRectOnRect:(CGRect)rect;
- (NSInteger)addHoleRoundedRectOnRect:(CGRect)rect withCornerRadius:(CGFloat)cornerRadius;
- (NSInteger)addHCustomView:(UIView *)customView onRect:(CGRect)rect;

- (void) addHoleCircleCenteredOnPosition:(CGPoint)centerPoint andDiameter:(CGFloat)diameter withText:(NSString *)text onPosition:(JMHolePosition)position withMargin:(CGFloat) margin;
- (void) addHoleRectOnRect:(CGRect)rect withText:(NSString *)text onPosition:(JMHolePosition)position withMargin:(CGFloat) margin;
- (void) addHoleRoundedRectOnRect:(CGRect)rect withCornerRadius:(CGFloat)cornerRadius withText:(NSString *)text onPosition:(JMHolePosition)position withMargin:(CGFloat) margin;


- (void)removeHoles;

@end
