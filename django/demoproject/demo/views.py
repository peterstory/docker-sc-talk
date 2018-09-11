from django.shortcuts import render

from .models import Visit


def index(request):
    # Save the user agent from the current request
    Visit.objects.create(user_agent=request.META['HTTP_USER_AGENT'])
    return render(request, 'index.html', {'visits': Visit.objects.all()})
