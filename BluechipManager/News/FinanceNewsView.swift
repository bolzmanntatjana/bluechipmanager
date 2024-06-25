//
//  FinanceNewsView.swift
//  BluechipManager
//
//  Created by admin on 6/25/24.
//


import SwiftUI

struct FinanceNewsView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var news: [News] = []
    @State private var isShown = false
    
    var completion: () -> ()
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackView()
                
                if !news.isEmpty {
                    ScrollView {
                        VStack {
                            ForEach(news, id: \.self) { newsElement in
                                Button {
                                    isShown.toggle()
                                } label: {
                                    NewsCell(article: newsElement.articleTitle, image: newsElement.articlePhotoURL)
                                }
                                .fullScreenCover(isPresented: $isShown) {
                                    NewsDetailView(articleTitle: newsElement.articleTitle, articleURL: newsElement.articleURL, articlePhotoURL: newsElement.articlePhotoURL, source: newsElement.source, postTimeUTC: newsElement.postTimeUTC)
                                }
                               
                            }
                        }
                        .padding(.top)
                    }
                    .hideScrollIndicator()
                } else {
                    ProgressView()
                        .controlSize(.large)
                        
                }
               
              
            }
            .onAppear {
                NetworkManager.shared.getNews { data, error in
                    if let data = data {
                        news = data.data.news
                    }
                }
            }
            .modifier(NavBarBackground())
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

                                }
                                .padding(.trailing)


                                
                                Text("Finance News")
                                    .font(.system(size: 32, weight: .bold))
                                    .foregroundColor(.white)
                                Spacer()
                            }
                        }
                    }
                    .ignoresSafeArea()
                }
            }
        }
     
    }
}

#Preview {
    FinanceNewsView(){}
}
