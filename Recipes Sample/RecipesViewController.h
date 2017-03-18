//
//  RecipesViewController.h
//  Recipes Sample
//
//  Created by user on 18.03.17.
//  Copyright © 2017 edu.self. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipesViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
    @property(nonatomic) NSArray *recipes;
@end
