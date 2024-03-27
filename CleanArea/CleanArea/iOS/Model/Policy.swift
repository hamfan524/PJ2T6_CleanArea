//
//  Policy.swift
//  CleanArea
//
//  Created by 이민호 on 12/11/23.
//

import Foundation


class Policy: ObservableObject {
    @Published var job: [YouthPolicy] = []
    @Published var residence: [YouthPolicy] = []
    @Published var education: [YouthPolicy] = []
    @Published var curture: [YouthPolicy] = []
    @Published var participation: [YouthPolicy] = []

    func getPolicy(_ policies: [YouthPolicy]) {
        job += filterPolicy(policies, Field.job.rawValue)
        residence += filterPolicy(policies, Field.residence.rawValue)
        education += filterPolicy(policies, Field.education.rawValue)
        curture += filterPolicy(policies, Field.curture.rawValue)
        participation += filterPolicy(policies, Field.participation.rawValue)
    }

    func filterPolicy(_ policies: [YouthPolicy], _ code: String) -> [YouthPolicy] {
        return policies.filter { $0.polyRlmCd == code }
    }
}
