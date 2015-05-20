# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('simapp', '0003_auto_20150519_1429'),
    ]

    operations = [
        migrations.AlterField(
            model_name='parameter',
            name='key',
            field=models.CharField(max_length=50),
        ),
        migrations.AlterField(
            model_name='parameter',
            name='unit',
            field=models.CharField(max_length=50),
        ),
    ]
