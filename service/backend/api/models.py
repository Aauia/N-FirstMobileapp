from django.db import models



class Info(models.Model):
    count = models.IntegerField()
    pages = models.IntegerField()
    next = models.URLField(null=True, blank=True)
    prev = models.URLField(null=True, blank=True)

    def __str__(self):
        return f"Info: {self.count} items over {self.pages} pages"


class Location(models.Model):
    name = models.CharField(max_length=100) 
    type = models.CharField(max_length=50)  
    dimension = models.CharField(max_length=50)  
    residents = models.JSONField(default=list)  
    url = models.URLField()  
    created = models.DateTimeField(auto_now_add=True)  

    def __str__(self):
        return self.name


class Character(models.Model):
    STATUS_CHOICES = [
        ('Alive', 'Alive'),
        ('Dead', 'Dead'),
        ('unknown', 'Unknown')
    ]

    GENDER_CHOICES = [
        ('Female', 'Female'),
        ('Male', 'Male'),
        ('Genderless', 'Genderless'),
        ('unknown', 'Unknown')
    ]
    id = models.IntegerField(primary_key=True)
    name = models.CharField(max_length=255)
    status = models.CharField(max_length=50)
    species = models.CharField(max_length=50)
    type = models.CharField(max_length=255, blank=True)
    gender = models.CharField(max_length=50)
    origin = models.JSONField(default=list)   
    location = models.JSONField(default=list) 
    image = models.URLField()
    episode = models.JSONField(default=list)  
    url = models.URLField()
    created = models.DateTimeField()


    def __str__(self):
        return self.name


class Episode(models.Model):
    name = models.CharField(max_length=255)
    air_date = models.CharField(max_length=255)
    episode = models.CharField(max_length=100)
    url = models.URLField()
    created = models.DateTimeField()

    def __str__(self):
        return self.name

