//
//  ContentView.swift
//  MoveMint
//
//  Created by uluana_roshina on 13.07.2026.
//

import SwiftUI

struct ContentView: View {
    @State private var healthService = HealthService()
    @State private var steps: Int?
    @State private var status = "Не запрошено"
    
    var body: some View {
        VStack(spacing: 20) {
            Text(status)
            if let steps {
                Text("\(steps) шагов сегодня")
                    .font(.largeTitle)
            }
            Button("Загрузить шаги") {
                Task {
                    do {
                        try await healthService.requestAuthorization()
                        steps = try await healthService.todaySteps()
                        status = "Готово ✅"
                        
                    } catch {
                        status = "Ошибка: \(error)"
                    }
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}
#Preview {
    ContentView()
}
