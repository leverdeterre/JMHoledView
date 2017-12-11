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

@optional
- (void)holedView:(JMHoledView *)holedView didSelectHoleAtIndex:(NSUInteger)index;
- (void)holedView:(JMHoledView *)holedView willAddLabel:(UILabel*)label atIndex:(NSUInteger)index;

@end


@interface JMHoledView : UIView

@property (strong, nonatomic) UIColor *dimingColor;
@property (weak, nonatomic) id <JMHoledViewDelegate> holeViewDelegate;
@property (strong, nonatomic) UIFont *textFont;

- (NSInteger)addHoleCircleCenteredOnPosition:(CGPoint)centerPoint
                                    diameter:(CGFloat)diamter;

- (NSInteger)addHoleCircleCenteredOnPosition:(CGPoint)centerPoint
                                    diameter:(CGFloat)diameter
                                      hScale:(CGFloat)hScale;

- (NSInteger)addHoleRectOnRect:(CGRect)rect;

- (NSInteger)addHoleRoundedRectOnRect:(CGRect)rect
                         cornerRadius:(CGFloat)cornerRadius;

- (NSInteger)addHCustomView:(UIView *)customView onRect:(CGRect)rect;

- (void)addHoleCircleCenteredOnPosition:(CGPoint)centerPoint
                               diameter:(CGFloat)diameter
                                   text:(NSString *)text
                             onPosition:(JMHolePosition)position
                                 margin:(CGFloat)margin;

- (void)addHoleRectOnRect:(CGRect)rect
                     text:(NSString *)text
               onPosition:(JMHolePosition)position
                   margin:(CGFloat)margin;

- (void)addHoleRoundedRectOnRect:(CGRect)rect
                    cornerRadius:(CGFloat)cornerRadius
                            text:(NSString *)text
                      onPosition:(JMHolePosition)position
                          margin:(CGFloat)margin;

- (void)addHoleRoundedRectOnRect:(CGRect)rect
                    cornerRadius:(CGFloat)cornerRadius
                            attributedText:(NSAttributedString *)text
                      onPosition:(JMHolePosition)position
                          margin:(CGFloat)margin;

- (void)removeHoles;

@end
