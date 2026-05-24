//
//  Decorator.swift
//  
//
//  Created by Balaji Kondalrayan on 24/05/26.
//

/* Decorator pattern is used to add new functionality to existing objects without altering their structure. It provides a flexible alternative to subclassing for extending functionality. */

/* Creating the VehicleDecorator which adds additional functionality to normal vehicles */

protocol Vehicle {
    var capacity: Int { get }
    func deliver()
}

class Truck: Vehicle {
    var capacity: Int

    init(capacity: Int) {
        self.capacity = capacity
    }

    func deliver() {
        print("Delivering by truck with capacity \(capacity) tons")
    }
}


class VehicleDecorator: Vehicle {
    private let decoratedVehicle: Vehicle

    var capacity: Int {
        return decoratedVehicle.capacity
    }

    init(decoratedVehicle: Vehicle) {
        self.decoratedVehicle = decoratedVehicle
    }

    func deliver() {
        decoratedVehicle.deliver()
    }
}

class InsuredVehicleDecorator: VehicleDecorator {
    override func deliver() {
        print("Adding insurance to the delivery")
        super.deliver()
    }
}

class TrackedVehicleDecorator: VehicleDecorator {
    override func deliver() {
        print("Adding GPS tracking to the delivery")
        super.deliver()
    }
}

let truck = Truck(capacity: 100)
let insuredTruck = InsuredVehicleDecorator(decoratedVehicle: truck)
let trackedInsuredTruck = TrackedVehicleDecorator(decoratedVehicle: insuredTruck)
trackedInsuredTruck.deliver()