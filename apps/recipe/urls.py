"""
URL mappings for the recipe app.
"""

from django.urls import path
from django.urls import include
from rest_framework.routers import DefaultRouter
from apps.recipe import views

router = DefaultRouter()
router.register('recipes', views.RecipeViewSet)

app_name = 'recipe'

urlpatterns = [
    path('', include(router.urls))
]
