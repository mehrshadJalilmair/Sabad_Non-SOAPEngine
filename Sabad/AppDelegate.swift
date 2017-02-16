//
//  AppDelegate.swift
//  Sabad
//
//  Created by Mehrshad Jalilmasir on 1/24/17.
//  Copyright © 2017 Mehrshad Jalilmasir. All rights reserved.
//

import UIKit
import CoreData

let SCREEN_SIZE = UIScreen.main.bounds
let defaults = UserDefaults.standard




var townList:[Town] = [Town]()
var townListCopy:[Town] = [Town]()
var request:Request!
var twId:Int = 1
var twIdIndex:Int = 1
var changeBannerAndList = false // when town is changed

//follows
var followGoods:[Good] = [Good]()

//tageds
var tagedStores:[Store] = [Store]()
var tagedGoods:[Good] = [Good]()

//set Abuse store
var abuseStore:Store!
var abuseGood:Good!
var abuseType:Int!

//Mall Modal vars
var storesInMall:[Store] = [Store]()

//home tab vars
var ads:[Ad] = [Ad]()
var adsImages:[String] = [String]()
var homeMallList:[Mall] = [Mall]()
var homeStoreList:[Store] = [Store]()
var homeGoodsList:[Good] = [Good]()


//goods tab vars
var townMallList:[Mall] = [Mall]()
var townMallListCopy:[Mall] = [Mall]()
var selectedMallId = -1
var selectedTownId = -1
var selectedTownIndex = -1
var filterType:Int = 1
var isConfirmFiltering = false
var goodsGoodList:[Good] = [Good]()

//search tab glob vars
var searchMallList:[Mall] = [Mall]()
var searchStoreList:[Store] = [Store]()
var searchGoodList:[Good] = [Good]()


@available(iOS 10.0, *)
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        request = Request()
        request.GetTownList()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Sabad")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

