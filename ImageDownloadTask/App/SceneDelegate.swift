//
//  SceneDelegate.swift
//  ImageDownloadTask
//
//  Created by Герман Иванилов on 28.03.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    private let configurator = AppConfiguringImpl()
    private var coordinator = AppCoordinator(configurator: MainAssemblyDefault())
    var window: UIWindow?    

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }

        setWindow(windowScene: windowScene)
        
        configurator.configure()
        
    }

    
    func setWindow(windowScene: UIWindowScene){
    
        let window = UIWindow(windowScene: windowScene)
        
        window.makeKeyAndVisible()
        window.overrideUserInterfaceStyle = .light
        window.rootViewController = coordinator.start()

        self.window = window
    }
}

