import socket
import os

# Path to the Unix socket file
socket_path = '/tmp/script_socket'

# Create a Unix domain socket
server_socket = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)

# If the socket file already exists, remove it
if os.path.exists(socket_path):
    os.remove(socket_path)

# Bind the socket to the file path
server_socket.bind(socket_path)

# Listen for incoming connections
server_socket.listen(1)

print("Server is listening...")

try:
    while True:
        # Accept incoming connection
        client_socket, client_address = server_socket.accept()
        print("Connection established with:", client_address)

        try:
            while True:
                # Receive data from the client
                data = client_socket.recv(1024)
                if not data:
                    print("Client closed the connection.")
                    break
                print("Received:", data.decode())
        except Exception as e:
            print(f"Error while receiving data: {e}")
        finally:
            # Close the client socket
            client_socket.close()
except Exception as e:
    print(f"Error: {e}")
finally:
    # Close the server socket and remove the socket file
    server_socket.close()
    os.remove(socket_path)


# import socket
# import os

# # Path to the Unix socket file
# socket_path = '/tmp/script_socket'

# # Create a Unix domain socket
# server_socket = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)

# # If the socket file already exists, remove it
# if os.path.exists(socket_path):
#     os.remove(socket_path)

# # Bind the socket to the file path
# server_socket.bind(socket_path)

# # Listen for incoming connections
# server_socket.listen(1)

# print("Server is listening...")

# # Accept incoming connection
# client_socket, client_address = server_socket.accept()

# print("Connection established with:", client_address)

# while True:
#     # Receive data from the client
#     data = client_socket.recv(1024)
#     if not data:
#         break
#     print("Received:", data.decode())

# # Close the connection
# client_socket.close()
# server_socket.close()

# # Remove the socket file
# os.remove(socket_path)
