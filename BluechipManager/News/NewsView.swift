//
//  NewsView.swift
//  BluechipManager
//
//  Created by admin on 6/25/24.
//


import SwiftUI

struct NewsView: View {
    
    var completion: () -> ()
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackView()
                
                VStack {
                    HStack {
                        NavigationLink {
                            FinanceNewsView() {
                                completion()
                            }
                                .navigationBarBackButtonHidden()
                                .onAppear {
                                    completion()
                                }
                        } label: {
                            ZStack {
                                Rectangle()
                                    .foregroundStyle(Color.softBlue)
                                    .shadow(radius: 12)
                                    .glow(.white, radius: 12)
                                    .frame(width: screenSize().width / 2.2, height: 200)
                                    .cornerRadius(12)
                                
                                
                                VStack {
                                    Text("Finance News")
                                        .foregroundColor(.white)
                                        .font(.system(size: 20, weight: .semibold))

                                    Image("finance")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                                }
                            }
                        }

                        NavigationLink {
                            CurrencyNewsView() {
                                completion()
                            }
                                .navigationBarBackButtonHidden()
                                .onAppear {
                                    completion()
                                }
                        } label: {
                            ZStack {
                                Rectangle()
                                    .foregroundStyle(Color.softBlue)
                                    .shadow(radius: 12)
                                    .glow(.white, radius: 12)
                                    .frame(width: screenSize().width / 2.2, height: 200)
                                    .cornerRadius(12)
                                
                                
                                VStack {
                                    Text("Currency News")
                                        .foregroundColor(.white)
                                        .font(.system(size: 20, weight: .semibold))

                                    Image("currency")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                                }
                            }
                        }
                    }
                    
                    Spacer()
                }
            }
            //MARK: - NavBar
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        VStack {
                            HStack {
                                
                                Text("News")
                                    .font(.system(size: 28, weight: .black))
                                    .foregroundColor(Color.white)
                                
                                Spacer()
                            }
                        }
                        Spacer()
                    }
                    .ignoresSafeArea()
                }
            }
        }
    }
}

#Preview {
    NewsView(){}
}
