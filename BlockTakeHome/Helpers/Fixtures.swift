//
//  Fixtures.swift
//  BlockTakeHome
//
//  Created by Tremaine Grant on 7/19/23.
//

import Foundation

class Fixtures {
    class MockScreenNavigator: ScreenNavigating {
        func setCurrentScreen(_ newScreen: AppCoordinator.Screen) {
        }
    }
    
    static let mockScreenNavigator: ScreenNavigating = MockScreenNavigator()
    
    static var mockEmployee1: Employee {
        return Employee(
            id: "0d8fcc12-4d0c-425c-8355-390b312b909c",
            fullName: "Justine Mason",
            phoneNumber: "5553280123",
            emailAddress: "jmason.demo@squareup.com",
            biography: "Engineer on the Point of Sale team.",
            photoURLSmall: "https://s3.amazonaws.com/sq-mobile-interview/photos/16c00560-6dd3-4af4-97a6-d4754e7f2394/small.jpg",
            photoURLLarge: "https://s3.amazonaws.com/sq-mobile-interview/photos/16c00560-6dd3-4af4-97a6-d4754e7f2394/large.jpg",
            team: .pos,
            employeeType: .fullTime
        )
    }
    
    static var mockEmployee2: Employee {
        return Employee(
            id: "a98f8a2e-c975-4ba3-8b35-01f719e7de2d",
            fullName: "Camille Rogers",
            phoneNumber: "5558531970",
            emailAddress: "crogers.demo@squareup.com",
            biography: "Designer on the web marketing team.",
            photoURLSmall: "https://s3.amazonaws.com/sq-mobile-interview/photos/5095a907-abc9-4734-8d1e-0eeb2506bfa8/small.jpg",
            photoURLLarge: "https://s3.amazonaws.com/sq-mobile-interview/photos/5095a907-abc9-4734-8d1e-0eeb2506bfa8/large.jpg",
            team: .marketing,
            employeeType: .partTime
        )
    }
    
    static var mockEmployee3: Employee {
        return Employee(
            id: "b8cf3382-ecf2-4240-b8ab-007688426e8c",
            fullName: "Richard Stein",
            phoneNumber: "5557223332",
            emailAddress: "rstein.demo@squareup.com",
            biography: "Product manager for the Point of sale app!",
            photoURLSmall: "https://s3.amazonaws.com/sq-mobile-interview/photos/43ed39b3-fbc0-4eb8-8ed3-6a8de479a52a/small.jpg",
            photoURLLarge: "https://s3.amazonaws.com/sq-mobile-interview/photos/43ed39b3-fbc0-4eb8-8ed3-6a8de479a52a/large.jpg",
            team: .pos,
            employeeType: .partTime
        )
    }
}
