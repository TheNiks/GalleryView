//
//  ViewController.m
//  ImageGrid
//
//  Created by Nikunj Modi on 9/21/15.
//  Copyright (c) 2015 Nikunj Modi. All rights reserved.
//

#import "ViewController.h"
#import "NkContainerCellView.h"
#import "NKContainerCellTableViewCell.h"

@interface ViewController ()
@property (weak, nonatomic)IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *sampleData;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.sampleData = @[ @{ @"description": @"2016-06-14",
                            @"Blocks": @[ @{ @"title": @"Block A1",@"image":@"0.png" },
                                          @{ @"title": @"Block A2",@"image":@"1.png" },
                                          @{ @"title": @"Block A3",@"image":@"3.png" },
                                          @{ @"title": @"Block A4",@"image":@"4.png" },
                                          @{ @"title": @"Block A5",@"image":@"5.png" },
                                          @{ @"title": @"Block A6",@"image":@"6.png" },
                                          @{ @"title": @"Block A7",@"image":@"7.png" },
                                          @{ @"title": @"Block A8",@"image":@"8.png" },
                                          @{ @"title": @"Block A9",@"image":@"9.png" },
                                          @{ @"title": @"Block A10",@"image":@"10.png" }
                                          ]
                            },
                         @{ @"description": @"2016-06-21",
                            @"Blocks": @[ @{ @"title": @"Block B1",@"image":@"11.png" },
                                          @{ @"title": @"Block B2",@"image":@"12.png" },
                                          @{ @"title": @"Block B3",@"image":@"13.png" },
                                          @{ @"title": @"Block B4",@"image":@"14.png" },
                                          @{ @"title": @"Block B5",@"image":@"15.png" }
                                          ]
                            },
                         @{ @"description": @"2015-09-30",
                            @"Blocks": @[ @{ @"title": @"Block C1",@"image":@"0.png" },
                                          @{ @"title": @"Block C2",@"image":@"2.png" },
                                          @{ @"title": @"Block C3",@"image":@"4.png" },
                                          @{ @"title": @"Block C4",@"image":@"6.png" },
                                          @{ @"title": @"Block C5",@"image":@"8.png" }
                                          ]
                            },
                         @{ @"description": @"2016-01-19",
                            @"Blocks": @[ @{ @"title": @"Block D1",@"image":@"13.png" },
                                          @{ @"title": @"Block D2",@"image":@"4.png" },
                                          @{ @"title": @"Block D3",@"image":@"7.png" },
                                          @{ @"title": @"Block D4",@"image":@"9.png" },
                                          @{ @"title": @"Block D5",@"image":@"10.png" }
                                          ]
                            },
                         @{ @"description": @"2015-11-02",
                            @"Blocks": @[ @{ @"title": @"Block E1",@"image":@"9.png" },
                                          @{ @"title": @"Block E2",@"image":@"11.png" },
                                          @{ @"title": @"Block E3",@"image":@"17.png" },
                                          @{ @"title": @"Block E4",@"image":@"15.png" },
                                          @{ @"title": @"Block E5",@"image":@"1.png" }
                                          ]
                            },
                         @{ @"description": @"2015-09-25",
                            @"Blocks": @[ @{ @"title": @"Block F1",@"image":@"17.png" },
                                          @{ @"title": @"Block F2",@"image":@"16.png" },
                                          @{ @"title": @"Block F3",@"image":@"1.png" },
                                          @{ @"title": @"Block F4",@"image":@"5.png" },
                                          @{ @"title": @"Block F5",@"image":@"8.png" }
                                          ]
                            },
                         ];
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"description" ascending:YES];
    NSArray *descriptors = [NSArray arrayWithObject:descriptor];
    arrayChronologicalOrder = [self.sampleData sortedArrayUsingDescriptors:descriptors];
    
    // Add observer that will allow the nested collection cell to trigger the view controller select row at index path
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelectItemFromCollectionView:) name:@"didSelectItemFromCollectionView" object:nil];
}
#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [arrayChronologicalOrder count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"NKContainerCellTableViewCell%ld",indexPath.section];
    NKContainerCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (nil == cell) {
        cell = [[NKContainerCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                   reuseIdentifier:CellIdentifier];
        NSDictionary *cellData = [arrayChronologicalOrder objectAtIndex:[indexPath section]];
        NSArray *BlockData = [cellData objectForKey:@"Blocks"];
        [cell setCollectionData:BlockData];
    }
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark UITableViewDelegate methods

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSDictionary *sectionData = [arrayChronologicalOrder objectAtIndex:section];
    NSString *header = [sectionData objectForKey:@"description"];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 132.0;
}

#pragma mark - NSNotification to select table cell

- (void) didSelectItemFromCollectionView:(NSNotification *)notification
{
    NSDictionary *cellData = [notification object];
    NSLog(@"Data:-->%@",cellData);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
