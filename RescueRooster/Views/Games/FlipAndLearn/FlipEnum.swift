//
//  FlipEnum.swift
//  RescueRooster
//
//  Created by Роман Главацкий on 03.09.2025.
//
import SwiftUI

enum FlipLearn: CaseIterable {
    case Extinguisher
    case FireTruck
    case Helmet
    case Hose
    case Suit
    case Boots
    case Gloves
    case Axe
    case Siren
    case Radio
    case Mask
    case Detector
    case Exit
    case Call101
    case NoBlock
    case StopDropRoll
    
    var icon: ImageResource{
        switch self {
            
        case .Extinguisher:
            return .extinguisher
        case .FireTruck:
            return .firetrack
        case .Helmet:
            return .helment
        case .Hose:
            return .hose
        case .Suit:
            return .suit
        case .Boots:
            return .boots
        case .Gloves:
            return .gloves
        case .Axe:
            return .axe
        case .Siren:
            return .siren
        case .Radio:
            return .radio
        case .Mask:
            return .mask
        case .Detector:
            return .detector
        case .Exit:
            return .exit
        case .Call101:
            return .call101
        case .NoBlock:
            return .noBlock
        case .StopDropRoll:
            return .stop    
        }
    }
    
    var description: String {
        switch self {
            
        case .Extinguisher:
            return "A fire extinguisher is used to put out small fires before they spread. It sprays foam or powder to stop flames and is often found in homes, schools, and buildings for safety."
        case .FireTruck:
            return "A fire truck carries water, ladders, and equipment to the fire. It helps firefighters reach the scene quickly and provides tools to save people and protect buildings."
        case .Helmet:
            return "A firefighter’s helmet protects the head from falling debris, heat, and smoke. It is one of the most important safety items in their gear."
        case .Hose:
            return "A fire hose sprays water with strong pressure to fight fires. It connects to hydrants or the truck’s tank and helps control large flames."
        case .Suit:
            return "A firefighter’s suit is made from special heat-resistant material. It protects the body from fire, smoke, and dangerous conditions during rescues."
        case .Boots:
            return "Firefighter boots are heavy and strong to keep feet safe. They protect against heat, sharp objects, and slippery ground."
        case .Gloves:
            return "Protective gloves shield hands from heat, sharp edges, and smoke. Firefighters use them to handle tools safely during emergencies."
        case .Axe:
            return "A fire axe helps firefighters break doors, windows, or walls. It is a powerful tool used to rescue people and reach dangerous areas."
        case .Siren:
            return "A siren makes a loud sound and flashes bright lights. It warns people that firefighters are coming and helps clear the way quickly."
        case .Radio:
            return "Firefighters use radios to talk to each other during an emergency. Radios help teams stay connected and work together safely."
        case .Mask:
            return "A firefighter’s mask protects their face and helps them breathe clean air. It is used when there is a lot of smoke in the building."
        case .Detector:
            return "A smoke detector makes a loud alarm when it senses smoke. It warns people early so they can escape safely before fire spreads."
        case .Exit:
            return "An exit sign shows the safest way out of a building. Always follow the exit signs during an emergency to reach safety."
        case .Call101:
            return "Calling 101 connects you to the fire department. It is the fastest way to get help when there is a fire."
        case .NoBlock:
            return "Never block doors, hallways, or stairways. Keeping them clear makes it easier for everyone to escape during a fire."
        case .StopDropRoll:
            return "If your clothes catch fire, stop moving, drop to the ground, and roll. This helps put out the flames quickly and keeps you safe."
        }
    }
}
