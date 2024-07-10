//
//  ConditionTest.swift
//  WeSplit
//
//  Created by Kola on 2024/7/10.
//

import SwiftUI
struct LoadingView: View {
    var body: some View {
        Text("Loading...")
    }
}

struct SuccessView: View {
    var body: some View {
        Text("Success!")
    }
}

struct FailedView: View {
    var body: some View {
        Text("Failed.")
    }
}

struct ConditionTest: View {
    @State private var loadingState = LoadingState.loading

    
    enum LoadingState {
        case loading, success, failed
    }
    
    
    
    var body: some View {
        switch loadingState {
        case .loading:
            LoadingView()
        case .success:
            SuccessView()
        case .failed:
            FailedView()
        }
    }
}

#Preview {
    ConditionTest()
}
