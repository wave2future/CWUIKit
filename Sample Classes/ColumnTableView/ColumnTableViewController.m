//
//  ColumnTableViewController.m
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

#import "ColumnTableViewController.h"


@implementation ColumnTableViewController


-(void)awakeFromNib;
{
	[super awakeFromNib];
	modelObjects = [[NSMutableArray alloc] initWithCapacity:2];
    modelObjects = [[NSMutableArray alloc] initWithObjects:
                    @"Fredrik:2008", @"Christian:2009", @"Alexander:2010", @"Ester:2010", 
                    @"Johan:2010", @"Birtukan:2010", @"David:2010", nil];
}

-(void)dealloc;
{
    [_columnTableView release];
    [super dealloc];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation;
{
	return YES;
}

-(void)loadView;
{
	_columnTableView = [[CWColumnTableView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)
                                                          style:UITableViewStyleGrouped];
	_columnTableView.minimumColumnWidth = 140;
    _columnTableView.dataSource = self;
    _columnTableView.delegate = self;
    self.view = _columnTableView;
}

-(void)viewDidUnload;
{
	[super viewDidUnload];
    [_columnTableView release], _columnTableView = nil;
}

#pragma mark --- Action

-(IBAction)addNewPerson:(id)sender;
{
	[modelObjects addObject:@"Sven:2011"];
    [_columnTableView insertPositionsAtIndexes:[NSIndexSet indexSetWithIndex:[modelObjects count] - 1]
                                      animated:YES];
}

-(IBAction)complexUpdate:(id)sender;
{
    [modelObjects replaceObjectAtIndex:0 withObject:@"Fredrik:updated"];
    [modelObjects replaceObjectAtIndex:2 withObject:@"Alexander:updated"];
	[modelObjects removeObjectAtIndex:4];
    [modelObjects removeObjectAtIndex:1];
    [modelObjects insertObject:@"Insert:1" atIndex:1];
    [modelObjects insertObject:@"Insert:3" atIndex:3];
    [modelObjects insertObject:@"Insert:5" atIndex:5];
	[_columnTableView beginUpdates];
    [_columnTableView deletePositionsAtIndexes:[NSIndexSet indexSetWithIndex:4] animated:YES];
    [_columnTableView reloadPositionsAtIndexes:[NSIndexSet indexSetWithIndex:0]];
    NSMutableIndexSet* inserts = [NSMutableIndexSet indexSetWithIndex:2];
    [inserts addIndex:5];
    [_columnTableView insertPositionsAtIndexes:inserts animated:YES];
	[_columnTableView beginUpdates];
    [_columnTableView deletePositionsAtIndexes:[NSIndexSet indexSetWithIndex:1] animated:YES];
    [_columnTableView reloadPositionsAtIndexes:[NSIndexSet indexSetWithIndex:2]];
	[_columnTableView endUpdates];
    [_columnTableView insertPositionsAtIndexes:[NSIndexSet indexSetWithIndex:1] animated:YES];
	[_columnTableView endUpdates];
}

#pragma mark --- CWColumnTableViewDataSource comformance

-(NSInteger)numberOfPositionsInColumnTableView:(CWColumnTableView *)columnTableView;
{
	return [modelObjects count];
}

-(CWColumnTableViewCell*)columnTableView:(CWColumnTableView *)columnTableView cellForPositionAtIndex:(int)index;
{
	static NSString* reuseID = @"reuseID";
    CWColumnTableViewCell* cell = [columnTableView dequeueReusableCellWithIdentifier:reuseID];
    if (!cell) {
    	cell = [[[CWColumnTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                             reuseIdentifier:reuseID] autorelease];
    }
    NSArray* item = [[modelObjects objectAtIndex:index] componentsSeparatedByString:@":"];
    cell.textLabel.text = [item objectAtIndex:0];
    cell.detailTextLabel.text = [item objectAtIndex:1];
    return cell;
}

-(BOOL)columnTableView:(CWColumnTableView *)columnTableView canMovePositionAtIndex:(int)index;
{
    // Allow all cells except the first to be moved.
	return index != 0;
}

-(void)columnTableView:(CWColumnTableView *)columnTableView movePositionAtIndex:(int)sourceIndex toIndex:(int)destIndex;
{
    // Update model when column table view tells you a move has been completed
	id item = [[modelObjects objectAtIndex:sourceIndex] retain];
    [modelObjects removeObjectAtIndex:sourceIndex];
    [modelObjects insertObject:item atIndex:destIndex];
    [item release];
}

#pragma mark --- CWColumnTableViewDelegate comformance
-(void)columnTableView:(CWColumnTableView *)columnTableView willDisplayCell:(CWColumnTableViewCell *)cell forPositionAtIndex:(NSInteger)index;
{
}

//-(UIView*)columnTableView:(CWColumnTableView*)columnTableView backgroundViewForRowAtIndex:(NSInteger)index;
//{
//	UIColor* backgroundColor = nil;
//	switch (index%5) {
//		case 0:
//			backgroundColor = [UIColor redColor];
//			break;
//		case 1:
//			backgroundColor = [UIColor greenColor];
//			break;
//		case 2:
//			backgroundColor = [UIColor blueColor];
//			break;
//		case 3:
//			backgroundColor = [UIColor yellowColor];
//			break;
//		case 4:
//			backgroundColor = [UIColor purpleColor];
//			break;
//
//		default:
//			backgroundColor = [UIColor whiteColor];
//			break;
//	}
//	UIView* backgroundView = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
//	backgroundView.backgroundColor = backgroundColor;
//	return backgroundView;
//}

-(void)columnTableView:(CWColumnTableView *)columnTableView didSelectPositionAtIndex:(int)index;
{
	[columnTableView deselectPositionAtIndex:index
                                    animated:YES];
}

-(NSInteger)columnTableView:(CWColumnTableView *)columnTableView targetIndexForMoveFromPositionAtIndex:(int)sourceIndex toProposedIndex:(int)proposedDestIndex;
{
    // Do not allow any cell to be moved into position 0.
	return MAX(1, proposedDestIndex);
}

@end
