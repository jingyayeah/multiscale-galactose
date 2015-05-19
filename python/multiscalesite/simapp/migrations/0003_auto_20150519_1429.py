# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('simapp', '0002_auto_20150519_0804'),
    ]

    operations = [
        migrations.AlterField(
            model_name='result',
            name='simulation',
            field=models.ForeignKey(related_name='results', to='simapp.Simulation'),
        ),
    ]
