//
//  UIView+DK.h
//
//  Created by dkhamsing on 1/25/14.
//
//

#import <UIKit/UIKit.h>

@interface UIView (DK)

/**
 Add a separator view (usually a line).
 @param controller Receiver to add separator to.
 @param yOrigin Y-coordinate of the separator.
 @param color Color of the separator
 @param borderSize Size of the separator.
 */
+ (void)dk_addLineViewToViewController:(UIViewController*)controller yCoordinate:(CGFloat)yCoordinate color:(UIColor*)color lineHeight:(CGFloat)lineHeight;


/**
 Add a 1 pixel black border to the receiver.
 */
- (void)dk_addBorder;


/**
 Add a border of given `color` and `width` to the receiver.
 @param color Color of border
 @param width Width in pixels of border
 */
- (void)dk_addBorderWithColor:(UIColor*)color width:(CGFloat)width;


/**
 Add a 1 pixel black border at the bottom of the receiver.
 */
- (void)dk_addBottomBorder;


/**
 Add a border at the bottom of the receiver with the given `color` and `width`.
 @param color Color of border
 @param width Width in pixels of border
 */
- (void)dk_addBottomBorderWithColor:(UIColor*)color width:(CGFloat)width;


/**
 Add a border at the top of the receiver with the given `color` and `width`.
 @param color Color of border
 @param width Width in pixels of border
 */
- (void)dk_addTopBorderWithColor:(UIColor*)color width:(CGFloat)width;


/**
 Add list of views as subviews to a view.
 @param subViews List of views.
 @param view View to add subviews to.
 @param
 */
+ (void)dk_addSubviews:(NSArray*)subviews onView:(UIView*)view;


/**
 Add a default shadow to receiver.
 */
- (void)dk_addShadow ;


/**
 Add a shadow to the receiver for the given `color`, `offset`, `radius` and `opacity`.
 @param color Shadow color
 @param offset Shadow offset size
 @param radius Shadow radius value
 @param opacity Shadow opacity value
 */
- (void)dk_addShadowWithColor:(UIColor*)color offset:(CGSize)offset radius:(CGFloat)radius opacity:(CGFloat)opacity;


/**
 Center a view horizontally on the receiver.
 */
- (void)dk_centerHorizontally:(UIView*)view;


/**
 Center a view vertically on the receiver. 
 */
- (void)dk_centerVertically:(UIView*)view;


/**
 Add a 1 pixel red border to the receiver.
 Credits: @irace 
 */
- (void)dk_debug;


/**
 Fade in the receiver (sets initial alpha to zero).
 @param alpha alpha
 @param duration How long to animate the view
 */
- (void)dk_fadeInWithAlpha:(CGFloat)alpha duration:(CGFloat)duration;


/**
 Fade out the receiver.
 @param alpha alpha
 @param duration How long to animate the view
 */
- (void)dk_fadeOutWithAlpha:(CGFloat)alpha duration:(CGFloat)duration;


/**
 Returns an array of the receiver's superviews.
 The immediate super view is the first object in the array. The outer most super view is the last object in the array. 
 Credit: https://github.com/soffes
 @return An array of view objects containing the receiver
 */
- (NSArray *)dk_superviews;


/**
 Returns the first super view of a given class.
 If a super view is not found for the given `superviewClass`, `nil` is returned.
 Credit: https://github.com/soffes
 @param superviewClass A class to search the `superviews` for
 @return A view object or `nil`
 */
- (id)dk_firstSuperviewOfClass:(Class)superviewClass;


/**
 Make the receiver into a circle.
 */
- (void)dk_styleCircle;


/**
 Get the view controller for the receiver.
 */
// TODO: example in demo
- (UIViewController *)dk_viewController;


#pragma mark - Frame

// Credit: https://github.com/yackle

@property (nonatomic) CGFloat dk_top;
@property (nonatomic) CGFloat dk_bottom;
@property (nonatomic) CGFloat dk_right;
@property (nonatomic) CGFloat dk_left;
@property (nonatomic) CGFloat dk_width;
@property (nonatomic) CGFloat dk_height;


@end
