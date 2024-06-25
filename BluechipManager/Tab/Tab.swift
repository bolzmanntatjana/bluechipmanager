//
//  Tab.swift
//  BluechipManager
//
//  Created by admin on 6/25/24.
//


import SwiftUI


struct StatusBarConfigurator: UIViewControllerRepresentable {
    var style: UIStatusBarStyle = .lightContent

    func makeUIViewController(context: Context) -> UIViewController {
        return StatusBarViewController(style: style)
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        if let viewController = uiViewController as? StatusBarViewController {
            viewController.statusBarStyle = style
            viewController.setNeedsStatusBarAppearanceUpdate()
        }
    }
}

class StatusBarViewController: UIViewController {
    var statusBarStyle: UIStatusBarStyle

    init(style: UIStatusBarStyle) {
        self.statusBarStyle = style
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }
}


struct TabMainView: View {
    
    
    init() {
        UITabBar.appearance().isHidden = true
        UITabBar.appearance().backgroundColor = .clear
    }
    
    @State private var isTabBarShown = true
    @State private var actibeTab: Tab = .home
    
    var body: some View {
        NavigationView {
            ZStack {
                BackView()
                
                TabView(selection: $actibeTab) {
                    MainView() {
                        isTabBarShown.toggle()
                    }
                    .preferredColorScheme(.light)

                    .navigationBarHidden(true)
                    .toolbar(.hidden, for: .tabBar)
                    .tag(Tab.home)
                    
                    ConversionView() {
                        isTabBarShown.toggle()
                    }
                        .navigationBarHidden(true)
                        .toolbar(.hidden, for: .tabBar)
                        .tag(Tab.stat)
                    
                    NewsView() {
                        isTabBarShown.toggle()
                    }
                        .navigationBarHidden(true)
                        .toolbar(.hidden, for: .tabBar)
                        .tag(Tab.percent)
                    
                    SettingsView()
                        .navigationBarHidden(true)
                        .toolbar(.hidden, for: .tabBar)
                        .tag(Tab.settings)
                }
                
                
            }
            .overlay {
                if isTabBarShown {
                    VStack {
                        Spacer()
                        
                        
                        TabBarView(tab: $actibeTab)
                            .toolbar(.hidden, for: .tabBar)
                            .padding(.horizontal)
                            .padding(.bottom, screenSize().height > 737 ? 10 : 25)
                            .ignoresSafeArea()
                            
                    }
                }
                
            }
        }
        .background(StatusBarConfigurator(style: .lightContent))
        .preferredColorScheme(.light)
        .navigationBarHidden(true)
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    TabMainView()
        .preferredColorScheme(.dark)
}


struct TabBarView: View {
    
    @Binding var tab: Tab
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.darkBlue)
                .shadow(color: .lightBlue.opacity(0.4), radius: 20, x: 0, y: 20)
            
            TabsLayoutView(selectedTab: $tab)
                .toolbar(.hidden, for: .tabBar)
                .navigationBarHidden(true)
        }
        .frame(height: 70, alignment: .center)
        .offset(y: 20)
    }
}

fileprivate struct TabsLayoutView: View {
    @Binding var selectedTab: Tab
    @Namespace var namespace
    
    var body: some View {
        HStack {
            Spacer(minLength: 0)
            
            ForEach(Tab.allCases) { tab in
                TabButton(tab: tab, selectedTab: $selectedTab, namespace: namespace)
                    .toolbar(.hidden, for: .tabBar)
                    .frame(width: 65, height: 65, alignment: .center)
                    .toolbar(.hidden, for: .tabBar)
                    .navigationBarHidden(true)
                Spacer(minLength: 0)
            }
        }
        .toolbar(.hidden, for: .tabBar)
        .navigationBarHidden(true)
    }
    
    
    
    private struct TabButton: View {
        let tab: Tab
        @Binding var selectedTab: Tab
        var namespace: Namespace.ID
        
        var body: some View {
            Button {
                withAnimation {
                    selectedTab = tab
                }
            } label: {
                ZStack {
                    if isSelected {
                        Circle()
                            .foregroundColor(.darkBlue)
                            .shadow(radius: 10)
                            .background {
                                Circle()
                                    .stroke(lineWidth: 15)
                                    .foregroundColor(.lightPink.opacity(0.7))
                                
                            }
                            .offset(y: -25)
                            .matchedGeometryEffect(id: "Selected Tab", in: namespace)
                            .animation(.spring(), value: selectedTab)
                    }
                    
                    Image(systemName: tab.icon)
                        .font(.system(size: 23, weight: .semibold, design: .rounded))
                        .foregroundColor(isSelected ? .init(white: 0.9) : .gray)
                        .scaleEffect(isSelected ? 1 : 0.8)
                        .offset(y: isSelected ? -25 : 0)
                        .animation(isSelected ? .spring(response: 0.5, dampingFraction: 0.3, blendDuration: 1) : .spring(), value: selectedTab)
                }
            }
            .buttonStyle(.plain)
        }
        
        private var isSelected: Bool {
            selectedTab == tab
        }
    }
}


enum Tab: Int, Identifiable, CaseIterable, Comparable {
    static func < (lhs: Tab, rhs: Tab) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
    
    case home, stat, percent, settings
    
    internal var id: Int { rawValue }
    
    var icon: String {
        switch self {
        case .home:
            return "house.fill"
        case .stat:
            return "dollarsign.arrow.circlepath"
        case .percent:
            return "line.horizontal.3"
        case .settings:
            return "gearshape"
        }
    }
    
}
