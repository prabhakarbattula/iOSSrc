//
//  FirstViewController.m
//  metaclone
//
//  Created by Mrudul P on 25/03/15.
//  Copyright (c) 2015 Mrudul P. All rights reserved.
//

#import "WatchFacesVC.h"

@interface WatchFacesVC ()

@end

@implementation WatchFacesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void) viewWillAppear:(BOOL)animated
{
    //Setting title for Watchfaces
    self.parentViewController.navigationItem.title = @"Watchfaces";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//CollectionViewDataSourceProtocol
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 0;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 0;
}


@end
