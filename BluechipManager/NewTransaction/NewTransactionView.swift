//
//  NewTransactionView.swift
//  BluechipManager
//
//  Created by admin on 6/25/24.
//

import SwiftUI

enum TransactionSelection: String {
    case empty = ""
    case plus = "income"
    case minus = "expense"
}

struct NewTransactionView: View {
    
    @Environment(\.dismiss) var dismiss
    @FocusState private var isTextFieldFocused: Bool
    @Binding var selectedWallet: RealmWallet

    @State var selectedCategory: String = "Select"
    @State private var value = "0"
    @State private var note = ""
    
    @State private var isNoteShowing = false
    @State private var isBottomSheetShowning = false
    @State private var isCatShowning = false

    
    @State private var transType = TransactionSelection.empty
    @State private var keyboardHeight: CGFloat = 0
    @State private var scale: CGSize = CGSize(width: 0.0, height: 0.0)
    
    
    @State private var image: UIImage?
    
    var closing: () -> ()
    
    var body: some View {
        
        ZStack {
            BackView()
            
            ScrollView {
                VStack {
                    
                    Text("New Transaction")
                        .frame(width: screenSize().width)
                        .foregroundStyle(.white)
                        .font(.title)
                        .bold()
                        .overlay {
                            HStack {
                                Button {
                                    dismiss()
                                } label: {
                                    Image(systemName: "xmark")
                                }
                                .foregroundColor(.white)
                                
                                Spacer()
                            }
                            .padding(.leading)
                        }
                    
                    HStack {
                        Text("Category:")
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .padding(.top)
                    .padding(.horizontal, 30)
                    
                    HStack {
                        Button {
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            withAnimation {
                                isCatShowning.toggle()
                                scale = CGSize(width: 1, height: 1)
                            }
                        } label: {
                            Rectangle()
                                .frame(width: screenSize().width - 250, height: 70)
                                .cornerRadius(14)
                                .foregroundColor(.lightBlue.opacity(0.5))
                                .overlay {
                                    Text(selectedCategory)
                                        .foregroundColor(.white)
                                        .bold()
                                }
                        }
                        
                        
                        Button {
                            withAnimation {
                                isBottomSheetShowning = true
                            }
                        } label: {
                            Rectangle()
                                .frame(height: 70)
                                .cornerRadius(14)
                                .foregroundColor(.lightBlue.opacity(0.5))
                                .overlay {
                                    Image(systemName: "photo.on.rectangle")
                                        .foregroundColor(.white)
                                }
                        }
                        .tint(.white)
                        
                        
                        Button {
                            withAnimation {
                                isNoteShowing.toggle()
                                if isNoteShowing {
                                    isTextFieldFocused = true
                                }
                            }
                            
                        } label: {
                            Rectangle()
                                .frame(height: 70)
                                .cornerRadius(14)
                                .foregroundColor(.lightBlue.opacity(0.5))
                                .overlay {
                                    Image(systemName: "note.text")
                                        .foregroundColor(.white)
                                }
                        }
                        .tint(.white)
                    }
                    .padding(.horizontal, 30)
                    .padding(.bottom)
                    
                    HStack(spacing: 10) {
                        VStack {
                            HStack {
                                Text("Value:")
                                    .font(.footnote)
                                    .foregroundColor(.white)
                                Spacer()
                            }
                            
                            Rectangle()
                                .frame(width: screenSize().width - 220, height: 70)
                                .cornerRadius(14)
                                .foregroundColor(.lightBlue.opacity(0.5))
                                .overlay {
                                    TextField("", text: $value)
                                        .foregroundColor(.white)
                                        .padding(.horizontal)
                                        .keyboardType(.numberPad)
                                }
                        }
                        VStack {
                            HStack {
                                Text("Type of transaction:")
                                    .font(.footnote)
                                    .foregroundColor(.white)
                                Spacer()
                            }
                            
                            HStack {
                                Button {
                                    transType = .plus
                                } label: {
                                    Rectangle()
                                        .frame(height: 70)
                                        .cornerRadius(14)
                                        .foregroundColor(transType == .plus ? .green : .lightBlue.opacity(0.5))
                                        .overlay {
                                            Image(systemName: "plus")
                                                .foregroundColor(.white)
                                        }
                                }
                                .tint(.white)
                                
                                
                                Button {
                                    transType = .minus
                                } label: {
                                    Rectangle()
                                        .frame(height: 70)
                                        .cornerRadius(14)
                                        .foregroundColor(transType == .minus ? .red : .lightBlue.opacity(0.5))
                                        .overlay {
                                            Image(systemName: "minus")
                                                .foregroundColor(.white)
                                        }
                                }
                                .tint(.white)
                                
                                Spacer()
                            }
                        }
                    }
                    .padding(.bottom)
                    .padding(.leading, 30)
                    .padding(.trailing, 20)
                    
                    if isNoteShowing {
                        HStack {
                            Text("Note:")
                                .font(.footnote)
                                .foregroundColor(.white)
                            Spacer()
                        }
                        .padding(.horizontal, 30)
                        
                        Rectangle()
                            .frame(height: 180)
                            .cornerRadius(20)
                            .foregroundColor(.lightBlue.opacity(0.5))
                            .overlay {
                                ZStack {
                                    if note.isEmpty {
                                        VStack {
                                            Text("Here you can leave a note about income or expenses.")
                                                .foregroundColor(.gray)
                                                .opacity(0.2)
                                                .padding(.top, 10)
                                                .padding(.leading, 13)
                                            Spacer()
                                        }
                                    }
                                    
                                    TextEditor(text: $note)
                                        .focused($isTextFieldFocused)
                                        .foregroundColor(.white)
                                        .padding(.horizontal)
                                        .scrollContentBackgroundHidden()
                                }
                            }
                            .padding(.horizontal, 30)
                            .padding(.bottom)
                    }
                    
                    if let image = image {
                        VStack {
                            HStack {
                                Text("Image:")
                                    .font(.footnote)
                                    .foregroundColor(.red)
                                Spacer()
                            }
                            
                            
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 200, height: 200)
                                .cornerRadius(12)
                        }
                        .padding(.bottom, 20)
                        .padding(.horizontal, 30)
                        
                    }
                    
                    Button {
                        if selectedCategory == "Select" {
                            selectedCategory = "Other"
                        }
                        StorageManager.shared.newsTrans(wallet: selectedWallet, value: Double(value) ?? 0, category: selectedCategory, note: note, type: transType.rawValue, image: image)
                        dismiss()
                        closing()
                        
                    } label: {
                        Rectangle()
                            .frame(height: 70)
                            .cornerRadius(14)
                            .foregroundColor(.lightBlue.opacity(0.5))
                            .overlay {
                                Text("Add")
                                    .foregroundColor(.white)
                                    .bold()
                            }
                            .padding(.horizontal, 30)
                    }
                    .disabled(checkFields())
                    .opacity(checkFields() ? 0.5 : 1)
                    
                }
                .onAppear {
                    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
                        if let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                            withAnimation {
                                keyboardHeight = keyboardSize.height
                            }
                        }
                    }
                    
                    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
                        withAnimation {
                            keyboardHeight = 0
                        }
                    }
                }
                .onDisappear {
                    NotificationCenter.default.removeObserver(self)
                }
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        
                        Spacer()
                        Button("Done") {
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }
                        
                        
                    }
                }
            }
        }
        .overlay(content: {
            if isCatShowning {
                ZStack {
                    Rectangle()
                        .ignoresSafeArea()
                        .background(.ultraThinMaterial)
                        .onTapGesture {
                            withAnimation {
                                isCatShowning.toggle()
                            }
                            withAnimation(.easeIn(duration: 0.3)) {
                                scale = CGSize(width: 0, height: 0)
                            }
                        }
                    CatView() { text in
                        selectedCategory = text
                        isCatShowning.toggle()
                    }
                        .scaleEffect(scale)
                }
                .ignoresSafeArea()
            }
        })
        .sheet(isPresented: $isBottomSheetShowning) {
            BottomImagePickerView(image: $image) {
                withAnimation {
                    isBottomSheetShowning = false
                }
            } closing: {
                isBottomSheetShowning = false
            }
            .presentationDetents([.height(150)])
            .presentationDragIndicator(.automatic)
        }
    }
    
    func clear() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        value = "0"
        selectedCategory = "Choose"
        transType = .empty
        note = ""
        image = nil
        isNoteShowing = false
        isBottomSheetShowning = false
    }
    
    func checkFields() -> Bool {
        if !value.isEmpty, value != "0", !selectedCategory.isEmpty, selectedCategory != "Choose", transType != .empty {
            return false
        } else {
            return true
        }
    }
}


#Preview {
    NewTransactionView(selectedWallet: .constant(RealmWallet())){}
}
