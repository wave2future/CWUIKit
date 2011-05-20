//
//  CWSearchBar.h
//  CWUIKit
//  Created by David Arve 
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
#import "CWStyledSegmentedControl.h"

@protocol CWSearchBarDelegate;
@class CWTextField;

@interface CWSearchBar : UIView {
  @private
	CWTextField				*_searchField;
	UIButton				*_cancelButton;
	id<CWSearchBarDelegate>	_delegate;
	UIColor					*_tintColor;
	UIImageView				*_searchBarImageView;
}

@property(nonatomic,assign) IBOutlet id<CWSearchBarDelegate> delegate;
@property(nonatomic,copy)   NSString *text; // current/starting search text
@property(nonatomic,retain) UIColor *tintColor;		// default is nil
@property(nonatomic,copy)   NSString *placeholder;	// default is nil
@property(nonatomic,retain) UIButton *cancelButton; 
@property(nonatomic,retain, readonly) CWStyledSegmentedControl* scopeSegmentedControl;
@property(nonatomic)        BOOL showsCancelButton;	// default is NO
- (void)setShowsCancelButton:(BOOL)showsCancelButton animated:(BOOL)animated;

@end

@protocol CWSearchBarDelegate <NSObject>

@optional
- (BOOL)searchBarShouldBeginEditing:(CWSearchBar *)searchBar; // return NO to not become first responder
- (void)searchBarTextDidBeginEditing:(CWSearchBar *)searchBar; // called when text starts editing
- (BOOL)searchBarShouldEndEditing:(CWSearchBar *)searchBar; // return NO to not resign first responder
- (void)searchBarTextDidEndEditing:(CWSearchBar *)searchBar; // called when text ends editing
- (void)searchBar:(CWSearchBar *)searchBar textDidChange:(NSString *)searchText; // called when text changes (including clear)

- (void)searchBarSearchButtonClicked:(CWSearchBar *)searchBar; // called when keyboard search button pressed
- (void)searchBarCancelButtonClicked:(CWSearchBar *)searchBar; // called when cancel button pressed

@end

