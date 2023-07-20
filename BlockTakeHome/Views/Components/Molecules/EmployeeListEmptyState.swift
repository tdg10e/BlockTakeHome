//
//  EmployeeListEmptyState.swift
//  BlockTakeHome
//
//  Created by Tremaine Grant on 7/20/23.
//

import SwiftUI

class EmployeeListEmptyStateViewModel: ObservableObject {
    @Published var serviceManager: ServiceManager
    
    init(serviceManager: ServiceManager) {
        self.serviceManager = serviceManager
    }
    
    func refreshList() async {
        await serviceManager.fetchEmployees()
    }
}

struct EmployeeListEmptyState: View {
    @ObservedObject var viewModel: EmployeeListEmptyStateViewModel
    
    var body: some View {
        VStack {
            IconImage(.custom(.missingIcon))
                .frame(width: 76, height: 76)
            if let errorCode = viewModel.serviceManager.errorCode {
                Text("There was an issue fetching the employee list. Try restarting the app. If the problem persists, please contact an admin. error code: \(errorCode.rawValue)")
                    .padding()
            } else {
                Text("There was an issue fetching the employee list.")
                    .padding()
            }
            
            Button(action: {
                Task {
                    await viewModel.refreshList()
                }
            }) {
                ZStack {
                    Rectangle()
                        .foregroundColor(.clear)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .frame(height: 44)
                    
                    Text("Refresh")
                }
                .padding(.horizontal, 40)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding()
    }
}

struct EmployeeListEmptyState_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeListEmptyState(viewModel: EmployeeListEmptyStateViewModel(serviceManager: ServiceManager()))
    }
}
