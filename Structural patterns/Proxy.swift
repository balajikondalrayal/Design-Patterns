//
//  Proxy.swift
//  
//
//  Created by Balaji Kondalrayan on 09/04/26.
//

/* Proxy pattern is used to control access to an object. It provides a surrogate or placeholder for another object to control access to it. */

/* Creatying the Warehouse gatekeeper to know the real inventory manager and control access to it */

fileprivate actor InventoryManager {
    private var inventory: [String: Int] = [:]

    func addItem(name: String, quantity: Int) {
        inventory[name, default: 0] += quantity
    }

    func getInventory() -> [String: Int] {
        return inventory
    }
}

actor WarehouseGatekeeper {
    private let inventoryManager = InventoryManager()

    private let authorizedUsers: Set<String> = ["admin", "manager"]

    func addItemToInventory(name: String, quantity: Int, user: String) async {
        // You can add access control logic here
        if authorizedUsers.contains(user) {
            await inventoryManager.addItem(name: name, quantity: quantity)
        } else {
            print("Access denied for user: \(user)")
        }
    }

    func viewInventory(user: String) async -> [String: Int] {
        // You can add access control logic here
        if authorizedUsers.contains(user) {
            return await inventoryManager.getInventory()
        } else {
            print("Access denied for user: \(user)")
            return [:]
        }
    }
}

let gatekeeper = WarehouseGatekeeper()

Task {
    await gatekeeper.addItemToInventory(name: "ItemA", quantity: 100, user: "admin")
    let inventory = await gatekeeper.viewInventory(user: "admin") // Should show inventory
    print(inventory)
    await gatekeeper.addItemToInventory(name: "ItemB", quantity: 50, user: "guest") // Access denied
    let inventory1 = await gatekeeper.viewInventory(user: "guest") // Access denied
    print(inventory1)
}