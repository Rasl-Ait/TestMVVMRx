//
//  AppDelegate.swift
//  TestMVVMRx
//
//  Created by rasl on 25/03/2019.
//  Copyright © 2019 rasl. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	private let rootRouter = RootRouter()

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		
		let vc = PostListController()
		let nav = UINavigationController(rootViewController: vc)
		rootRouter.root(&window, rootViewController: nav)
		return true
	}

	func applicationWillResignActive(_ application: UIApplication) {}

	func applicationDidEnterBackground(_ application: UIApplication) {}

	func applicationWillEnterForeground(_ application: UIApplication) {}

	func applicationDidBecomeActive(_ application: UIApplication) {}

	func applicationWillTerminate(_ application: UIApplication) {}
}
