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

@class JMHoledView;
@protocol JMHoledViewDelegate <NSObject>

- (void)holedView:(JMHoledView *)holedView didSelectHoleAtIndex:(NSUInteger)index;

@end


@interface JMHoledView : UIView

@property (strong, nonatomic) UIColor *dimingColor;
@property (weak, nonatomic) id <JMHoledViewDelegate> holeViewDelegate;

- (NSInteger)addHoleCircleCenteredOnPosition:(CGPoint)centerPoint andDiameter:(CGFloat)diamter;
- (NSInteger)addHoleRectOnRect:(CGRect)rect;
- (NSInteger)addHoleRoundedRectOnRect:(CGRect)rect withCornerRadius:(CGFloat)cornerRadius;
- (NSInteger)addHCustomView:(UIView *)customView onRect:(CGRect)rect;

- (void)removeHoles;

@end
