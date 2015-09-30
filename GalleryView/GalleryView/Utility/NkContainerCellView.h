//
//  NkContainerCellView.h
//  ImageGrid
//
//  Created by Nikunj Modi on 9/21/15.
//  Copyright (c) 2015 Nikunj Modi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NkContainerCellView : UIView{
    NSInteger count;
    NSMutableDictionary *selectedIdx;
}
- (void)setCollectionData:(NSArray *)collectionData;
@end
