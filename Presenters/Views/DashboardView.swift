import SwiftUI

struct DashboardView: View {
    @StateObject private var viewModel = DependencyFactory.shared.makeDashboardViewModel()
    
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                
                VStack(spacing: 8) {
                    Text("\(viewModel.steps)")
                        .font(.system(size: 60, weight: .bold))
                    Text("шагов сегодня")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                }
                .accessibilityElement(children: .ignore)
                .accessibilityLabel("\(viewModel.steps) шагов сегодня")
                RouteMapView()
                    .accessibilityLabel("Карта вашего маршрута за сегодня")
                Picker("Цель", selection: $viewModel.selectedGoal) {
                    ForEach(FitnessGoal.allCases) { goal in
                        Text(goal.rawValue).tag(goal)
                    }
                }
                .pickerStyle(.segmented)
                Button {
                    Task { await viewModel.generateWorkout()}
                } label: {
                    if viewModel.isLoading {
                        ProgressView()
                    } else {
                        Text("Составить тренировку")
                    }
                }
                .accessibilityLabel(viewModel.isLoading ? "Создается тренировка" :"Составить тренировку")
                .buttonStyle(.borderedProminent)
                .disabled(viewModel.isLoading)
                if let workout = viewModel.workout {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Тренировка на \(workout.durationMinutes) минут")
                            .font(.headline)
                        ForEach(workout.exercises, id: \.self) { exercise in
                            HStack {
                                Image(systemName: "checkmark.circle")
                                    .foregroundStyle(.green)
                                    .accessibilityHidden(true)
                                Text(exercise)
                            }
                            
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                Spacer()
                
            }
            .padding()
            .navigationTitle("MoveMint")
            .task {
                await viewModel.loadSteps()
            }
        }
    }
}
#Preview {
    DashboardView()
}
