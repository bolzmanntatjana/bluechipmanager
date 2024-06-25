//
//  TransactionListView.swift
//  BluechipManager
//
//  Created by admin on 6/25/24.
//


import SwiftUI

struct TransactionListView: View {
    
    @State var height: CGFloat = 440
    
    let transactions: [RealmWalTrans]
    var completion: () -> ()
    var newTransaction: () -> ()

    
    var body: some View {
        VStack {
            Spacer()
            
            ZStack {
                Rectangle()
                    .foregroundColor(.darkBlue)
                    .cornerRadius(12, corners: [.topLeft, .topRight])
                    .shadow(color: .lightBlue, radius: 12)
                
                VStack  {
                    
                    HStack {
                        Text("Transactions")
                            .foregroundStyle(.white)
                            .font(.title)
                            .onTapGesture {
                                withAnimation {
                                    height = height == 440 ? screenSize().height - 100 : 440
                                }
                            }
                        
                        Spacer()
                        
                        Button {
                            newTransaction()
                        } label: {
                            Circle()
                                .stroke(lineWidth: 2.5)
                                .foregroundColor(.lightPink)
                                .frame(width: 40, height: 50)
                                .overlay {
                                    Image(systemName: "plus")
                                        .foregroundColor(.white)
                                }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.softBlue)
                    
                    List {
                        ForEach(transactions.reversed(), id: \.self) { transaction in
                            NavigationLink {
                                TransDetailView(trans: transaction) {
                                    completion()
                                }
                                    .onAppear {
                                        completion()
                                    }
                                    .navigationBarBackButtonHidden()
                            } label: {
                                VStack {
                                    HStack {
                                        Image(transaction.transCategory)
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                
                                        
                                        Text(transaction.transCategory)
                                            .padding(.leading)
                                        Spacer()
                                        Text(transaction.transType == "income" ? "+" : "-")
                                        Text("\(transaction.transValue, specifier: "%.2f")")
                                            .foregroundColor(transaction.transType == "income" ? .green : .red)
                                        Text(UserDefaults.standard.string(forKey: "currency") ?? "")
                                        
                                    }
                                    Rectangle()
                                        .frame(width: screenSize().width - 60, height: 1)
                                        .foregroundColor(.white)
                                }
                                
                            }

                        
                        }
                        .listRowBackground(Color.darkBlue.opacity(0.5))
                        .foregroundColor(.white)
                    }
                    .listStyle(.plain)
                .scrollContentBackgroundHidden()
                }
            }
         //   .frame(height: screenSize().height/1.8)
            .cornerRadius(12, corners: [.topLeft, .topRight])
            .hideScrollIndicator()
        }
        .padding(.bottom, 75)
        .ignoresSafeArea(edges: .bottom)
    }
}


#Preview {
    
    TransactionListView(transactions: [RealmWalTrans()]) {
        
    } newTransaction: {
        
    }

}
