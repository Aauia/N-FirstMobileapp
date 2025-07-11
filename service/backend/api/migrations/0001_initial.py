# Generated by Django 5.2 on 2025-04-27 11:24

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Episode',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=255)),
                ('air_date', models.CharField(max_length=255)),
                ('episode', models.CharField(max_length=100)),
                ('url', models.URLField()),
                ('created', models.DateTimeField()),
            ],
        ),
        migrations.CreateModel(
            name='Info',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('count', models.IntegerField()),
                ('pages', models.IntegerField()),
                ('next', models.URLField(blank=True, null=True)),
                ('prev', models.URLField(blank=True, null=True)),
            ],
        ),
        migrations.CreateModel(
            name='Location',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=255)),
                ('type', models.CharField(max_length=255)),
                ('dimension', models.CharField(max_length=255)),
                ('url', models.URLField()),
                ('created', models.DateTimeField()),
            ],
            options={
                'verbose_name': 'Location',
                'verbose_name_plural': 'Locations',
            },
        ),
        migrations.CreateModel(
            name='Character',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=255)),
                ('status', models.CharField(choices=[('Alive', 'Alive'), ('Dead', 'Dead'), ('unknown', 'Unknown')], max_length=10)),
                ('species', models.CharField(max_length=255)),
                ('type', models.CharField(blank=True, max_length=255)),
                ('gender', models.CharField(choices=[('Female', 'Female'), ('Male', 'Male'), ('Genderless', 'Genderless'), ('unknown', 'Unknown')], max_length=10)),
                ('image', models.URLField()),
                ('url', models.URLField()),
                ('created', models.DateTimeField()),
                ('episode', models.ManyToManyField(related_name='characters', to='api.episode')),
                ('location', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='last_known_characters', to='api.location')),
                ('origin', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='origin_characters', to='api.location')),
            ],
        ),
    ]
