//
//  UIButton+CWAdditions.m
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

#import "UIButton+CWAdditions.h"


@implementation UIButton (CWAdditions)

+(UIButton*)buttonWithType:(UIButtonType)type title:(NSString*)title target:(id)target action:(SEL)action;
{
	UIButton* button = [UIButton buttonWithType:type];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+(UIButton*)destructiveButtonTitle:(NSString*)title target:(id)target action:(SEL)action;
{
	UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom
                                          title:title
                                         target:target
                                         action:action];
	UIImage *deleteImage = [UIImage imageNamed:@"CWUIKitResources.bundle/delete_button.png"];
	deleteImage = [deleteImage stretchableImageWithLeftCapWidth:floorf((deleteImage.size.width -1)/2)  topCapHeight:floorf((deleteImage.size.height -1)/2)];
	[button setBackgroundImage:deleteImage forState:UIControlStateNormal];
	UIImage* highlightedImage = [UIImage imageNamed:@"CWUIKitResources.bundle/delete_button_highlighted.png"];
	highlightedImage = [highlightedImage stretchableImageWithLeftCapWidth:floorf((highlightedImage.size.width -1)/2)  topCapHeight:floorf((highlightedImage.size.height -1)/2)];
	[button setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
	button.titleLabel.shadowOffset = CGSizeMake(0, -1);
	button.titleLabel.font = [UIFont boldSystemFontOfSize:20.0];
	return button;
}

@end
