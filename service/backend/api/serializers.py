from rest_framework import serializers
from .models import *


class InfoSerializer(serializers.ModelSerializer):
    class Meta:
        model = Info
        fields = ['count', 'pages', 'next', 'prev']
class LocationSerializer(serializers.ModelSerializer):
    class Meta:
        model = Location
        fields = ['id', 'name', 'type', 'dimension', 'residents', 'url', 'created']


class CharacterSerializer(serializers.ModelSerializer):
    class Meta:
        model = Character
        fields = ['id', 'name', 'status', 'species', 'type', 'gender', 'origin', 'location', 'image', 'episode', 'url', 'created']


class EpisodeSerializer(serializers.ModelSerializer):
    class Meta:
        model = Episode
        fields = ['id', 'name', 'air_date', 'episode', 'url', 'created']
class CharacterTypesSerializer(serializers.Serializer):
    location_dimension = serializers.ListField(child=serializers.CharField())
