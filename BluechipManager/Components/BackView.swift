//
//  BackView.swift
//  BluechipManager
//
//  Created by admin on 6/25/24.
//


import SwiftUI

struct BackView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.darkBlue)
                .ignoresSafeArea()
        }
    }
}

#Preview {
    BackView()
}
