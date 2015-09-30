//
//  NkContainerCellView.m
//  ImageGrid
//
//  Created by Nikunj Modi on 9/21/15.
//  Copyright (c) 2015 Nikunj Modi. All rights reserved.
//

#import "NkContainerCellView.h"
#import "NKArticleCollectionViewCell.h"
#import <QuartzCore/QuartzCore.h>

@interface NkContainerCellView () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *collectionData;
@end
@implementation NkContainerCellView

- (void)awakeFromNib {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.itemSize = CGSizeMake(101.0, 122.0);
    [self.collectionView setCollectionViewLayout:flowLayout];
    
    // Register the colleciton cell
    [_collectionView registerNib:[UINib nibWithNibName:@"NKArticleCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"NKArticleCollectionViewCell"];
    
}

#pragma mark - Getter/Setter overrides
- (void)setCollectionData:(NSArray *)collectionData {
    _collectionData = collectionData;
    [_collectionView setContentOffset:CGPointZero animated:NO];
    [_collectionView reloadData];
}


#pragma mark - UICollectionViewDataSource methods
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.collectionData count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NKArticleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NKArticleCollectionViewCell" forIndexPath:indexPath];
    NSDictionary *cellData = [self.collectionData objectAtIndex:[indexPath row]];
    cell.blockTitle.text = [cellData objectForKey:@"title"];
    [cell.blockImage setImage:[UIImage imageNamed:cellData[@"image"]]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *cellData = [self.collectionData objectAtIndex:[indexPath row]];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didSelectItemFromCollectionView" object:cellData];
}
#pragma mark - IBAction
-(IBAction)actionRight:(UIButton *)sender {
    NSArray *visibleItems = [self.collectionView indexPathsForVisibleItems];
    NSArray *sortedIndexPaths = [visibleItems sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSIndexPath *path1 = (NSIndexPath *)obj1;
        NSIndexPath *path2 = (NSIndexPath *)obj2;
        return [path1 compare:path2];
    }];
    NSIndexPath *currentItem = [sortedIndexPaths objectAtIndex:2];
    count = currentItem.row+1;
    if (count<=self.collectionData.count-1) {
        [self snapRightToCellAtIndex:count section:(int)currentItem.section withAnimation:YES];//paas index here to move to.
    }
    
}
-(IBAction)actionLeft:(UIButton *)sender {
    NSArray *visibleItems = [self.collectionView indexPathsForVisibleItems];
    NSArray *sortedIndexPaths = [visibleItems sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSIndexPath *path1 = (NSIndexPath *)obj1;
        NSIndexPath *path2 = (NSIndexPath *)obj2;
        return [path1 compare:path2];
    }];
    NSIndexPath *currentItem = [sortedIndexPaths objectAtIndex:0];
    count = currentItem.row-1;
    if (count>=0) {
       [self snapLeftToCellAtIndex:count section:(int)currentItem.section withAnimation:YES];//paas index here to move to.
    }
}

- (void) snapRightToCellAtIndex:(NSInteger)index section:(int)currentSection withAnimation:(BOOL) animated
{
    NSIndexPath *nextItem = [NSIndexPath indexPathForItem:index inSection:currentSection];
    [_collectionView scrollToItemAtIndexPath:nextItem atScrollPosition:UICollectionViewScrollPositionRight animated:animated];
}
- (void) snapLeftToCellAtIndex:(NSInteger)index section:(int)currentSection withAnimation:(BOOL) animated
{
    NSIndexPath *prevItem = [NSIndexPath indexPathForItem:index inSection:currentSection];
    [_collectionView scrollToItemAtIndexPath:prevItem atScrollPosition:UICollectionViewScrollPositionLeft animated:animated];
}
@end
