//
//  Builder.swift
//  
//
//  Created by Balaji Kondalrayan on 08/04/26.
//

/* Creating a Custom Shipping Container. You can add "Climate Control," "Reinforced Walls," and "GPS Tracking" step-by-step */

import Foundation

enum WallType {
    case steel
    case concrete
    case foam
    case plastic
}

struct ShippingContainer {
    let id: Int
    let climateControl: Bool
    let wallType: WallType
    let gpsTracking: Bool
}


class ContainerBuilder {
    private var id: Int = Int.random(in: 0..<10)
    private var climateControl: Bool = false
    private var wallType: WallType = .steel
    private var gpsTracking: Bool = true
    
    func setClimateControl(_ enabled: Bool) -> ContainerBuilder {
        self.climateControl = enabled
        return self
    }
    
    func setWallType(_ wallType: WallType) -> ContainerBuilder {
        self.wallType = wallType
        return self
    }
    
    func setGPSTracking(_ enabled: Bool) -> ContainerBuilder {
        self.gpsTracking = enabled
        return self
    }
    
    func build() -> ShippingContainer {
        return ShippingContainer(
            id: id,
            climateControl: climateControl,
            wallType: wallType,
            gpsTracking: gpsTracking
        )
    }
}


let shippingContainer = ContainerBuilder()
    .setGPSTracking(false)
    .build()


// MARK: Bonus - Create a Director to have a function which will decide the what to send based on the need


class LogisticsDirector {
    func createBudgetContainer(builder: ContainerBuilder) -> ShippingContainer {
        return builder
            .setClimateControl(false)
            .setWallType(.plastic)
            .setGPSTracking(false)
            .build()
    }

    func createFeaturisticContainer(builder: ContainerBuilder) -> ShippingContainer {
        return ContainerBuilder()
            .setWallType(.foam)
            .setClimateControl(true)
            .setGPSTracking(true)
            .build()
    }
}


let budgetContainer = LogisticsDirector()
    .createBudgetContainer(builder: ContainerBuilder())

let expensiveContainer = LogisticsDirector()
    .createFeaturisticContainer(builder: ContainerBuilder())








