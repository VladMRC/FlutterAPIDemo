from django.db import models

# Create your models here.
class User(models.Model):
    email = models.CharField(max_length=60)
    first_name = models.CharField(max_length=60)
    last_name = models.CharField(max_length=60)
    avatar = models.CharField(max_length=150)
    def __str__(self):
        return self.id