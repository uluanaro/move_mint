//
//  MockAIWorkoutService.swift
//  MoveMint
//
//  Created by uluana_roshina on 14.07.2026.
//
final class MockAIWorkoutService: AIWorkoutServiceProtocol {
    func generateExercises(goal: FitnessGoal, durationMinutes: Int) async throws -> [String] {
        switch goal {
        case .muscleGain:
            return ["Приседания 3×12", "Отжимания 3×10", "Планка 3×45 сек", "Выпады 3×10"]
        case .weightLoss:
            return ["Бёрпи 4×15", "Прыжки 3×30 сек", "Скалолаз 3×20", "Бег на месте 5 мин"]
        case .wellbeing:
            return ["Растяжка шеи", "Наклоны вперёд", "Поза кошки", "Дыхание 4-7-8"]
        }
    }
}
