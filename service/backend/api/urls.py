# urls.py

from django.urls import path
from .views import *

urlpatterns = [

    path('characters/', CharacterListView.as_view(), name='character-list'),
    path('characters/<int:pk>/', CharacterDetailView.as_view(), name='character-detail'),
    path('characters/search/', CharacterSearchView.as_view(), name='character-search'),
    
    path('characters/types', CharacterTypes.as_view(), name='characterlist-types'),


    path('episodes/', EpisodeListView.as_view(), name='episode-list'),
    path('episodes/<int:pk>/', EpisodeDetailView.as_view(), name='episode-detail'),
    path('episodes/search/', EpisodeSearchView.as_view(), name='episode-search'),


    path('locations/', LocationListView.as_view(), name='location-list'),
    path('locations/<int:pk>/', LocationDetailView.as_view(), name='location-detail'),
    path('locations/search/', LocationSearchView.as_view(), name='location-search'),
    
    path('find_characters/', find_characters, name='find_characters'),
    path('find_locations/', find_locations, name='find_locations'),
    path('find_episodes/', find_episodes, name='find_episodes'),


]
