//
//  AIWorkoutServiceProtocol.swift
//  MoveMint
//
//  Created by uluana_roshina on 14.07.2026.
//
import Foundation

protocol AIWorkoutServiceProtocol {
        func generateExercises(goal: FitnessGoal, durationMinutes: Int) async throws -> [String]
}
