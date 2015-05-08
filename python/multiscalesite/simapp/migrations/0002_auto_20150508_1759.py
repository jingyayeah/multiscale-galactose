# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('simapp', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='parameter',
            name='ptype',
            field=models.CharField(max_length=30, choices=[(b'BOUNDERY_INIT', b'BOUNDERY_INIT'), (b'FLOATING_INIT', b'FLOATING_INIT'), (b'GLOBAL_PARAMETER', b'GLOBAL_PARAMETER'), (b'NONE_SBML_PARAMETER', b'NONE_SBML_PARAMETER')]),
        ),
        migrations.AlterField(
            model_name='parameter',
            name='unit',
            field=models.CharField(max_length=10),
        ),
    ]
