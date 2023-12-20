from django.shortcuts import render
from django.contrib import messages
from .models import About
from .forms import CollaborateForm


def about_me(request, *args, **kwargs):
    """
    Render the About page, allowing users to submit collaboration requests.
    Retrieves the most recent information about the author or the website
    from the 'About' model and displays it on the About page. Users can also 
    submit collaboration requests using the provided form.
    """
    about = About.objects.all().order_by('-updated_on').first()

    if request.method == "POST":
        collaborate_form = CollaborateForm(data=request.POST)
        if collaborate_form.is_valid():
            collaborate_request = collaborate_form.save(commit=False)
            collaborate_request.read = False
            collaborate_request.save()
            messages.add_message(
                request, messages.SUCCESS,
                'Collaboration request received! I endeavor to respond within 2 working days.'
            )
            collaborate_form = CollaborateForm()
        else:
            collaborate_form = CollaborateForm()
    else:
        collaborate_form = CollaborateForm()

    return render(
        request,
        "about/about.html",
        {
            "about": about,
            "collaborate_form": collaborate_form
        },
    )
