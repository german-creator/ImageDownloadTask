//
//  AppCoordinator.swift
//  ImageDownloadTask
//
//  Created by Герман Иванилов on 29.03.2021.
//

import UIKit

final class AppCoordinator {
    private(set) var rootController: UIViewController?
    private let configurator: MainAssembly
    
    init(configurator: MainAssembly) {
        self.configurator = configurator
        rootController = configurator.mainViewController()
    }
    
    func start() -> UIViewController {
        return configurator.mainViewController()
    }
}
