from django.conf.urls import patterns, include, url

from django.contrib import admin
from django.conf import settings
from django.conf.urls.static import static
from django.views.generic.base import RedirectView
admin.autodiscover()

urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'mysite.views.home', name='home'),
    # url(r'^blog/', include('blog.urls')),
    # url(r'^polls/', include('polls.urls', namespace="polls")),
    url(r'^admin/', include(admin.site.urls)),
    url(r'^sim/', include('sim.urls', namespace="sim")),
    url(r'^$', RedirectView.as_view(url=r'sim', permanent=False)),
) + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
