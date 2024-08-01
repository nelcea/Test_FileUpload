import Vapor

func routes(_ app: Application) throws {
    try app.register(collection: UploadController())

    app.get { req async in
        "It works!"
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }
}
