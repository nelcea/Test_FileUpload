//
//  UploadController.swift
//
//
//  Created by Eric Bariaux on 29/07/2024.
//

import Vapor

struct UploadController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let upload = routes.grouped("upload")
        upload.on(.POST, body: .stream, use: self.uploadFile)
    }
    
    @Sendable
    func uploadFile(req: Request) async throws -> HTTPStatus {
        var bytesReceived = 0
        
        for try await part in req.body {
            bytesReceived += Data(buffer: part).count
        }
        print("Received a total of \(bytesReceived) bytes")

        return .created
    }

}
