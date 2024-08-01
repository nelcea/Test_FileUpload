Created using vapor new Test_FileUpload
Added UploadController.swift to count bytes received
Added controller registration in routes.swift

Test: uploading a big file (WWDC 2024 State of the Union HD video), could not reproduce with a file of a few hundred KBs
On Mac M1, Sonoma, Xcode 15.4, standard Swift 5.10 toolchain
  - swift build
  - .build/debug/App serve 
  - curl -v -H 'Content-Type: video/mp4' -X 'POST' -T 'WWDC-2024/wwdc2024-102_hd.mp4' http://localhost:8080/upload
```
* Host localhost:8080 was resolved.
* IPv6: ::1
* IPv4: 127.0.0.1
*   Trying [::1]:8080...
* connect to ::1 port 8080 from ::1 port 65193 failed: Connection refused
*   Trying 127.0.0.1:8080...
* Connected to localhost (127.0.0.1) port 8080
> POST /upload HTTP/1.1
> Host: localhost:8080
> User-Agent: curl/8.7.1
> Accept: */*
> Content-Type: video/mp4
> Content-Length: 825707896
> Expect: 100-continue
> 
* Done waiting for 100-continue
* upload completely sent off: 825707896 bytes
< HTTP/1.1 201 Created
< content-length: 0
< connection: keep-alive
< date: Thu, 01 Aug 2024 09:32:39 GMT
< 
* Connection #0 to host localhost left intact
```

  - repeat 100 { curl -v -H 'Content-Type: video/mp4' -X 'POST' -T '/Volumes/MediaLibrary/Videos/Tech/Apple/WWDC-2024/wwdc2024-102_hd.mp4' http://localhost:8080/upload }
```
[ INFO ] POST /upload [request-id: FFC3071C-8412-4849-B8FA-7EEA13338B79]
Received a total of 825707896 bytes
[ INFO ] POST /upload [request-id: AE0BF62E-1BD2-4355-A2C4-0C4C7D63B1BC]
Vapor/RequestBody+Concurrency.swift:34: Fatal error
```

Sometimes it crashed on the 2nd iteration, sometimes it takes 20+ to crash
