//
//  DependencyFactory.swift
//  MoveMint
//
//  Created by uluana_roshina on 14.07.2026.
//
import Foundation

@MainActor
final class DependencyFactory {
    static let shared = DependencyFactory()
    
    private init() {}
    
    lazy var healthService: HealthServiceProtocol = HealthService()
    lazy var aiService: AIWorkoutServiceProtocol = MockAIWorkoutService()
    
    
    func makeGenerateWorkoutUseCase() -> GenerateWorkoutUseCase {
        GenerateWorkoutUseCase(
            healthService: healthService,
            aiService: aiService
        )
    }
    
    func makeDashboardViewModel() -> DashboardViewModel {
        DashboardViewModel(
            healthService: healthService,
            generateWorkoutUseCase: makeGenerateWorkoutUseCase()
        )
    }
}
