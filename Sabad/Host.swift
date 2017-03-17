//
//  ViewController.swift
//  Sabad
//
//  Created by Mehrshad Jalilmasir on 1/24/17.
//  Copyright © 2017 Mehrshad Jalilmasir. All rights reserved.
//

import UIKit
import SlidingTabBar

var tabBarView: SlidingTabBar!

class Host: UITabBarController, SlidingTabBarDataSource, SlidingTabBarDelegate, UITabBarControllerDelegate {

    
    var fromIndex: Int!
    var toIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.isHidden = true
        
        let tabBarFrame = self.tabBar.frame
        self.selectedIndex = 3
        
        tabBarView = SlidingTabBar(frame: tabBarFrame, initialTabBarItemIndex: 3)
        tabBarView.tabBarBackgroundColor = UIColor(red: 31/255, green: 31/255, blue: 31/255 , alpha: 1)
        tabBarView.tabBarItemTintColor = UIColor(red: 111/255, green: 85/255, blue: 95/255 , alpha: 1)
        tabBarView.selectedTabBarItemTintColor = UIColor(red: 253/255, green: 252/255, blue: 251/255 , alpha: 1)
        tabBarView.selectedTabBarItemColors = [UIColor(red: 80/255, green: 101/255, blue: 161/255 , alpha: 1) , UIColor(red: 80/255, green: 101/255, blue: 161/255 , alpha: 1) , UIColor(red: 80/255, green: 101/255, blue: 161/255 , alpha: 1) , UIColor(red: 80/255, green: 101/255, blue: 161/255 , alpha: 1)]
        tabBarView.slideAnimationDuration = 0.2
        tabBarView.datasource = self
        tabBarView.delegate = self
        tabBarView.setup()
        
        self.delegate = self
        self.view.addSubview(tabBarView)
        
        UILabel.appearance().substituteFontName = "Vazir"
        UITextField.appearance().substituteFontName = "Vazir"
        UIButton.appearance().substituteFontName = "Vazir-Bold"
    }
    
    func tabBarItemsInSlidingTabBar(tabBarView: SlidingTabBar) -> [UITabBarItem] {
        return tabBar.items!
    }
    
    func didSelectViewController(tabBarView: SlidingTabBar, atIndex index: Int, from: Int) {
        
        self.fromIndex = from
        self.toIndex = index
        self.selectedIndex = index
        
        if from == index
        {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Update") , object:nil)
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return SlidingTabAnimatedTransitioning(transitionDuration: 0.2, direction: .Both, fromIndex: self.fromIndex, toIndex: self.toIndex)
    }
}

