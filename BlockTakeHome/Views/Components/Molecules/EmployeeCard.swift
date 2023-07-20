//
//  EmployeeCard.swift
//  BlockTakeHome
//
//  Created by Tremaine Grant on 7/19/23.
//

import SwiftUI

class EmployeCardViewModel: ObservableObject {
    @Published var serviceManager: ServiceManager
    @Published var employee: Employee
    @Published var profileImage: Image?
    
    init(serviceManager: ServiceManager, employee: Employee) {
        self.serviceManager = serviceManager
        self.employee = employee
        
        if !employee.photoURLSmall.isEmpty {
            fetchProfileImage(stringUrl: employee.photoURLSmall)
        }
    }
    
    func fetchProfileImage(stringUrl: String) {
        serviceManager.fetchImage(with: stringUrl) { [weak self] results in
            switch results {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.profileImage = Image(uiImage: image)
                }
            case .failure(let error):
                print("There was an error loading the image in Employee Card: \(error)")
            }
        }
    }
}

struct EmployeeCard: View {
    @ObservedObject var viewModel: EmployeCardViewModel
    
    var defaultAvi: some View {
        ZStack {
            Circle()
                .fill(Color.lightGray)
                .frame(width: 76, height: 76)
            Image(systemName: "person")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.charcoal)
                .frame(width: 24, height: 24)
        }
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            Group {
                if let image = viewModel.profileImage {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 76, height: 76)
                        .clipShape(Circle())
                } else {
                    defaultAvi
                }
            }
            .padding(.leading, 40)
            
            VStack(alignment: .leading) {
                Text(viewModel.employee.fullName)
                    .font(.headline)
                Text(viewModel.employee.team.rawValue)
                    .font(.subheadline)
                    .bold()
                    .padding(.leading, 2)
                Text(viewModel.employee.phoneNumber)
                    .font(.subheadline)
                    .padding(.leading, 2)
            }
            
            Spacer()
        }
    }
}

struct EmployeeCard_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeCard(viewModel: EmployeCardViewModel(serviceManager: ServiceManager(), employee: Fixtures.mockEmployee1))
    }
}
