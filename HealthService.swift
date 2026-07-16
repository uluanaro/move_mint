//
//  HealthService.swift
//  MoveMint
//
//  Created by uluana_roshina on 13.07.2026.
//
import Foundation
import HealthKit

enum HealthError: Error {
    case notAvailable
}

@MainActor
final class HealthService: HealthServiceProtocol {
    private let healthStore = HKHealthStore()
    
    func requestAuthorization() async throws {
        guard HKHealthStore.isHealthDataAvailable() else {
            throw HealthError.notAvailable
        }
        let stepCount = HKQuantityType(.stepCount)
        let typesToRead: Set = [stepCount]
        try await healthStore.requestAuthorization(toShare: [], read: typesToRead)
    }
    func todaySteps() async throws -> Int {
        let stepCount = HKQuantityType(.stepCount)
        let startOfDay = Calendar.current.startOfDay(for: Date())
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: Date())
        
        return try await withCheckedThrowingContinuation { continuation in
            let query = HKStatisticsQuery(quantityType: stepCount, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, error in
                if let error = error as? HKError, error.code == .errorNoData {
                    continuation.resume(returning: 0)
                    return
                }
                if let error {
                    continuation.resume(throwing: error)
                    return
                }
                let steps = result?.sumQuantity()?.doubleValue(for: .count()) ?? 0
                continuation.resume(returning: Int(steps))
            }
            healthStore.execute(query)
        }
    }
}

