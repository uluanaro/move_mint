//
//  AIWorkoutServiceStub.swift
//  MoveMint
//
//  Created by uluana_roshina on 14.07.2026.
//
@testable import MoveMint
import Foundation
final class AIWorkoutServiceStub: AIWorkoutServiceProtocol {
    var exercisesToReturn: [String] = ["Приседания", "Отжимания"]
    
    func generateExercises(goal: FitnessGoal, durationMinutes: Int) async throws -> [String] {
        return exercisesToReturn
    }
}
