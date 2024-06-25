//
//  NewsCell.swift
//  BluechipManager
//
//  Created by admin on 6/25/24.
//



import SwiftUI

struct NewsCell: View {
    
   // let newsElement: News
    let article: String
    let image: String
    
    var body: some View {
        VStack {
            
            if let url = URL(string: image) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 300, height: 200)
                        .cornerRadius(12)
                    
                } placeholder: {
                    ProgressView()
                        .frame(width: 200, height: 200)
                }
                
            }
            
            Text(article)
                .font(.system(size: 18, weight: .semibold))
                .padding(.top)
                .frame(width: 300)
                .foregroundStyle(.white)
        }
       
        .padding()
        .background {
            Rectangle()
                .foregroundStyle(Color.softBlue)
                .cornerRadius(12)
        }
    }
}
//
//#Preview {
//    NewsCell(newsElement: .MOCK)
//}
