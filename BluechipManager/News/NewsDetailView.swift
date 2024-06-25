//
//  NewsDetailView.swift
//  BluechipManager
//
//  Created by admin on 6/25/24.
//



import SwiftUI

struct NewsDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    
    let articleTitle: String
    let articleURL: String
    let articlePhotoURL: String
    let source: String
    let postTimeUTC: String
    
    
    var body: some View {
        ZStack {
            BackView()
            
            VStack {
                Text("News Detail")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .bold()
                
                Spacer()
            }
            
            VStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                        .bold()
                }
                
                Spacer()
            }
            .padding(.leading, 20)
            .padding(.top, 10)
            .frame(width: screenSize().width, alignment: .leading)
            
            ScrollView {
                VStack(alignment: .leading) {
                    VStack {
                        if let url = URL(string: articlePhotoURL) {
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: screenSize().width, height: 300)
                                    .cornerRadius(12)
                                
                            } placeholder: {
                                ProgressView()
                                    .frame(width: 200, height: 200)
                            }
                            
                        }
                    }
                    .frame(height: 300)
                    
                    VStack(alignment: .leading) {
                        Text(articleTitle)
                            .font(.title)
                            .bold()
                            .foregroundStyle(.white)
                            .padding(.horizontal)
                        
                        Text(postTimeUTC)
                            .padding(.vertical)
                            .padding(.leading, 20)
                            .foregroundStyle(.white)
                        
                        Text(source)
                            .padding()
                            .background {
                                Rectangle()
                                    .foregroundColor(.white)
                                    .cornerRadius(12)
                            }
                            .padding(.leading, 10)
                        
                        
                        
                        Button {
                            openSafari()
                        } label: {
                            Text("Open in Safari")
                                .padding()
                                .background {
                                    Rectangle()
                                        .foregroundColor(.white)
                                        .cornerRadius(12)
                                }
                                .padding(.leading, 10)
                        }
                        
                    }
                    
                }
                
            }
            .padding(.top, 60)
            .hideScrollIndicator()
        }
    }
    
    func openSafari() {
        if let url = URL(string: articleURL) {
            UIApplication.shared.open(url)
        }
    }
}

#Preview {
    NewsDetailView(articleTitle: News.MOCK.articleTitle, articleURL: News.MOCK.articleURL, articlePhotoURL: News.MOCK.articlePhotoURL, source: News.MOCK.source, postTimeUTC: News.MOCK.postTimeUTC)
}
