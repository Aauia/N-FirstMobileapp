import requests

BASE_URL = "https://rickandmortyapi.com/api"

def fetch_from_external_api(endpoint, params=None):
    url = f"{BASE_URL}/{endpoint}"
    response = requests.get(url, params=params)
    response.raise_for_status()
    return response.json()
