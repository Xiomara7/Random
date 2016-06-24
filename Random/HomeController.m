//
//  HomeController.m
//  Random
//
//  Created by Xiomara on 6/23/16.
//  Copyright © 2016 Xiomara. All rights reserved.
//

#import "HomeController.h"
#import "CollectionCell.h"
#import <PureLayout/PureLayout.h>

@interface HomeController ()

@end

@implementation HomeController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.randomImages = [[NSMutableArray alloc] init];
    self.likedImages = [[NSMutableArray alloc] init];
    
    [self getImages];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.randomImages removeAllObjects];
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
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0, 60.0, 320, 44.0)];
    self.searchBar.placeholder = @"Search";
    self.searchBar.delegate = self;
    
    [self.view addSubview:self.searchBar];
    
    // Auto Layout
    [self.collectionView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.searchBar];
    [self.collectionView autoPinToBottomLayoutGuideOfViewController:self withInset:0.0];
    [self.collectionView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.collectionView autoPinEdgeToSuperviewEdge:ALEdgeRight];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - Selector Methods

- (void)shareAction:(UIButton *)sender {
    self.shareView = [[UIActivityViewController alloc]
                        initWithActivityItems: @[[self.randomImages objectAtIndex:sender.tag]]
                        applicationActivities: nil
                      ];
    
    [self presentViewController:self.shareView animated:true completion:nil];
}

- (void)likeAction:(UIButton *)sender {
    if (sender.selected) {
        sender.selected = NO;
    } else {
        sender.selected = YES;
    }
    
    [self.likedImages addObject: [self.randomImages objectAtIndex:sender.tag]];
}

#pragma mark - Search Bar Delegate Methods

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.searchBar resignFirstResponder];
    [self searchImagesWithTag:searchBar.text];
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
    
    [cell.shareButton addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
     cell.shareButton.tag = indexPath.row;
    
    [cell.likesButton addTarget:self action:@selector(likeAction:) forControlEvents:UIControlEventTouchUpInside];
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

- (void)getImages {
    for (int i = 1; i <= 10; i++) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSURL *imageURL = [NSURL URLWithString:@"https://source.unsplash.com/random"];
            NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.randomImages addObject:[UIImage imageWithData:imageData]];
                [self.collectionView reloadData];
            });
        });
    }
}

- (void)searchImagesWithTag:(NSString *)tag {
    [self.randomImages removeAllObjects];
    
    for (int i = 1; i <= 10; i++) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://source.unsplash.com/featured/%@", tag]];
            NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.randomImages addObject:[UIImage imageWithData:imageData]];
                [self.collectionView reloadData];
            });
        });
    }
}

@end
