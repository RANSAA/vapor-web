import Vapor
import Leaf

func routes(_ app: Application) throws {
   
    
    app.get { (req)  in
//        req.view.render("welcome")
        return req.view.render("welcome")
    }
    
    app.get("hello") { (req)  in
        return req.view.render("hello",["name": "张三"])
    }
    
    app.get("hello",":name") { (req) in
       req.view.render("hello",["name": req.parameters.get("name")])
    }
    
    app.get(["test"]) { (req)  in 
        return req.view.render("test")
    }
    
    app.get("test",":name") { (req) -> EventLoopFuture<View> in
        print(req)

        return app.view.render("hello",["name":req.parameters.get("name")])
    }


}
