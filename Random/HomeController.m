//
//  HomeController.m
//  Random
//
//  Created by Xiomara on 6/23/16.
//  Copyright © 2016 Xiomara. All rights reserved.
//

#import "HomeController.h"
#import "CollectionCell.h"
#import "DataManager.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import <PureLayout/PureLayout.h>

@implementation HomeController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.unspashURL = @"https://source.unsplash.com/random";
    self.randomImages = [[NSMutableArray alloc] init];
    
    [self getImages];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.randomImages removeAllObjects];
    [self.collectionView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                             collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    
    [self.collectionView setDataSource:self];
    [self.collectionView setDelegate:self];
    
    [self.collectionView registerClass:[CollectionCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:self.collectionView];
    
    // Auto Layout Constraints
    [self.collectionView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
    [self.collectionView autoPinToBottomLayoutGuideOfViewController:self withInset:0.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - Selector Methods


- (void)shareAction:(UIButton *)sender {
    UIImage *image = [self.randomImages objectAtIndex:sender.tag];
    
    self.shareView = [[UIActivityViewController alloc]
                        initWithActivityItems: @[image]
                        applicationActivities: nil
                      ];
    
    [self presentViewController:self.shareView animated:true completion:nil];
}

- (void)dismissLoading {
    [SVProgressHUD dismiss];
}

- (void)likeAction:(UIButton *)sender {
    [SVProgressHUD showWithStatus:@"SAVED"];
    
    [NSTimer scheduledTimerWithTimeInterval:1.5
                                     target:self
                                   selector:@selector(dismissLoading)
                                   userInfo:nil
                                    repeats:YES];
    
    [[[DataManager sharedManager] likedImages]
     addObject:[self.randomImages objectAtIndex:sender.tag]];
    
    [self.randomImages removeObjectAtIndex:sender.tag];
    
    [self.collectionView reloadData];
}

#pragma mark - UICollection Delegate & DataSource Methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.randomImages count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[CollectionCell alloc] initWithFrame:CGRectZero];
    }
    
    [self.view bringSubviewToFront:cell.shareButton];
    [self.view bringSubviewToFront:cell.likesButton];
    
    [cell.shareButton addTarget: self
                         action: @selector(shareAction:)
               forControlEvents: UIControlEventTouchUpInside];
    
    [cell.likesButton addTarget: self
                         action: @selector(likeAction:)
               forControlEvents:UIControlEventTouchUpInside];
    
    cell.shareButton.tag = indexPath.row;
    cell.likesButton.tag = indexPath.row;
    
    if ([self.randomImages count] > 0) {
        cell.randomImageView.image = [self.randomImages objectAtIndex:indexPath.row];
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGRect screenSize = [[UIScreen mainScreen] bounds];
    return CGSizeMake(screenSize.size.width - 20.0, screenSize.size.height / 2);
}

#pragma mark - Custom Methods

// Getting random images from www.unspalsh.com
- (void)getImages {
    [SVProgressHUD show];
    
    for (int i = 1; i <= 10; i++) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSURL *imageURL = [NSURL URLWithString:self.unspashURL];
            NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.randomImages addObject:[UIImage imageWithData:imageData]];
                [self.collectionView reloadData];
                
                if(i == 10) {
                    [SVProgressHUD dismiss];
                }
            });
        });
    }
}

@end
