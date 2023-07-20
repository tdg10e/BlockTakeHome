//
//  ContentView.swift
//  BlockTakeHome
//
//  Created by Tremaine Grant on 7/18/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var appCoordinator: AppCoordinator
    @ObservedObject private var serviceManager: ServiceManager

    init() {
        let serviceManager = ServiceManager()
        _appCoordinator = StateObject(wrappedValue: AppCoordinator(serviceManager: serviceManager))
        _serviceManager = ObservedObject(wrappedValue: serviceManager)
    }
    
    private var mainView: some View {
        appCoordinator.currentScreen.makeView(appCoordinator: appCoordinator, serviceManager: serviceManager)
    }
    
    var body: some View {
        mainView
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
