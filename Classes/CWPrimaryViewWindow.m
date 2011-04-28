//
//  UIWindow+CWPrimaryView.m
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

#import "CWPrimaryViewWindow.h"

NSString* CWPrimaryCancelableViewWillCancelNotification = @"CWPrimaryCancelableViewWillCancelNotification";
NSString* CWPrimaryCancelableViewDidCancelNotification = @"CWPrimaryCancelableViewDidCancelNotification";

@implementation CWPrimaryViewWindow

@synthesize primaryCancelableView = _primaryView;

-(void)setPrimaryCancelableView:(UIView *)view;
{
	[_primaryView autorelease];
    _primaryView = [view retain];
    _willCancelOnTouchesEnded = NO;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
{
	[super touchesBegan:touches withEvent:event];
    if (_willCancelOnTouchesEnded) {
    	[[NSNotificationCenter defaultCenter] postNotificationName:CWPrimaryCancelableViewWillCancelNotification 
                                                            object:self];
    }
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;
{
    [super touchesCancelled:touches withEvent:event];
    if (_willCancelOnTouchesEnded) {
    	[[NSNotificationCenter defaultCenter] postNotificationName:CWPrimaryCancelableViewDidCancelNotification 
                                                            object:self];
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
{
	[super touchesEnded:touches withEvent:event];
    if (_willCancelOnTouchesEnded) {
    	[[NSNotificationCenter defaultCenter] postNotificationName:CWPrimaryCancelableViewDidCancelNotification object:self];
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event;
{
    // If the primary view is only owned by the window, then it must be removed.
    if ([_primaryView retainCount] == 1) {
    	self.primaryCancelableView = nil;
    }
	UIView* view = [super hitTest:point withEvent:event];
    if (self.primaryCancelableView) {
        if (view != self.primaryCancelableView) {
            _willCancelOnTouchesEnded = YES;
            view = self;
        }
    }
    return view;
}

@end
