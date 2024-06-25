//
//  MainView.swift
//  BluechipManager
//
//  Created by admin on 6/25/24.
//



import SwiftUI
import SwiftUICharts
import RealmSwift


struct MainView: View {
    
    @StateObject var vm = MainViewModel()
    @State private var isNewTransShown = false
    @State private var alertShowing = false
    @State private var scale: CGSize = CGSize(width: 0.0, height: 0.0)


    let style = ChartStyle(backgroundColor: .softBlue, accentColor: .lightPink, gradientColor: GradientColors.orngPink, textColor: .lightPink, legendTextColor: .lightPink, dropShadowColor: .darkBlue)

    var completion: () -> ()
    
    var body: some View {
        NavigationView {
            ZStack {
                BackView()
                
                VStack {
                    Rectangle()
                        .fill(LinearGradient(colors: [.darkBlue,.softBlue, .semiBlue], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .cornerRadius(12, corners: [.bottomLeft, .bottomRight])
                        .shadow(radius: 12)
                        .frame(height: 420)
                        .ignoresSafeArea()
                    
                    Spacer()
                }
            
                
                VStack {
                    HStack {
                        Text("Choose wallet:")
                            .foregroundColor(.white)
                            .opacity(0.5)
                        Spacer()
                        Picker("Select Wallet", selection: $vm.selectedWalletName) {
                            ForEach(vm.walletList, id: \.self) { wallet in
                                Text(wallet.name).tag(wallet.name)
                            }
                        }
                        .onChange(of: vm.selectedWalletName) { _ in
                            print(vm.selectedWalletName)
                            withAnimation {
                                vm.getWallet()
                                vm.getAllTrans()
                                vm.calculateTotalAndValues()
                            }
                        }
                        .tint(.white)
                    }
                    
                    
                    LineChartView(data: vm.values , title: "\(vm.selectedWallet.name)", style: style, form: ChartForm.extraLarge, rateValue: 0, dropShadow: true)
                        .preferredColorScheme(.light)
                        .overlay {
                            VStack {
                                HStack {
                                    Spacer()
                                    
                                    Button {
                                        withAnimation {
                                            alertShowing.toggle()
                                            scale = CGSize(width: 1, height: 1)
                                        }
                                    } label: {
                                        Image(systemName: "plus")
                                            .font(.title2)
                                            .foregroundColor(.lightPink)
                                    }
                                }
                                
                                Spacer()
                            }
                            .padding(20)
                        }
                        .overlay {
                            if vm.values.count < 2 {
                                Button {
                                    
                                } label: {
                                    Rectangle()
                                        .foregroundColor(.black)
                                        .cornerRadius(12)
                                        .opacity(0.2)
                                }
                                .disabled(true)
                                .overlay {
                                    VStack {
                                        HStack {
                                            Spacer()
                                            
                                            Button {
                                                withAnimation {
                                                    alertShowing.toggle()
                                                    scale = CGSize(width: 1, height: 1)
                                                }
                                            } label: {
                                                Image(systemName: "plus")
                                                    .font(.title2)
                                                    .foregroundColor(.lightPink)
                                            }
                                        }
                                        
                                        Spacer()
                                    }
                                    .padding(20)
                                }
                            }
                        }
                    
                    HStack {
                        Text("Balance:")
                            .font(.title)
                            .foregroundStyle(.white)
                        
                        Spacer()
                        
                        Text("\(vm.total, specifier: "%.2f") $")
                            .font(.title)
                            .foregroundStyle(.white)
                    }
                    .padding(.top)
                    
                    
                    
                    
                    Spacer()
                    
                    TransactionListView(transactions: vm.trans) {
                        completion()
                    } newTransaction: {
                        isNewTransShown.toggle()
                    }
                    .padding(.top)
                }
                .padding(.horizontal)
            }
            .onAppear {
                DataManager.shared.createInit()
                vm.getAllWallets()
                vm.getFirstList()
                vm.getAllTrans()
                vm.calculateTotalAndValues()
            }
            .overlay {
                VStack {
                    
                }
            }
            .overlay {
                if alertShowing {
                    ZStack {
                        Rectangle()
                            .ignoresSafeArea()
                            .background(.ultraThinMaterial)
                            .onTapGesture {
                                withAnimation {
                                    alertShowing.toggle()
                                }
                                withAnimation(.easeIn(duration: 0.3)) {
                                    scale = CGSize(width: 0, height: 0)
                                }
                            }
                        AlertView() { name in
                            vm.getAllWallets()
                            vm.selectedWalletName = name
                            vm.getWallet()
                            withAnimation {
                                alertShowing.toggle()
                                scale = CGSize(width: 0, height: 0)
                            }
                        }
                            .scaleEffect(scale)
                    }
                    .ignoresSafeArea()
                }
            }
        }
        .preferredColorScheme(.light)
        .accentColor(.white)
        .fullScreenCover(isPresented: $isNewTransShown) {
            NewTransactionView(selectedWallet: $vm.selectedWallet) {
                vm.getAllWallets()
                vm.getAllTrans()
                vm.calculateTotalAndValues()
            }
        }
    }
}






#Preview {
    MainView() {
        
    }
}
