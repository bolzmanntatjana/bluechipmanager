//
//  ConversionView.swift
//  BluechipManager
//
//  Created by admin on 6/25/24.
//


import SwiftUI

enum ButtonType: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case subtract = "-"
    case divide = "÷"
    case multiply = "×"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case reverse = "⇵"
    case convert = "Convert"
}

enum ArithmeticOperation {
    case add, subtract, multiply, divide, none
}

struct ConversionView: View {
    
    @State var firstCurrency = Currency.USD
    @State var secondCurrency = Currency.EUR
    
    @State var displayValue = "0"
    @State var convertedValue = "0"
    @State var runningValue = 0
    @State var currentOperation: ArithmeticOperation = .none
    
    var completion: () -> ()
    
    let buttons: [[ButtonType]] = [
        [.clear, .reverse, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .convert, .equal],
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.softBlue.edgesIgnoringSafeArea(.all)
                
                VStack {
                    if screenSize().height > 737 {
                        Text("Converter")
                            .bold()
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                            .frame(width: screenSize().width - 30, alignment: .leading)
                            .padding()
                            .background {
                                Rectangle()
                                    .foregroundColor(.darkBlue)
                                    .ignoresSafeArea()
                            }
                            .padding(.bottom, -20)
                    }
                    
                    VStack {
                        VStack {
                            HStack {
                                NavigationLink {
                                    CurrencyView() { cur in
                                        firstCurrency = cur
                                    } onDisappear: {
                                        completion()
                                    }
                                    .onAppear {
                                        completion()
                                    }
                                    .navigationBarBackButtonHidden()
                                } label: {
                                    Circle()
                                        .frame(width: 60)
                                        .overlay {
                                            Text(String(describing: firstCurrency))
                                                .foregroundColor(.darkBlue)
                                                .font(.system(size: 20))
                                        }
                                }
                                
                                
                                Spacer()
                                Text(displayValue)
                            }
                            .frame(height: 50)
                            .padding(.horizontal, 30)
                            
                            Rectangle()
                                .frame(height: 1)
                                .padding(.vertical)
                            
                            HStack {
                                NavigationLink {
                                    CurrencyView() { cur in
                                        secondCurrency = cur
                                    } onDisappear: {
                                        completion()
                                    }
                                    .onAppear {
                                        completion()
                                    }
                                    .navigationBarBackButtonHidden()
                                    
                                } label: {
                                    Circle()
                                        .frame(width: 60)
                                        .overlay {
                                            Text(String(describing: secondCurrency))
                                                .foregroundColor(.darkBlue)
                                                .font(.system(size: 20))
                                        }
                                }
                                Spacer()
                                Text(convertedValue)
                                
                            }
                            .frame(height: 50)
                            .padding(.horizontal, 30)
                            
                            // Spacer()
                        }
                        .padding(.vertical, 30)
                        .bold()
                        .font(.system(size: 60))
                        .foregroundColor(.white)
                    }
                    .background {
                        Rectangle()
                            .cornerRadius(24, corners: [.bottomLeft, .bottomRight])
                            .foregroundColor(.darkBlue)
                            .ignoresSafeArea()
                    }
                    
                    //                    Rectangle()
                    //                        .frame(height: calculateCardHeight())
                    //                        .cornerRadius(24, corners: [.bottomLeft, .bottomRight])
                    //                        .foregroundColor(.darkBlue)
                    //                        .ignoresSafeArea()
                    //                        .overlay {
                    //                            VStack {
                    //                                VStack {
                    //                                    HStack {
                    //                                        NavigationLink {
                    //                                            CurrencyView() { cur in
                    //                                                firstCurrency = cur
                    //                                            } onDisappear: {
                    //                                                completion()
                    //                                            }
                    //                                            .onAppear {
                    //                                                completion()
                    //                                            }
                    //                                            .navigationBarBackButtonHidden()
                    //                                        } label: {
                    //                                            Circle()
                    //                                                .frame(width: 60)
                    //                                                .overlay {
                    //                                                    Text(String(describing: firstCurrency))
                    //                                                        .foregroundColor(.darkBlue)
                    //                                                        .font(.system(size: 20))
                    //                                                }
                    //                                        }
                    //
                    //
                    //                                        Spacer()
                    //                                        Text(displayValue)
                    //                                    }
                    //                                    .frame(height: 50)
                    //                                    .padding(.horizontal, 30)
                    //
                    //                                    Rectangle()
                    //                                        .frame(height: 1)
                    //                                        .padding(.vertical)
                    //
                    //                                    HStack {
                    //                                        NavigationLink {
                    //                                            CurrencyView() { cur in
                    //                                                secondCurrency = cur
                    //                                            } onDisappear: {
                    //                                                completion()
                    //                                            }
                    //                                            .onAppear {
                    //                                                completion()
                    //                                            }
                    //                                            .navigationBarBackButtonHidden()
                    //
                    //                                        } label: {
                    //                                            Circle()
                    //                                                .frame(width: 60)
                    //                                                .overlay {
                    //                                                    Text(String(describing: secondCurrency))
                    //                                                        .foregroundColor(.darkBlue)
                    //                                                        .font(.system(size: 20))
                    //                                                }
                    //                                        }
                    //                                        Spacer()
                    //                                        Text(convertedValue)
                    //
                    //                                    }
                    //                                    .frame(height: 50)
                    //                                    .padding(.horizontal, 30)
                    //
                    //                                    Spacer()
                    //                                }
                    //                                .bold()
                    //                                .font(.system(size: 60))
                    //                                .foregroundColor(.white)
                    //                            }
                    //                            .padding(.top, 45)
                    //                        }
                    
                    
                    
                    
                    
                    VStack {
                        ForEach(buttons, id: \.self) { row in
                            HStack(spacing: 15) {
                                ForEach(row, id: \.self) { item in
                                    Button {
                                        if item.rawValue == "Convert" {
                                            print("converter")
                                            
                                            ConversionManager.shared.convert(displayValue, from: String(describing: firstCurrency), to: String(describing: secondCurrency)) { data, error in
                                                if let error = error {
                                                    print("Error: \(error)")
                                                } else if let data = data {
                                                    print("Received \(data.result) ")
                                                    self.convertedValue = String(format: "%.2f", data.result)
                                                }
                                            }
                                        } else {
                                            didTap(button: item)
                                        }
                                        
                                    } label: {
                                        if item.rawValue == "Convert" {
                                            Text(item.rawValue)
                                                .font(.system(size: 22))
                                                .frame(
                                                    width: 90,
                                                    height: 70
                                                )
                                                .foregroundColor(.white)
                                        } else {
                                            Text(item.rawValue)
                                                .font(.system(size: 32))
                                                .frame(
                                                    width: 90,
                                                    height: 70
                                                )
                                                .foregroundColor(.white)
                                        }
                                        
                                    }
                                }
                            }
                            .padding(.bottom, 0)
                        }
                    }
                    //  .padding(.top, screenSize().height > 667 ? 0 : 50)
                    //  .scaleEffect(screenSize().height > 667 ? 1 : 0.9)
                    .frame(height: 400)
                    //  .offset(y: screenSize().height > 767 ? 0 : -60)
                    
                    Spacer()
                }
                // .padding(.bottom, screenSize().height > 767 ? 0 : 60)
                
            }
            
//            //MARK: - NavBar
//            .modifier(NavBarBackground())
//            .navigationBarTitleDisplayMode(.inline)
//            .toolbar {
//                ToolbarItem(placement: .principal) {
//                    HStack {
//                        VStack {
//                            HStack {
//
//                                Text("Conversion")
//                                    .font(.system(size: 28, weight: .black))
//                                    .foregroundColor(Color.white)
//
//                                Spacer()
//                            }
//                        }
//                        Spacer()
//                    }
//                    .ignoresSafeArea()
//                }
//            }
            
        }
        .tint(.white)
    }
    
    func didTap(button: ButtonType) {
        switch button {
        case .add, .subtract, .multiply, .divide, .equal:
            guard let currentValue = Int(self.displayValue) else { return }
            switch button {
            case .add: self.currentOperation = .add
            case .subtract: self.currentOperation = .subtract
            case .multiply: self.currentOperation = .multiply
            case .divide: self.currentOperation = .divide
            case .equal:
                let running = self.runningValue
                switch self.currentOperation {
                case .add: self.displayValue = "\(running + currentValue)"
                case .subtract: self.displayValue = "\(running - currentValue)"
                case .multiply: self.displayValue = "\(running * currentValue)"
                case .divide: self.displayValue = "\(running / currentValue)"
                case .none: break
                }
            default:
                break
            }
            if button != .equal {
                self.runningValue = currentValue
                self.displayValue = "0"
            }
        case .clear:
            self.displayValue = "0"
            self.convertedValue = "0"
        case .decimal, .reverse, .percent:
            break
        default:
            let number = button.rawValue
            if self.displayValue == "0" {
                displayValue = number
            } else {
                self.displayValue += number
            }
        }
    }
    
    func calculateCardHeight() -> CGFloat {
        switch screenSize().height {
        case 800...950: return 330
        case 700...790: return 255
        case 600...690: return 250
        default:
            return 300
        }
    }
    
}


#Preview {
    ConversionView(){}
}
