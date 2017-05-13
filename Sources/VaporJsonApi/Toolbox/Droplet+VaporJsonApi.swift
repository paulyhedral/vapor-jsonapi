//
//  Droplet+VaporJsonApi.swift
//  VaporJsonApi
//
//  Created by Koray Koska on 10/05/2017.
//
//

import Vapor
import HTTP

public extension Droplet {

    public func jsonApiResource<C: JsonApiResourceController>(controller: C) {
        let resourceType = controller.resourceType.parse()
        // Get routes
        group(resourceType) { resourceType in
            resourceType.get(handler: controller.getResources)
            resourceType.get(String.self, handler: controller.getResource)
            resourceType.get(String.self, String.self, handler: controller.getRelatedResource)
            resourceType.get(String.self, "relationships", String.self, handler: controller.getRelationships)
        }

        // Post routes
        post(resourceType, handler: controller.postResource)

        // Patch routes
        patch(resourceType, String.self, handler: controller.patchResource)
    }
}