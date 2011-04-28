//
//  UIWindow+CWPrimaryView.h
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
//     * Neither the name of the Jayway nor the names of its contributors may 
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
 * @abstract Posted when the user touch down outside the primary cancelable view.
 */
extern NSString* CWPrimaryCancelableViewWillCancelNotification;

/*!
 * @abstract Posted when the user touch up outside the primary cancelable view.
 */
extern NSString* CWPrimaryCancelableViewDidCancelNotification;

/*!
 * @abstract The CWPrimaryViewWindow class is a subclass of UIWindow that can
 *           tracking of a single cancellable view.
 *
 * @discussion The primary view is similar to the Delete confirmation button for
 *             UITableView, or purchase button in Apple's stores. Eg. tapping the 
 *             primary view works as normal, while any tap outside of the primary
 *             button is treated as a cancel action.
 *
 *             Usage: 1. Register for notifications for at least CWPrimaryCancelableViewDidCancelNotification.
 *                    2. Setup the primary view by setting the view as the primaryCancelableView property.
 *                    3. Client MUST remove the primaryCancelableView on cancel notifictaion.
 */
@interface CWPrimaryViewWindow : UIWindow {
@private
    UIView* _primaryView;
    BOOL _willCancelOnTouchesEnded;
}

/*!
 * @abstract The currennt primary view. Only this view will receive events.
 *
 * @discussion Set to nil when done, AND when CWPrimaryCancelableViewDidCancelNotification is posted.
 */
@property(nonatomic, retain) UIView* primaryCancelableView;

@end
