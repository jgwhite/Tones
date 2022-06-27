//
//  Note.swift
//  Tones
//
//  Created by Jamie White on 23/06/2022.
//

import Foundation
import SwiftUI

enum Note: CaseIterable {
    case C, D, E, F, G, A, B
    
    var letter: String {
        switch self {
        case .C: return "C"
        case .D: return "D"
        case .E: return "E"
        case .F: return "F"
        case .G: return "G"
        case .A: return "A"
        case .B: return "B"
        }
    }
    
    var solfege: String {
        switch self {
        case .C: return "Do"
        case .D: return "Re"
        case .E: return "Mi"
        case .F: return "Fa"
        case .G: return "Sol"
        case .A: return "La"
        case .B: return "Si"
        }
    }
}
