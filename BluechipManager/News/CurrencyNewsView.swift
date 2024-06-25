//
//  CurrencyNewsView.swift
//  BluechipManager
//
//  Created by admin on 6/25/24.
//



import SwiftUI

struct CurrencyNewsView: View {
    
    @Environment(\.dismiss) var dismiss

    
    @State private var news: [CNews] = []
    
    @State private var fromCurrency: Currency = Currency.USD
    @State private var toCurrency: Currency = Currency.EUR
    @State private var isShown = false
    
    var completion: () -> ()

    
    var body: some View {
        NavigationStack {
            ZStack {
                BackView()
                
                VStack {
                    Rectangle()
                        .frame(height: 100)
                        .foregroundStyle(Color.softBlue)
                        .overlay {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("From")
                                    
                                    Picker("", selection: $fromCurrency) {
                                        ForEach(Currency.allCases) { currency in
                                            Text(String(describing: currency)).tag(currency)
                                        }
                                        
                                    }
                                    .accentColor(Color.lightPink)
                                }
                                
                                HStack {
                                    Text("To")
                                    
                                    Picker("", selection: $toCurrency) {
                                        ForEach(Currency.allCases) { currency in
                                            Text(String(describing: currency)).tag(currency)
                                        }
                                    }
                                    .accentColor(Color.lightPink)
                                    
                                }
                            }
                            .foregroundStyle(.white)
                            .frame(width: screenSize().width - 40, alignment: .leading)
                            .onChange(of: fromCurrency) { _ in
                                news = []
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    NetworkManager.shared.getCurrencyNews(fromCurrency: String(describing: fromCurrency), toCurrency: String(describing: toCurrency)) { data, error in
                                        if let data = data {
                                            news = data.data.news
                                        }
                                    }
                                }
                            }
                            .onChange(of: toCurrency) { _ in
                                news = []
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    NetworkManager.shared.getCurrencyNews(fromCurrency: String(describing: fromCurrency), toCurrency: String(describing: toCurrency)) { data, error in
                                        if let data = data {
                                            news = data.data.news
                                        }
                                    }
                                }
                            }
                        }
                    
                    Spacer()
                    
                    
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
                    
                    Spacer()
                }
                
                
            }
            .onAppear {
                NetworkManager.shared.getCurrencyNews(fromCurrency: String(describing: fromCurrency), toCurrency: String(describing: toCurrency)) { data, error in
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

                                
                                Text("Currency News")
                                    .foregroundColor(.white)
                                    .font(.system(size: 32, weight: .bold))

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
    CurrencyNewsView(){}
}
