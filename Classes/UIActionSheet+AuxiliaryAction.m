//
//  UIActionSheet+AuxiliaryAction.m
//  CWAuxiliaryActions
//
//  Created by Fredrik Olsson on 2011-04-12.
//  Copyright 2011 Jayway. All rights reserved.
//

#import "CWAuxiliaryAction.h"
#import <objc/runtime.h>

@interface CWActionSheedAuxiliaryActionsDelegate : NSObject <UIActionSheetDelegate> {
@private
	NSArray* _actions;
}

-(id)initWithAuxiliaryActions:(NSArray*)actions;

@end


@implementation UIActionSheet (AuxiliaryAction)

static void* actionKey = "auxiliaryActionsKey"; 
static void* dismissKey = "dismissHandlerKey"; 

-(CWAuxiliaryActionHandler)dismissHandler;
{
	return objc_getAssociatedObject(self, dismissKey);
}

-(void)setDismissHandler:(CWAuxiliaryActionHandler)handler;
{
	objc_setAssociatedObject(self, dismissKey, handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

+(UIActionSheet*)actionSheetWithAuxiliaryActions:(NSArray*)actions cancelButtonTitle:(NSString*)cancelTitle;
{
	UIActionSheet* sheet = [[[UIActionSheet alloc] init] autorelease];
    for (CWAuxiliaryAction* action in actions) {
        [sheet addButtonWithTitle:action.localizedTitle];
    }
    if (cancelTitle) {
	    NSInteger index = [sheet addButtonWithTitle:cancelTitle];
    	sheet.cancelButtonIndex = index;
    }
    CWActionSheedAuxiliaryActionsDelegate* delegate = [[[CWActionSheedAuxiliaryActionsDelegate alloc] initWithAuxiliaryActions:actions] autorelease];
    sheet.delegate = delegate;
    objc_setAssociatedObject(sheet, actionKey, delegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return sheet;
}

+(UIActionSheet*)actionSheetWithCancelButtonTitle:(NSString*)cancelTitle otherTitlesAndAuxiliaryActions:(NSString*)firstTitle, ...;
{
	NSMutableArray* actions = [NSMutableArray array];
    va_list vl;
    NSString* title = firstTitle;
    va_start(vl, firstTitle);
    while (title) {
    	CWAuxiliaryActionHandler handler = va_arg(vl, CWAuxiliaryActionHandler);
        [actions addObject:[CWAuxiliaryAction actionWithTitle:title handler:handler]];
        title = va_arg(vl, NSString*);
    }
    va_end(vl);
    return [self actionSheetWithAuxiliaryActions:actions cancelButtonTitle:cancelTitle];
}

@end


@implementation CWActionSheedAuxiliaryActionsDelegate

-(id)initWithAuxiliaryActions:(NSArray*)actions;
{
	self = [self init];
    if (self) {
    	_actions = [actions copy];
    }
    return self;
}

-(void)dealloc;
{
	[_actions release];
    [super dealloc];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;
{
	NSString* title = [actionSheet buttonTitleAtIndex:buttonIndex];
    for (CWAuxiliaryAction* action in _actions) {
    	if ([title isEqualToString:action.localizedTitle]) {
        	action.handler(action);
            return;
        }
    }
}

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex;
{
	CWAuxiliaryActionHandler handler = actionSheet.dismissHandler;
    if (handler) {
        NSString* title = [actionSheet buttonTitleAtIndex:buttonIndex];
        for (CWAuxiliaryAction* action in _actions) {
            if ([title isEqualToString:action.localizedTitle]) {
                handler(action);
                return;
            }
        }
        handler(nil);
    }
}

@end

