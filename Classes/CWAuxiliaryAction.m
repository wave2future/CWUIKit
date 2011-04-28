//
//  CWAuxiliaryAction.m
//  eBokus
//
//  Created by Fredrik Olsson on 2011-03-10.
//  Copyright 2011 Jayway. All rights reserved.
//

#import "CWAuxiliaryAction.h"

@implementation CWAuxiliaryAction

@synthesize localizedTitle = _title;
@synthesize handler = _handler;
@synthesize tag = _tag;

+(id)actionWithTitle:(NSString*)title handler:(CWAuxiliaryActionHandler)handler;
{
	return [[[self alloc] initWithLocalizedTitle:title
                                         handler:handler] autorelease];    
}

+(id)actionWithTitle:(NSString*)title handler:(CWAuxiliaryActionHandler)handler tag:(NSInteger)tag;
{
	CWAuxiliaryAction* action = [self actionWithTitle:title handler:handler];
    action.tag = tag;
    return action;
}

-(id)initWithLocalizedTitle:(NSString*)title handler:(CWAuxiliaryActionHandler)handler;
{
	self = [self init];
    if (self) {
    	_title = [title copy];
        _handler = [handler copy];
    }
    return self;
}

-(void)dealloc;
{
	[_title release];
    [_handler release];
    [super dealloc];
}

@end
