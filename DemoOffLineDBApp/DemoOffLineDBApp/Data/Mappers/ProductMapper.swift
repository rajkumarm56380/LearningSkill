//
//  ProductMapper.swift
//  DemoOffLineDBApp
//
//

import Foundation

struct ProductMapper {

    static func mapDTOToDomain(_ dto: ProductDTO) -> Product {
        Product(
            id: dto.id,
            title: dto.title,
            price: dto.price,
            isFavorite: dto.isFavorite,
            quantity: dto.quantity
        )
    }

    static func mapDTOArrayToDomain(_ dtos: [ProductDTO]) -> [Product] {
        dtos.map { mapDTOToDomain($0) }
    }
}
