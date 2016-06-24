//
//  LikesController.m
//  Random
//
//  Created by Xiomara on 6/23/16.
//  Copyright © 2016 Xiomara. All rights reserved.
//

#import "LikesController.h"
#import "CollectionCell.h"
#import <PureLayout/PureLayout.h>

@implementation LikesController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.collectionView setDataSource:self];
    [self.collectionView setDelegate:self];
    
    [self.collectionView registerClass:[CollectionCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:self.collectionView];
    
    // Auto Layout
    [self.collectionView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
    [self.collectionView autoPinToBottomLayoutGuideOfViewController:self withInset:0.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Selector Methods

- (void)shareAction:(UIButton *)sender {
    self.shareView = [[UIActivityViewController alloc]
                        initWithActivityItems: @[[self.randomLikedImages objectAtIndex:sender.tag]]
                        applicationActivities: nil
                      ];
    
    [self presentViewController:self.shareView animated:true completion:nil];
}

#pragma mark - UICollection Delegate & DataSource Methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.randomLikedImages count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[CollectionCell alloc] initWithFrame:CGRectZero];
    }
    
    if ([self.randomLikedImages count] > 0) {
        cell.randomImageView.image = [self.randomLikedImages objectAtIndex:indexPath.row];
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGRect screenSize = [[UIScreen mainScreen] bounds];
    return CGSizeMake(screenSize.size.width - 20.0, screenSize.size.height / 2);
}

@end
