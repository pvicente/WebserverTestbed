import src.server_app as Application

handler = Application.ServerApplication()

def app(environ, start_response):
	return iter(handler(environ, start_response))
