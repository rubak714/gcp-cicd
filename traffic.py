import requests
import time

url = "https://my-flask-app-1015457000631.europe-west2.run.app/"

for i in range(50):
    try:
        response = requests.get(url)
        print(f"{i+1}: {response.status_code}")
    except Exception as e:
        print(f"Error: {e}")
    time.sleep(1)
