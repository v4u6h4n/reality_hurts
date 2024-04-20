import sys
import requests
from base64 import standard_b64encode

def replace_placeholders(payload, placeholder_data):
    # Replace placeholders in the payload with the actual values from the dictionary
    for placeholder, value in placeholder_data.items():
        payload = payload.replace(placeholder, value)
    return payload

def serialize_gr_command(**cmd):
    payload = cmd.pop('payload', None)
    cmd_str = ','.join(f'{k}={v}' for k, v in cmd.items())
    ans = []
    w = ans.append
    w(b'\033_G')
    w(cmd_str.encode('ascii'))

    if payload:
        placeholder_data = {
            # Define your placeholder mappings here
            '{placeholder}': 'value',
            # Add more mappings as needed
        }
        payload_str = replace_placeholders(payload.decode('utf-8'), placeholder_data)
        encoded_payload = payload_str.encode('utf-8')
        w(b';')
        w(encoded_payload)
    
    w(b'\033\\')
    return b''.join(ans)

def write_chunked(**cmd):
    data = standard_b64encode(cmd.pop('data'))
    while data:
        chunk, data = data[:4096], data[4096:]
        m = 1 if data else 0
        sys.stdout.buffer.write(serialize_gr_command(payload=chunk, m=m, **cmd))
        sys.stdout.flush()

def main(image_url):
    response = requests.get(image_url)
    if response.status_code == 200:
        write_chunked(a='T', f=100, data=response.content)
    else:
        print(f"Failed to fetch image from URL: {image_url}")

if __name__ == '__main__':
    image_url = sys.argv[1]  # Read the image URL from the command-line argument
    main(image_url)
