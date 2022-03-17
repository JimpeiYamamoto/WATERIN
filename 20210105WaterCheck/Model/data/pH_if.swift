//
//  pH_if.swift
//  20210105WaterCheck
//
//  Created by Takaaki Ishii on 2021/09/27.
//

import Foundation

class pH_if<T>
{
    private var val: T?

    func `if`( _ bool: Bool, _ ex: () -> T ) -> ConditionalBranch<T> {

        if bool {
            val = ex()
        }
        return self
    }

    func ifLet<E>(_ some: E?, ex: (E) -> T ) -> ConditionalBranch<T> {

        if val != nil {
            return self
        }

        guard let wapped = some else {
            return self
        }

        val = ex(wapped)
        return self
    }

    func elseIf( _ bool: Bool, _ ex: () -> T ) -> ConditionalBranch<T> {
        if val != nil { return self }
        return self.if(bool,ex)
    }

    func `else`(_ ex: () -> T) -> T {
        return val ?? ex()
    }
}
