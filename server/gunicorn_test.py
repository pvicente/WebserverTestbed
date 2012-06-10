def app(environ, start_response):
    data = "Hello, World!\n"
    response_headers = [("Content-Type", "text/plain"), ("Content-Length", str(len(data)))]
    if not environ.get('SERVER_PROTOCOL','HTTP/1.0') == 'HTTP/1.1':
	response_headers.append(("Connection", "close"))
    start_response("200 OK", response_headers)
    return iter([data])
