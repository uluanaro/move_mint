//
//  HealthServiceStub.swift
//  MoveMint
//
//  Created by uluana_roshina on 13.07.2026.
//
import Testing
@testable import MoveMint

final class HealthServiceStub: HealthServiceProtocol {
    var stepsToReturn = 0
    
    func requestAuthorization() async throws {}
    
    func todaySteps() async throws -> Int {
        return stepsToReturn
    }
}

struct GenerateWorkoutUseCaseTests {
    @MainActor
    @Test func manySteps_producesShortWorkout() async throws {
        let stub = HealthServiceStub()
        let aiService = AIWorkoutServiceStub()
        stub.stepsToReturn = 10000
        let useCase = GenerateWorkoutUseCase(healthService: stub, aiService: aiService)
        
        let workout = try await useCase.execute(goal: .weightLoss)
        
        #expect(workout.durationMinutes == 15)
        #expect(workout.goal == .weightLoss)
        #expect(workout.exercises == ["Приседания", "Отжимания"])
    }
    @MainActor
    @Test func mediumSteps_producesMediumWorkout() async throws {
        let stub = HealthServiceStub()
        let aiService = AIWorkoutServiceStub()
        stub.stepsToReturn = 6000
        let useCase = GenerateWorkoutUseCase(healthService: stub, aiService: aiService)
        
        let workout = try await useCase.execute(goal: .weightLoss)
        
        #expect(workout.durationMinutes == 30)
        #expect(workout.goal == .weightLoss)
    }
    @MainActor
    @Test func lessSteps_producesLongWorkout() async throws {
        let stub = HealthServiceStub()
        let aiService = AIWorkoutServiceStub()
        stub.stepsToReturn = 2000
        let useCase = GenerateWorkoutUseCase(healthService: stub, aiService: aiService)
        
        let workout = try await useCase.execute(goal: .weightLoss)
        
        #expect(workout.durationMinutes == 45)
        #expect(workout.goal == .weightLoss)
    }
}


