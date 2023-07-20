//
//  EmployeeListView.swift
//  BlockTakeHome
//
//  Created by Tremaine Grant on 7/18/23.
//

import SwiftUI
import Combine

class EmployeeListViewModel: ObservableObject {
    @Published var navigator: ScreenNavigating
    @Published var employees: [Employee]
    @Published var filteredEmployees: [Employee] = []

    @Published var isFiltersPresented: Bool = false
    @ObservedObject var serviceManager: ServiceManager
    
    init(navigator: ScreenNavigating, serviceManager: ServiceManager, employees: [Employee] = []) {
        self.serviceManager = serviceManager
        self.employees = employees
        self.navigator = navigator
        
        self.loadEmployees()
      }
    
    func filterEmployees(byName: String) {
        main {
            self.filteredEmployees = self.employees.filter {$0.fullName.contains(byName)}
        }
    }
    
    func filterEmployees(byTeam teams: [Team], byType types: [EmployeeType]) {
        let filteredByTeam = employees.filter { teams.contains($0.team) }
        if types.count == 0 {
            self.filteredEmployees = filteredByTeam
            return
        }
        let filteredByType = filteredByTeam.filter { types.contains($0.employeeType) }
        self.filteredEmployees = filteredByType
    }
    
    private func loadEmployees() {
        employees = serviceManager.employees
    }

}

struct EmployeeListView: View {
    @ObservedObject var viewModel: EmployeeListViewModel
    @State private var searchText: String = ""

    var searchAndFilter: some View {
        HStack {
            SearchBar(viewModel: SearchBarViewModel(onSearch: { searchResult in
                viewModel.filterEmployees(byName: searchResult)
            }))
            .padding(.horizontal, 20)
            
            if !viewModel.employees.isEmpty {
                IconImage(.sfSymbol(.filter))
                    .padding(.trailing, 26)
                    .onTapGesture {
                        viewModel.isFiltersPresented = true
                    }
            }
        }
    }
    
    var employeeList: some View {
        VStack {
            if viewModel.employees.isEmpty {
                EmployeeListEmptyState(viewModel: EmployeeListEmptyStateViewModel(serviceManager: viewModel.serviceManager))
                    .padding(.top, 60)
                Spacer()
            } else {
                ScrollView {
                    Spacer()
                        .frame(height: 40)
                    ForEach(viewModel.filteredEmployees.isEmpty ? viewModel.employees : viewModel.filteredEmployees) { employee in
                        EmployeeCard(viewModel: EmployeCardViewModel(serviceManager: viewModel.serviceManager, employee: employee))
                    }
                }
            }
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Employee Directory")
                    .font(.largeTitle)
                    .bold()
                    .padding(.leading, 30)
                    .padding(.top, 36)
                    .padding(.bottom, 46)
                Spacer()
                
            }
            
            searchAndFilter
            employeeList

        }.sheet(isPresented: $viewModel.isFiltersPresented) {
            FilterView(viewModel: FilterViewModel(returnFilters: { teams, types in
                viewModel.filterEmployees(byTeam: teams, byType: types)
                viewModel.isFiltersPresented = false
            }))
        }
    }
}



struct EmployeeListView_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeListView(viewModel: EmployeeListViewModel(navigator: Fixtures.mockScreenNavigator, serviceManager: ServiceManager(), employees: [
            Fixtures.mockEmployee1,
            Fixtures.mockEmployee2,
            Fixtures.mockEmployee3
        ]))
    }
}


