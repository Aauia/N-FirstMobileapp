from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from .api_service import fetch_from_external_api
from .serializers import *
from rest_framework.decorators import api_view

from api.models import Location
from api.serializers import LocationSerializer
from django.http import JsonResponse

class CharacterListView(APIView):
    def get(self, request):
        params = request.query_params
        data = fetch_from_external_api('character', params)
        characters = data.get('results', [])

        serializer = CharacterSerializer(data=characters, many=True)
        serializer.is_valid(raise_exception=True)  
        return Response(serializer.data)

    
class CharacterDetailView(APIView):
    def get(self, request, pk):
        data = fetch_from_external_api(f'character/{pk}')

        serializer = CharacterSerializer(data=data)
        serializer.is_valid(raise_exception=True)  
        return Response(serializer.data)

class EpisodeListView(APIView):
    def get(self, request):

        params = request.query_params
        data = fetch_from_external_api('episode', params)
        episodes = data.get('results', [])
        serializer = EpisodeSerializer(episodes, many=True)
        return Response(serializer.data)

class EpisodeDetailView(APIView):
    def get(self, request, pk):
        data = fetch_from_external_api(f'episode/{pk}')
        serializer = EpisodeSerializer(data)
        return Response(serializer.data)
    
class LocationListView(APIView):
    def get(self, request):
        params = request.query_params
        data = fetch_from_external_api('location', params)  
        locations = data.get('results', [])
        serializer = LocationSerializer(locations, many=True)
        return Response(serializer.data)

class LocationDetailView(APIView):
    def get(self, request, pk):
        data = fetch_from_external_api(f'location/{pk}')
        serializer = LocationSerializer(data)
        return Response(serializer.data)
    
class CharacterSearchView(APIView):
    def get(self, request):
            name = request.query_params.get('name', None)
            if not name:
                return Response({"error": "Parameter 'name' is required"}, status=400)

            params = {'name': name}
            data = fetch_from_external_api('character', params)
            characters = data.get('results', [])

            if not characters:
                return Response({"message": "No characters found"}, status=404)

            serializer = CharacterSerializer(data=characters, many=True)
            serializer.is_valid(raise_exception=True)
            return Response(serializer.data)


class EpisodeSearchView(APIView):
    def get(self, request):
        episode_code = request.query_params.get('episode', '')
        name = request.query_params.get('name', '')
        
        params = {}
        if episode_code:
            params['episode'] = episode_code
        if name:
            params['name'] = name

        data = fetch_from_external_api('episode', params)
        episodes = data.get('results', [])

        serializer = EpisodeSerializer(data=episodes, many=True)
        serializer.is_valid(raise_exception=True)
        return Response(serializer.data)



class LocationSearchView(APIView):
    def get(self, request):
        name = request.query_params.get('name', None)
        if not name:
            return Response({"error": "Parameter 'name' is required"}, status=400)

        params = {'name': name}
        data = fetch_from_external_api('location', params)
        locations = data.get('results', [])

        if not locations:
            return Response({"message": "No locations found"}, status=404)

        serializer = LocationSerializer(data=locations, many=True)
        serializer.is_valid(raise_exception=True)
        return Response(serializer.data)
@api_view(['GET'])
def find_characters(request):
    status = request.GET.get('status')
    species = request.GET.get('species')
    type_ = request.GET.get('type')
    gender = request.GET.get('gender')

    if not any([status, species, type_, gender]):
        return Response({'error': 'At least one parameter (status, species, type, gender) is required.'}, status=400)

    try:
        params = {}
        if status:
            params['status'] = status
        if species:
            params['species'] = species
        if type_:
            params['type'] = type_
        if gender:
            params['gender'] = gender

        data = fetch_from_external_api('character', params)
        characters = data.get('results', [])

        if not characters:
            return Response({"message": "No characters found"}, status=404)

        serializer = CharacterSerializer(data=characters, many=True)
        serializer.is_valid(raise_exception=True)
        return Response(serializer.data)

    except Exception as e:
        return Response({'error': str(e)}, status=500)
@api_view(['GET'])
def find_locations(request):
    type_ = request.GET.get('type')
    dimension = request.GET.get('dimension')

    if not any([type_, dimension]):
        return Response({'error': 'At least one parameter (type, dimension) is required.'}, status=400)

    try:
        params = {}
        if type_:
            params['type'] = type_
        if dimension:
            params['dimension'] = dimension

        data = fetch_from_external_api('location', params)
        locations = data.get('results', [])

        if not locations:
            return Response({"message": "No locations found"}, status=404)

        serializer = LocationSerializer(data=locations, many=True)
        serializer.is_valid(raise_exception=True)
        return Response(serializer.data)

    except Exception as e:
        return Response({'error': str(e)}, status=500)
@api_view(['GET'])
def find_episodes(request):
    name = request.GET.get('name')
    season = request.GET.get('season')
    episode_number = request.GET.get('episode')

    if not any([name, season, episode_number]):
        return Response({'error': 'At least one parameter (name, season, episode) is required.'}, status=400)

    try:
        params = {}
        if name:
            params['name'] = name

        if season and episode_number:
            params['episode'] = f"{season}E{episode_number.zfill(2)}"  
        elif season:
            params['episode'] = season  
        elif episode_number:
            params['episode'] = f"E{episode_number.zfill(2)}"  

        data = fetch_from_external_api('episode', params)
        episodes = data.get('results', [])

        if not episodes:
            return Response({"message": "No episodes found"}, status=404)

        serializer = EpisodeSerializer(data=episodes, many=True)
        serializer.is_valid(raise_exception=True)
        return Response(serializer.data)

    except Exception as e:
        return Response({'error': str(e)}, status=500)
    
class CharacterTypes(APIView):
    def get(self, request):
        try:
            data = fetch_from_external_api('location')  
            characters = data.get('results', [])

            if not characters:
                return Response({"location dimension": []}, status=status.HTTP_200_OK)
            character_types = set()
            for character in characters:
                if character.get('type'):
                    character_types.add(character['type'])


            character_types = list(character_types)
            serializer = CharacterTypesSerializer(data={"location_dimension": character_types})
            if serializer.is_valid():
                return Response(serializer.data, status=status.HTTP_200_OK)
            else:
                return Response({"error": "Serialization failed"}, status=status.HTTP_400_BAD_REQUEST)

        except Exception as e:
            return Response({"error": "Internal server error"}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
