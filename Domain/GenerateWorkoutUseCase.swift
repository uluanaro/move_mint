//
//  GenerateWorkoutUseCase.swift
//  MoveMint
//
//  Created by uluana_roshina on 13.07.2026.
//
final class GenerateWorkoutUseCase {
    private let healthService: HealthServiceProtocol
    private let planner: WorkoutPlanner
    private let aiService:AIWorkoutServiceProtocol
    
    init(healthService: HealthServiceProtocol, aiService: AIWorkoutServiceProtocol, planner: WorkoutPlanner = WorkoutPlanner()) {
        self.healthService = healthService
        self.aiService = aiService
        self.planner = planner
    }
    func execute(goal: FitnessGoal) async throws -> Workout {
        let steps = try await healthService.todaySteps()
        let duration = planner.duration(forSteps: steps)
        let exercises = try await aiService.generateExercises(goal: goal, durationMinutes: duration)
        return Workout(goal: goal, durationMinutes: duration, exercises: exercises)
    }
}

