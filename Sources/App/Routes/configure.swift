import Vapor
import Leaf

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
     app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    //Catches errors and converts to HTTP response
//    app.middleware.use(ErrorMiddleware.default(environment: app.environment))
    app.middleware.use(CustomErrorMiddleware.default(environment: app.environment))
    
    
    // Register cors middleware
    let corsConfiguration = CORSMiddleware.Configuration(
        allowedOrigin: .all,
        allowedMethods: [.GET, .POST, .PUT, .OPTIONS, .DELETE, .PATCH],
        allowedHeaders: [.accept, .authorization, .contentType, .origin, .xRequestedWith]
    )
    let corsMiddleware = CORSMiddleware(configuration: corsConfiguration)
    app.middleware.use(corsMiddleware)

   
    //register leaf
    app.views.use(.leaf)
    app.leaf.cache.isEnabled = false
    

    //hostname port
    app.http.server.configuration.port = 8080;
    app.http.server.configuration.hostname = "0.0.0.0"


    // register routes
    try routes(app)
  
}
