//
//  FirstViewController.h
//  metaclone
//
//  Created by Mrudul P on 25/03/15.
//  Copyright (c) 2015 Mrudul P. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WatchFacesVC : UIViewController<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView;


@end

