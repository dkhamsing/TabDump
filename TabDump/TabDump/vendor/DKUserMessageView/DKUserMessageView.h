//
//  DKUserMessageView.h
//
//  Created by dkhamsing on 4/17/14.
// https://github.com/dkhamsing/DKMessageView
//

#import <UIKit/UIKit.h>

@class RTSpinKitView;
@interface DKUserMessageView : UIView

/**
 Access the user message label to customize.
*/
@property (nonatomic,strong) UILabel *dk_userMessageLabel;


/**
 The top position (y-coordinate) of the user message label. 
 */
@property (nonatomic) CGFloat dk_userMessageLabelTop;


/**
 Access the loading spinner to customize. The default style is `UIActivityIndicatorViewStyleGray`.
 */
//@property (nonatomic,strong) UIActivityIndicatorView *dk_spinner;
@property (nonatomic, strong) RTSpinKitView *dk_spinner;

#pragma mark Methods

/**
 Displays message on the receiver.
 @param message Message to display.
 */
- (void)dk_displayMessage:(NSString*)message;


/**
 Displays the text `Loading` on the receiver.
 @param loading Boolean that determines whether the message view or spinner are hidden (if YES, the view is shown).
 @param spinner Boolean that determines whether the spinner is displayed.
 */
- (void)dk_loading:(BOOL)loading;
- (void)dk_loading:(BOOL)loading spinner:(BOOL)spinner;


@end
