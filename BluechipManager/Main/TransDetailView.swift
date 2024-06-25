//
//  TransDetailView.swift
//  BluechipManager
//
//  Created by admin on 6/25/24.
//



import SwiftUI

struct TransDetailView: View {
    
    @Environment(\.dismiss) var dismiss

    let trans: RealmWalTrans
    var completion: () -> ()
    
    var body: some View {
        NavigationView {
            ZStack {
                ZStack {
                    Rectangle()
                        .foregroundColor(.darkBlue)
                        .ignoresSafeArea()
                      
                    VStack {
                        Image(trans.transCategory)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .shadow(color: .white, radius: 1)
                        
                        HStack {
                            Rectangle()
                                .frame(height: 1)
                            Text("\(trans.transCategory)")
                                
                            Rectangle()
                                .frame(height: 1)
                        }
                        .foregroundColor(.white)
                        
                        HStack {
                            Text(trans.transType == "income" ? "+" : "-")
                            Text("\(trans.transValue, specifier: "%.2f")")
                            Text(UserDefaults.standard.string(forKey: "currency") ?? "")
                        }
                        .font(.system(size: 72, weight: .semibold))
                        .foregroundColor(trans.transType == "income" ? .green : .red)
                        
                        HStack {
                            Rectangle()
                                .frame(height: 1)
                            Text(formatDate(date: trans.transDate))
                                
                            Rectangle()
                                .frame(height: 1)
                        }
                        .foregroundColor(.white)
                        
                        Spacer()
                        if !trans.transNote.isEmpty {
                            VStack {
                                ScrollView {
                                    ZStack {
                                        Rectangle()
                                            .frame(height: screenSize().height / 1.5)
                                            .ignoresSafeArea()
                                            .foregroundColor(.darkBlue)
                                            .cornerRadius(24)
                                        VStack(alignment: .leading, spacing: 15) {
                                            
                                            if trans.transNote != "" {
                                                Text("Note:")
                                                    .foregroundColor(.gray)
                                                Text(trans.transNote)
                                                    .foregroundColor(.white)
                                            }
                                            
                                            if let imageData = trans.photoData {
                                                Text("Photo:")
                                                    .foregroundColor(.gray)
                                                
                                                Image(uiImage: UIImage(data: imageData) ?? UIImage())
                                                    .resizable()
                                                    .frame(width: 400, height: 400)
                                            }
                                            Spacer()
                                        }
                                        .padding()
                                        
                                    }
                                    
                                }
                                
                            }
                            .shadow(color: .gray.opacity(0.5), radius: 2)
                            .padding(.top, 20)
                        }
                    }
                    .padding(.top, 50)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        VStack {
                            HStack(spacing: 0) {
                                
                                Button {
                                    dismiss()
                                    completion()
                                } label: {
                                    Image(systemName: "chevron.left")
                                        .foregroundColor(.white)
                                        .bold()
                                }
                                
                                Text("Details")
                                    .foregroundColor(.white)
                                    .font(.system(size: 22, weight: .bold))
                                Spacer()
                            }
                            
                        }
                    }
                    .ignoresSafeArea()
                }
            }
        }
       
    }
    
    
    func formatDate(date: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
            return dateFormatter.string(from: date)
        }
}
