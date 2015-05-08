# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations
import simapp.storage
import django.utils.timezone
import simapp.models


class Migration(migrations.Migration):

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Core',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('ip', models.CharField(max_length=200)),
                ('cpu', models.IntegerField()),
                ('time', models.DateTimeField(default=django.utils.timezone.now)),
            ],
            options={
                'verbose_name': 'Core',
                'verbose_name_plural': 'Cores',
            },
        ),
        migrations.CreateModel(
            name='Integration',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
            ],
            options={
                'verbose_name': 'Integration Setting',
                'verbose_name_plural': 'Integration Settings',
            },
        ),
        migrations.CreateModel(
            name='Parameter',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('name', models.CharField(max_length=200)),
                ('value', models.FloatField()),
                ('unit', models.CharField(max_length=10, choices=[(b'm', b'm'), (b'm/s', b'm/s'), (b'mM', b'mM'), (b'mole_per_s', b'mole_per_s'), (b'-', b'-')])),
                ('ptype', models.CharField(max_length=20, choices=[(b'GLOBAL_PARAMETER', b'GLOBAL_PARAMETER'), (b'BOUNDERY_INIT', b'BOUNDERY_INIT'), (b'FLOATING_INIT', b'FLOATING_INIT'), (b'NONE_SBML_PARAMETER', b'NONE_SBML_PARAMETER')])),
            ],
        ),
        migrations.CreateModel(
            name='SBMLModel',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('sbml_id', models.CharField(unique=True, max_length=200)),
                ('file', models.FileField(storage=simapp.storage.OverwriteStorage(), max_length=200, upload_to=b'sbml')),
            ],
            options={
                'verbose_name': 'SBML Model',
                'verbose_name_plural': 'SBML Models',
            },
        ),
        migrations.CreateModel(
            name='Setting',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('name', models.CharField(max_length=20, choices=[(b'varSteps', b'varSteps'), (b'relTol', b'relTol'), (b'absTol', b'absTol'), (b'integrator', b'integrator'), (b'tend', b'tend'), (b'steps', b'steps'), (b'tstart', b'tstart'), (b'condition', b'condition')])),
                ('datatype', models.CharField(max_length=10, choices=[(b'string', b'string'), (b'double', b'double'), (b'int', b'int'), (b'boolean', b'boolean')])),
                ('value', models.CharField(max_length=20)),
            ],
        ),
        migrations.CreateModel(
            name='Simulation',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('status', models.CharField(default=b'UNASSIGNED', max_length=20, choices=[(b'UNASSIGNED', b'unassigned'), (b'ASSIGNED', b'assigned'), (b'ERROR', b'error'), (b'DONE', b'done')])),
                ('time_create', models.DateTimeField(default=django.utils.timezone.now)),
                ('time_assign', models.DateTimeField(null=True, blank=True)),
                ('time_sim', models.DateTimeField(null=True, blank=True)),
                ('core', models.ForeignKey(blank=True, to='simapp.Core', null=True)),
                ('parameters', models.ManyToManyField(to='simapp.Parameter')),
            ],
        ),
        migrations.CreateModel(
            name='Task',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('priority', models.IntegerField(default=0)),
                ('info', models.TextField(null=True, blank=True)),
                ('integration', models.ForeignKey(to='simapp.Integration')),
                ('sbml_model', models.ForeignKey(to='simapp.SBMLModel')),
            ],
        ),
        migrations.CreateModel(
            name='Timecourse',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('file', models.FileField(storage=simapp.storage.OverwriteStorage(), max_length=200, upload_to=simapp.models.timecourse_filename)),
                ('odesim', models.OneToOneField(to='simapp.Simulation')),
            ],
        ),
        migrations.AddField(
            model_name='odesim',
            name='task',
            field=models.ForeignKey(to='simapp.Task'),
        ),
        migrations.AlterUniqueTogether(
            name='parameter',
            unique_together=set([('name', 'value')]),
        ),
        migrations.AddField(
            model_name='integration',
            name='settings',
            field=models.ManyToManyField(to='simapp.Setting'),
        ),
        migrations.AlterUniqueTogether(
            name='core',
            unique_together=set([('ip', 'cpu')]),
        ),
        migrations.AlterUniqueTogether(
            name='task',
            unique_together=set([('sbml_model', 'integration', 'info')]),
        ),
    ]
