

from .api_service import fetch_from_external_api

def get_unique_character_types():
    data = fetch_from_external_api('character')
    characters = data.get('results', [])

    types = set(character.get('type') for character in characters if character.get('type'))
    return list(types)
