//
//  Snackbar.swift
//  ToDo
//
//  Created by Kyaw Thiha on 18/11/2025.
//

import SwiftUI

struct SnackbarModifier: ViewModifier {
    @Binding var isShowing: Bool
    let message: String
    
    func body(content: Content) -> some View {
        ZStack {
            content // The main view content
            if isShowing {
                VStack {
                    Spacer()
                    
                    Text(message)
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.8))
                        .cornerRadius(25)
                        .padding(.bottom, 20)
                        .shadow(radius: 5)
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .zIndex(1) // Ensures it stays on top
                .onAppear {
                    // Auto-dismiss after 1 seconds
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        withAnimation {
                            isShowing = false
                        }
                    }
                }
            }
        }
    }
}

// I changed the name from 'snackbar' to 'showSnackbar'
extension View {
    func showSnackbar(isShowing: Binding<Bool>, message: String) -> some View {
        self.modifier(SnackbarModifier(isShowing: isShowing, message: message))
    }
}
