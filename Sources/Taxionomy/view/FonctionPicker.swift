//
//  FonctionPicker.swift
//  Taxionomy
//
//  Created by Herve Crespel on 05/02/2026.
//

import SwiftUI

public struct FonctionPicker : View {

    @Binding var fonction: Taxion
    var done: () -> Void = {}
    var fonctions:[Taxion]
    
    public init(_ fonction:Binding<Taxion>, _ fonctions:[Taxion], _ done: @escaping () -> Void) {
        _fonction = fonction
        pick = fonction.wrappedValue.isNaN
        self.done = done
        self.fonctions = fonctions
    }
    
    public init(_ fonction:Binding<Taxion>, _ exclude:[String], _ done: @escaping () -> Void) {
        _fonction = fonction
        pick = fonction.wrappedValue.isNaN
        self.done = done
        self.fonctions = Taxionomy.fonctions.filter {item in !exclude.contains(item.id)}
    }
    
    @State private var pick :Bool
    public var body: some View {
        VStack {
            if pick {
                if fonctions.count > 0 {
                    ScrollView {
                        ForEach(fonctions) { selected in
                            Button(action:{
                                fonction = selected
                                pick = false
                            })
                            {Text(selected.label).frame(width:100)}
                        }
                    }.frame(height:250, alignment:.leading)
                    //.padding(.leading, CGFloat(taxion.dim * 80))
                } else {
                    Text("aucun choix")
                }
                
            } else {
                HStack{
                    //  Text(taxion.id)
                    Text(fonction.label)
                    Spacer()
                    Button(action:{
                        done()
                        pick = true
                    })
                    {Image(systemName: "pencil")}
                }.padding()
                //  }.frame(width:600, height:300, alignment:.leading)
            }
        }.padding()
    }
}

struct FonctionPrepicker : View {
    @State var taxion = Taxion()
    var exclude: [String] = ["2-9-37", "2-9-34", "2-9-36"]
    
    var body: some View {
        VStack {
            Text("Fonctions d'équipement").font(.title).padding()
            FonctionPicker($taxion, exclude,  {})
            Text(taxion.id)
        }.frame(width:300, height:400)
    }
}

#Preview {
    FonctionPrepicker()
}
#Preview {
    FonctionPrepicker(exclude:[])
}
