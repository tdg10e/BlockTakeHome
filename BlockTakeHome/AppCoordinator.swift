//
//  AppCoordinator.swift
//  BlockTakeHome
//
//  Created by Tremaine Grant on 7/18/23.
//

import Foundation
import SwiftUI

protocol Screen {
    func makeView(appCoordinator: AppCoordinator, serviceManager: ServiceManager) -> AnyView
}

protocol ScreenNavigating {
    func setCurrentScreen(_ newScreen: AppCoordinator.Screen)
}

class AppCoordinator: ObservableObject, ScreenNavigating {
    enum Screen {
        case employeeList
    }
    
    @Published var currentScreen: Screen = .employeeList
    @ObservedObject var serviceManager: ServiceManager
    
    init(serviceManager: ServiceManager) {
        self.serviceManager = serviceManager
        
        Task {
            await self.serviceManager.configure()
        }
    }
    
    func setCurrentScreen(_ newScreen: Screen) {
        withAnimation {
            currentScreen = newScreen
        }
    }
}

extension AppCoordinator.Screen: Screen {
    func makeView(appCoordinator: AppCoordinator, serviceManager: ServiceManager) -> AnyView {
        switch self {
        case .employeeList:
            return AnyView(
                EmployeeListView(viewModel: EmployeeListViewModel(navigator: appCoordinator, serviceManager: serviceManager))
            )
        }
    }
}
