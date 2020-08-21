一、到https://github.com/protocolbuffers/protobuf/releases下载protoc-3.13.0-win64后解压
二、当前目录下，cmd执行对应proto
    java
    protoc.exe --java_out=./ Person.proto
    c#
    protoc.exe --csharp_out=./ Person.proto
