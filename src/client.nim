import os, threadpool
import json

type
  Message* = object
    username*: string
    message*: string

proc parseMessage* (data: string): Message =
  let dataJson = parseJson(data)
  result.username = dataJson["username"].getStr()
  result.message = dataJson["message"].getStr()

proc createMessage*(username, message: string): string =
  result = $(%{
    "username": %username,
    "message": %message
  }) & "\c\l"

echo("Chat application started.")

if paramCount() == 0:
  quit("Please specify the server address, e.g... ./client localhost")

let serverAddr = paramStr(1)

echo("Connecting to ", serverAddr)

while true:
  let message = spawn stdin.readLine()
  echo("Sending \"", ^message, "\"")
