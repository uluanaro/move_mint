//
//  DashboardViewModel.swift
//  MoveMint
//
//  Created by uluana_roshina on 14.07.2026.
//
import Foundation
import Combine
@MainActor
final class DashboardViewModel: ObservableObject {
    @Published var steps: Int = 0
    @Published var selectedGoal: FitnessGoal = .wellbeing
    @Published var workout: Workout?
    
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let healthService: HealthServiceProtocol
    private let generateWorkoutUseCase: GenerateWorkoutUseCase
    
    init(healthService: HealthServiceProtocol, generateWorkoutUseCase: GenerateWorkoutUseCase) {
        self.healthService = healthService
        self.generateWorkoutUseCase = generateWorkoutUseCase
    }
    func loadSteps() async {
        do {
            try await healthService.requestAuthorization()
            steps = try await healthService.todaySteps()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    func generateWorkout() async {
        isLoading = true
        do {
            workout = try await generateWorkoutUseCase.execute(goal: selectedGoal)
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    func makeDashboardViewModel() -> DashboardViewModel {
        DashboardViewModel(healthService: healthService, generateWorkoutUseCase: generateWorkoutUseCase)
        
    }
    
}
