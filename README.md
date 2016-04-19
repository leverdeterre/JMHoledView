## My other works

[http://leverdeterre.github.io] (http://leverdeterre.github.io)


# JMHoledView
A view design to be filled with holes ...

## HoleView, holes methods
---------------------------------------------------
```objc
- (NSInteger)addHoleCircleCenteredOnPosition:(CGPoint)centerPoint andDiameter:(CGFloat)diamter;
- (NSInteger)addHoleRectOnRect:(CGRect)rect;
- (NSInteger)addHoleRoundedRectOnRect:(CGRect)rect withCornerRadius:(CGFloat)cornerRadius;
- (NSInteger)addHCustomView:(UIView *)customView onRect:(CGRect)rect;

- (void) addHoleCircleCenteredOnPosition:(CGPoint)centerPoint andDiameter:(CGFloat)diameter withText:(NSString *)text onPosition:(JMHolePosition)position withMargin:(CGFloat) margin;
- (void) addHoleRectOnRect:(CGRect)rect withText:(NSString *)text onPosition:(JMHolePosition)position withMargin:(CGFloat) margin;
- (void) addHoleRoundedRectOnRect:(CGRect)rect withCornerRadius:(CGFloat)cornerRadius withText:(NSString *)text onPosition:(JMHolePosition)position withMargin:(CGFloat) margin;
```


HoleView Delegation : JMHoledViewDelegate
---------------------------------------------------
This method will be called if you configure a holeViewDelegate.
The index is equal to NSNotFound if user touch dimingView.

```objc
- (void)holedView:(JMHoledView *)holedView didSelectHoleAtIndex:(NSUInteger)index;

```

![Image](./screenshots/demo1.png)


