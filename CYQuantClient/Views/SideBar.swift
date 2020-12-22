//
//  SideBar.swift
//  GatroQuant (iOS)
//
//  Created by HYL on 2020/12/18.
//

import SwiftUI

struct SideBar: View {
    @State var selected: MainCategory?
    
    var body: some View {
        VStack(content: {
            Image("LOGO")
                .resizable()
                .frame(width: 100, height: 100, alignment: .center)
                .padding(.top, 20)
                .padding(.trailing, 10)
                .fixedSize()
                .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 2, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
            Divider()
                .padding([.leading, .trailing], 20)
            List(MainCategory.allCases) { category in
                NavigationLink(
                    destination: MainCategoryManager.shared.destination(with: category),
                    tag: category,
                    selection: $selected,
                    label: {
                        Label(category.title, systemImage: category.icon)
                    })
            }
            .listStyle(SidebarListStyle())
            .frame(minWidth: 180, maxWidth: 180, minHeight: 400)
            .padding(.leading, 10)
            .padding(.trailing, 10)
            .onAppear(perform: {
                if selected == nil {
                    selected = MainCategory.defaultSelection
                }
            })
        })
    }
}
