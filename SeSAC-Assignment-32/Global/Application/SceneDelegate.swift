//
//  SceneDelegate.swift
//  SeSAC-Assignment-31
//
//  Created by 김민성 on 8/9/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        let tabBarController = UITabBarController()
        let ageVC = AgeViewController()
        ageVC.tabBarItem = UITabBarItem(title: "나이", image: UIImage(systemName: "person.fill"), tag: 0)
        let bmiVC = BMIViewController()
        bmiVC.tabBarItem = UITabBarItem(title: "BMI", image: UIImage(systemName: "waveform.path.ecg"), tag: 1)
        let birthdayVC = BirthdayViewController()
        birthdayVC.tabBarItem = UITabBarItem(title: "생년월일", image: UIImage(systemName: "calendar"), tag: 2)
        let currencyVC = CurrencyViewController()
        currencyVC.tabBarItem = UITabBarItem(title: "환율", image: UIImage(systemName: "dollarsign.arrow.trianglehead.counterclockwise.rotate.90"), tag: 3)
        let wordCounterVC = WordCounterViewController()
        wordCounterVC.tabBarItem = UITabBarItem(title: "글자 수 계산", image: UIImage(systemName: "text.word.spacing"), tag: 4)
        let restaurantVC = MapViewController()
        restaurantVC.tabBarItem = UITabBarItem(title: "식당 지도", image: UIImage(systemName: "map"), tag: 5)
        
        tabBarController.viewControllers = [
            ageVC,
            bmiVC,
            birthdayVC,
            currencyVC,
            wordCounterVC,
            restaurantVC
        ]
        tabBarController.tabBar.tintColor = .systemBlue
        tabBarController.tabBar.unselectedItemTintColor = .systemGray
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

