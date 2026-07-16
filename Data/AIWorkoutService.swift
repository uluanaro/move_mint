//
//  AIWorkoutService.swift
//  MoveMint
//
//  Created by uluana_roshina on 14.07.2026.
//
import Foundation

final class AIWorkoutService: AIWorkoutServiceProtocol {
    private let apiKey = Secrets.claudeAPIKey
    private let baseURL = "https://api.anthropic.com/v1/messages"
    
    func generateExercises(goal: FitnessGoal, durationMinutes: Int) async throws -> [String] {
        let prompt = makePrompt(goal: goal, durationMinutes: durationMinutes)
        
        guard let url = URL(string:baseURL) else {
            throw URLError(.badURL)
        }
        let requestBody = ClaudeRequest(
            model: "claude-sonnet-4-6",
            max_tokens: 1024,
            messages: [.init(role: "user", content: prompt)]
        )
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
        request.setValue("2023-06-01", forHTTPHeaderField: "anthropic-version")
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        request.httpBody = try JSONEncoder().encode(requestBody)
        
        let(data, _) = try await URLSession.shared.data(for: request)
        
        let response = try JSONDecoder().decode(ClaudeResponse.self, from: data)
        
        let text = response.content.first?.text ?? ""
        let exercises = text
            .split(separator: "\n")
            .map { $0.trimmingCharacters(in: .whitespaces)}
            .filter { !$0.isEmpty }
        
        return exercises
    }
    
    private func makePrompt(goal: FitnessGoal, durationMinutes: Int) -> String {
        return
         """
            Составь список упражнений для тренировки.
            Цель: \(goal.rawValue).
            Длительность: \(durationMinutes) минут.
            Ответь только списком упражнений, каждое с новой строки, без нумерации и пояснений.
            """
    }
}
