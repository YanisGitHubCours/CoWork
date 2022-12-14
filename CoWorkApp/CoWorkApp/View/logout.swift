//
//  signUp.swift
//  CoWorkApp
//
//  Created by Alexandre Marcos on 22/08/2022.
//

import SwiftUI
import NavigationStack

struct logout: View {
    
    @EnvironmentObject private var navigationStack: NavigationStackCompat
    // Need to add NavigationStackCompact in ContentView
    
    var body: some View {
        ZStack{
            Color("BgColor").edgesIgnoringSafeArea(.all)
            // Need to avoid Divider because a Stack can only contains 10
            VStack {
                VStack (alignment: .center){
                    Text("Logout")
                        .font(.largeTitle)
                        .padding(Edge.Set.bottom, 30)
                    Divider()
                        .frame(maxWidth: 2000, maxHeight: 0, alignment: .trailing)
                        .background(Color.black)
                        .padding(Edge.Set.bottom, 20)
                }
                Button {
                    LogoutUser.Logout(_: ApiService.TOKEN) { res in
                        if(res.error) {
                            print(res.message)
                        } else {
                            ApiService.TOKEN = ""
                            ApiService.USER = nil
                            DispatchQueue.main.async {
                                self.navigationStack.pop(to: .root)
                            }
                        }
                    }
                } label: {
                    Text("Yes")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(10)
                        .background(.gray)
                        .cornerRadius(50)
                }
            }
            .padding()
        }
    }
}
