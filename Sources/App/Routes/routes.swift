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


    
    try webServer(app)
    
//    try webClient(app)
    
    
}




//ws 服务器
func webServer(_ app: Application) throws{
    app.webSocket("echo") { (req, ws) in
        print(ws)
        
        ws.pingInterval = TimeAmount.seconds(5)
        
        ws.send("服务器连接成功！")

        ws.onText { (ws, text) in
            // 这个方法接收的是字符串
            print(text)
            ws.send("服务器接受到的消息："+text)
        }

        ws.onBinary { ws, binary in
            // 这个方法接收二进制数组。
            print(binary)
        }

        ws.onPing { (ws) in
            print("onPong")
//            ws.send("onPong")
        }

        ws.onPong { (ws) in
            print("onPong")
//            ws.send("onPing")
        }

//        ws.close(promise: nil)
    }
}


//ws 客户端
func webClient(_ app: Application) throws{
    let eventLoop: EventLoopGroup! = MultiThreadedEventLoopGroup(numberOfThreads: 5)
    let promise = eventLoop.next().makePromise(of: Void.self)
    
    WebSocket.connect(to: "ws://127.0.0.1:8080", on: eventLoop) { ws in
        // Connected WebSocket.
        print(ws)
        print("webClient")
        
        ws.onText { (ws, text) in
            // 这个方法接收的是字符串
            print(text)
            ws.send("服务器接受到的消息："+text)
        }
    }.cascadeFailure(to: promise)
}


