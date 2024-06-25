//
//  CategoriesView.swift
//  BluechipManager
//
//  Created by admin on 6/25/24.
//


import SwiftUI

struct CatView: View {
    
    @State var placeholder = "1"
    @State var cats: [RealmCategory] = []
    var completion: (String) -> ()
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.darkBlue)
                .cornerRadius(12)
                .padding(.horizontal, 30)
                .padding(.vertical, 140)
                .shadow(radius: 10)
                .overlay {
                    List {
                        ForEach(cats, id: \.self) { cat in
                            Button {
                                withAnimation {
                                    placeholder = cat.name
                                    completion(placeholder)
                                }
                            } label: {
                                LazyVStack {
                                    HStack {
                                        Image(cat.name)
                                            .resizable()
                                            .frame(width: 60, height: 60)
                                           // .colorInvert()
                                            .padding()
                                        Spacer()
                                        Text(cat.name)
                                            .font(.system(size: 22, weight: .bold))
                                            .foregroundColor(.white)
                                        Spacer()
                                    }
                                    Rectangle()
                                        .frame(width: screenSize().width - 60, height: 1)
                                        .foregroundColor(.lightBlue.opacity(0.3))
                                }
                                
                            }
                        }
                        .listRowBackground(Color.clear)
                    }
                    .scrollContentBackgroundHidden()
                    .cornerRadius(12)
                    .listStyle(.plain)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 140)
                    
                }
        }
        .onAppear {
            cats = Array(StorageManager.shared.categories)
        }
    }
}

#Preview {
    CatView(){_ in}
}


class CatViewModel: ObservableObject {
    @Published var category = "Choose"
}
