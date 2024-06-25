//
//  AlertView.swift
//  BluechipManager
//
//  Created by admin on 6/25/24.
//


import SwiftUI

struct AlertView: View {
    
    var completion: (String) -> ()
    @State private var text = ""
    
    var body: some View {
        Rectangle()
            .foregroundColor(.darkBlue)
            .frame(width: screenSize().width - 50, height: 200)
            .cornerRadius(12)
            .shadow(color: .softBlue.opacity(0.3), radius: 10)
            .overlay {
                VStack {
                    Text("Write wallet name:")
                        .foregroundColor(.white)
                        .font(.title)
                        .padding(.top)
                    Spacer()
                    TextField("", text: $text)
                        .tint(.red)
                        .foregroundColor(.white)
                        .foregroundColor(.darkBlue)
                        .padding(.horizontal, 40)
                        .background {
                            Rectangle()
                                .foregroundColor(.softBlue)
                                .frame(height: 50)
                                .cornerRadius(12)
                                .padding(.horizontal, 30)
                                .shadow(color: .lightBlue, radius: 1)

                        }
                    Spacer()
                    
                    Button {
                        if !text.isEmpty {
                            StorageManager.shared.createWallet(name: text)
                            completion(text)
                        }
                    } label: {
                        Rectangle()
                            .frame(height: 50)
                            .cornerRadius(14)
                            .foregroundColor(.softBlue)
                            .overlay {
                                Text("Add")
                                    .foregroundColor(.lightPink)
                                    .bold()
                            }
                            .padding(.horizontal, 30)
                    }
                    Spacer()
                }
                
            }
    }
}


#Preview {
    AlertView(){_ in }
}
