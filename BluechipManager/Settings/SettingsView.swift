//
//  SettingsView.swift
//  BluechipManager
//
//  Created by admin on 6/25/24.
//

import SwiftUI
import MessageUI


struct SettingsView: View {
    
    @State private var showingMailWithError = false
    @State private var showingMailWithSuggestion = false
    @State private var selectedCurrency: String = ""
    @State private var isAnimationShown = false
    var currency: [String] = ["$", "€", "£", "¥", "฿", "₺", "₹", "₩", "₴", "R$", "د.إ", "₪", "₨", "S/."]
    
    var body: some View {
        NavigationView {
            ZStack {
                BackView()
                
                Form {
                    
                    Section {
                        HStack {
                            Text("Currency")
                                .foregroundColor(.white)
                            Spacer()
                            Text(selectedCurrency)
                                .foregroundColor(.green)
                        }
                        .contextMenu {
                            ForEach(currency, id: \.self) { text in
                                Button {
                                    selectedCurrency = text
                                    UserDefaults.standard.set(text, forKey: "currency")
                                } label: {
                                    Text(text)
                                }
                            }
                        }
                    } header: {
                        Text("App")
                            .foregroundColor(Color.gray)
                    } footer: {
                        Text("Long press for action")
                            .foregroundColor(Color.gray)
                    }
                    .listRowBackground(Color.softBlue)
                    
                    Section {
                        Button {
                            showingMailWithError.toggle()
                        } label: {
                            Text("Report a bug")
                        }
                        .sheet(isPresented: $showingMailWithError) {
                            MailComposeView(isShowing: $showingMailWithError, subject: "Error message", recipientEmail: "Noah_Lundgren1@outlook.dk")
                        }
                        
                        Button {
                            showingMailWithSuggestion.toggle()
                        } label: {
                            Text("Suggest improvement")
                        }
                        .sheet(isPresented: $showingMailWithSuggestion) {
                            MailComposeView(isShowing: $showingMailWithSuggestion, subject: "Improvement suggestion", recipientEmail: "Noah_Lundgren1@outlook.dk")
                        }
                    } header: {
                        Text("Support")
                            .foregroundColor(Color.gray)
                    }
                    .listRowBackground(Color.softBlue)
                    
                    Section {
                        Button {
                            openPrivacyPolicy()
                        } label: {
                            Text("Privacy Policy")
                        }
                    } header: {
                        Text("Usage")
                            .foregroundColor(Color.gray)
                    }
                    .listRowBackground(Color.softBlue)
                    
                    
                    Section {
                        Text("Delete all data")
                            .contextMenu {
                                Button {
                                    StorageManager.shared.removeData()
                                    StorageManager.shared.createWallet(name: "Total")
                                    print("deleted")
                                    isAnimationShown.toggle()
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                        fatalError("closed when deleted")
                                    }
                                } label: {
                                    VStack {
                                        Text("Yes, I want to delete all data. The App will restart")
                                        Text("You will need to resrart the app")
                                    }
                                    
                                        
                                }
                                
                                Button {
                                    
                                } label: {
                                    Text("No, I changed my mind")
                                }
                            }
                            .foregroundColor(Color.red)
                    } header: {
                        Text("Danger zone")
                            .foregroundColor(Color.red)
                    } footer: {
                        Text("Long press for action")
                            .foregroundColor(Color.gray)
                    }
                    .listRowBackground(Color.softBlue)
                    
                }
                .tint(.white)
                .modifier(FormBackgroundModifier())
            }
            .onAppear {
                selectedCurrency = UserDefaults.standard.string(forKey: "currency") ?? ""
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        VStack {
                            HStack(spacing: 0) {
                                
                                Text("Settings")
                                    .foregroundColor(.white)
                                Spacer()
                            }
                            .font(.system(size: 32, weight: .bold))
                        }
                    }
                    .ignoresSafeArea()
                }
            }
        }
    }
    
    func openPrivacyPolicy() {
        if let url = URL(string: "https://bluechipmanager.shop/com.BluechipManager/Bolzmann_Tatjana/privacy") {
            UIApplication.shared.open(url)
        }
    }
}

#Preview {
    SettingsView()
}


struct MailComposeView: UIViewControllerRepresentable {
    @Binding var isShowing: Bool
    let subject: String
    let recipientEmail: String
    
    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let mailComposer = MFMailComposeViewController()
        mailComposer.setSubject(subject)
        mailComposer.setToRecipients([recipientEmail])
        mailComposer.mailComposeDelegate = context.coordinator
        return mailComposer
    }
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        let parent: MailComposeView
        
        init(_ parent: MailComposeView) {
            self.parent = parent
        }
        
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            parent.isShowing = false
        }
    }
}


struct FormBackgroundModifier: ViewModifier {
    
    @ViewBuilder
    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content
                .scrollContentBackground(.hidden)
        } else {
            content
        }
    }
}
