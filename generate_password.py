import base64
import hashlib
import sys

def generate_hash(password):
    # Convert the password to bytes
    password_bytes = password.encode('utf-8')

    # Generate the password hash using PBKDF2 with SHA-256
    hashed = hashlib.pbkdf2_hmac('sha256', password_bytes, b'', 10000)

    # Convert the hash to Base64 encoding
    hashed_base64 = base64.b64encode(hashed).decode('utf-8')

    return hashed_base64

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python hash_password.py <password>")
        sys.exit(1)

    password = sys.argv[1]
    hashed_password = generate_hash(password)
    print(hashed_password)
