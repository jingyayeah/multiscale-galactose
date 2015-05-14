# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('simapp', '0001_initial'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='method',
            options={'verbose_name': 'Method', 'verbose_name_plural': 'Methods'},
        ),
    ]
