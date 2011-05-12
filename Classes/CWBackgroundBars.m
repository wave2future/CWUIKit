//
//  CWBackgroundBars.m
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

#import "CWBackgroundBars.h"
#import <QuartzCore/QuartzCore.h>

@implementation CWBackgroundNavigationBar

@synthesize backgroundView = _backgroundView;

-(void)setBackgroundView:(UIView *)view;
{
	if (_backgroundView) {
    	[_backgroundView removeFromSuperview];
        [_backgroundView release];
    }
    _backgroundView = [view retain];
    if (_backgroundView) {
    	[self addSubview:view];
        [self setNeedsLayout];
    }
}

-(BOOL)isHiddenBackgroundView;
{
	return _hiddenBackgroundImage;
}

-(void)setHiddenBackgroundView:(BOOL)hidden;
{
	if (_hiddenBackgroundImage != hidden) {
    	_hiddenBackgroundImage = hidden;
        _backgroundView.hidden = hidden;
        [self setNeedsLayout];
    }
}

-(void)setHiddenBackgroundView:(BOOL)hidden animated:(BOOL)animated;
{
	if (animated) {
        [UIView animateWithDuration:0.2
                         animations:^{
                             _backgroundView.alpha = hidden ? 0 : 1;
                         }
                         completion:^(BOOL finished) {
                             _backgroundView.alpha = 1;
                             _backgroundView.hidden = hidden;
                         }];
    } else {
    	self.hiddenBackgroundView = hidden;
    }
}

-(void)dealloc;
{
	[_backgroundView release];
    [super dealloc];
}

-(void)layoutSubviews;
{
	[super layoutSubviews];
    if (!self.hiddenBackgroundView) {
    	[self sendSubviewToBack:_backgroundView];
    }
}


@end


@implementation CWBackgroundToolbar

@synthesize backgroundView = _backgroundView;

-(void)setBackgroundView:(UIView *)view;
{
	if (_backgroundView) {
    	[_backgroundView removeFromSuperview];
        [_backgroundView release];
    }
    _backgroundView = [view retain];
    if (_backgroundView) {
    	[self addSubview:view];
        [self setNeedsLayout];
    }
}

-(BOOL)isHiddenBackgroundView;
{
	return _hiddenBackgroundImage;
}

-(void)setHiddenBackgroundView:(BOOL)hidden;
{
	if (_hiddenBackgroundImage != hidden) {
    	_hiddenBackgroundImage = hidden;
        _backgroundView.hidden = hidden;
        [self setNeedsLayout];
    }
}

-(void)setHiddenBackgroundView:(BOOL)hidden animated:(BOOL)animated;
{
	if (animated) {
        [UIView animateWithDuration:0.2
                         animations:^{
                             _backgroundView.alpha = hidden ? 0 : 1;
                         }
                         completion:^(BOOL finished) {
                             _backgroundView.alpha = 1;
                             _backgroundView.hidden = hidden;
                         }];
    } else {
    	self.hiddenBackgroundView = hidden;
    }
}

-(void)dealloc;
{
	[_backgroundView release];
    [super dealloc];
}

-(void)layoutSubviews;
{
	[super layoutSubviews];
    if (!self.hiddenBackgroundView) {
    	[self sendSubviewToBack:_backgroundView];
    }
}

@end

