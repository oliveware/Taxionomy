//
//  NomPropre.swift
//  Taxionomy
//
//  Created by Herve Crespel on 18/01/2021.
//

import SwiftUI

public struct NomPropre: View {
    var prompt = "prompt"
    var aide:String = "mot simple ou locution"
    @Binding var input : String
    
    public init(_ input: Binding<String>,_ prompt: String = "",_ help:String = "" ) {
        self.prompt = prompt
        aide = help
        _input = input
    }
       
    public var body: some View {
        VStack (alignment:.leading, spacing:1){
           if prompt != "" {
               Text(prompt).font(.caption).padding(.leading,10)
           }
           TextField(aide, text: $input)
             //  .textFieldStyle(putexStyle())
        }.padding(5)
    }
}

struct NomProprePreview: View {
    @State var nom:String = ""
    
    var body: some View {
        NomPropre($nom, "nom propre")
    }
}

#Preview {
    NomProprePreview()
}
