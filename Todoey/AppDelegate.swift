//
//  AppDelegate.swift
//  Todoey
//
//  Created by Letitia Wu on 2019/8/31.
//  Copyright © 2019 Letitia Wu. All rights reserved.
//

import UIKit
import RealmSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
      let config = Realm.Configuration(
          schemaVersion: 1,
          migrationBlock: { migration, oldSchemaVersion in
            if (oldSchemaVersion < 1) {
              }
          })
      Realm.Configuration.defaultConfiguration = config
//      let realm = try! Realm()
    
//        print(Realm.Configuration.defaultConfiguration.fileURL)

        do {
            _ = try Realm()
        } catch {
            print("Error initialising new realm, \(error)")
        }
        return true
    }
}

