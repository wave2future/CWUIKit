//
//  CWCalloutView.h
//  CWUIKit
//  Created by Fredrik Olsson 
//
//  Copyright (c) 2011, Jayway AB All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of Jayway AB nor the names of its contributors may 
//       be used to endorse or promote products derived from this software 
//       without specific prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
//  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//  DISCLAIMED. IN NO EVENT SHALL JAYWAY AB BE LIABLE FOR ANY DIRECT, INDIRECT, 
//  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT 
//  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR 
//  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF 
//  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE 
//  OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF 
//  ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

#import <UIKit/UIKit.h>

/*!
 * @abstract Min size of a a callout view, default is 75x70px.
 * @discussion Must be at least min size of call out view image resources.
 */
extern CGSize CWCalloutViewMinimumSize;

/*!
 * @abstract You use the CWCalloutView to indicate more information originating from a point in the UI.
 *
 * @discussion The CWCalloutView looks like the call out view used in MKMapView, and API is similar to 
 *			   the private UICalloutView class.
 *
 *             Uses three image resources: calloutview_left.png, *_middle.png and *_right.png.
 *             Left and right must be stretchable in width, all three must be stretchable in height.
 */
@interface CWCalloutView : UIView {
@private
    UIView* _backgroundViews[3];
    UILabel* _titleLabel;
    UILabel* _subtitleLabel;
    UIView* _leftAccessoryView;
    UIView* _rightAccessoryView;
    BOOL _isAnimatingIn;
    BOOL _isAnimatingOut;
}

@property(nonatomic, copy) NSString* title;    //! Main title in large font.
@property(nonatomic, copy) NSString* subtitle; //! Subtitle in smaller font, optional.
@property(nonatomic, retain) UIView* leftAccessoryView;
@property(nonatomic, retain) UIView* rightAccessoryView;

/*!
 * @abstract Show the view with anchor point originating from a point in a view.
 *
 * @discussion The callout wiev will be added as a subview to the specified anchor view.
 *             Showing the same view twice will only move the view to the new anchor point.
 */
-(void)showFromAnchorPoint:(CGPoint)anchorPoint inView:(UIView*)view animated:(BOOL)animated;

/*!
 * @abstract Dismiss the callout view.
 *
 * @discussion The anchor view will be removed from it's superview.
 */
-(void)dismissAnimated:(BOOL)animated;

@end
