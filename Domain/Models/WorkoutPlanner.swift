//
//  WorkoutPlanner.swift
//  MoveMint
//
//  Created by uluana_roshina on 13.07.2026.
//
import Foundation

struct WorkoutPlanner {
    
    func duration(forSteps steps: Int) -> Int {
        let steps = max(0, steps)
        if steps >= 8000 {
            return 15
        } else if steps >= 4000 {
            return 30
        } else {
            return 45
        }
    }
}
