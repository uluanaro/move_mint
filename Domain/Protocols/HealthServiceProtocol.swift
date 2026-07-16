//
//  HealthServiceProtocol.swift
//  MoveMint
//
//  Created by uluana_roshina on 13.07.2026.
//
protocol HealthServiceProtocol {
    func requestAuthorization() async throws
    func todaySteps() async throws -> Int
}
