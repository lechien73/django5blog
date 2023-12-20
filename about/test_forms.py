from django.test import TestCase
from .forms import CollaborateForm


class TestCollaborateForm(TestCase):

    def test_name_email_and_message_are_required(self):
        # Test for the 'name' field
        form = CollaborateForm(
            {'name': '', 'email': 'test@test.com', 'message': 'Hello!'})
        self.assertFalse(form.is_valid())
        self.assertIn('name', form.errors.keys())
        self.assertEqual(form.errors['name'][0], 'This field is required.')

        # Test for the 'email' field
        form = CollaborateForm(
            {'name': 'John Doe', 'email': '', 'message': 'Hello!'})
        self.assertFalse(form.is_valid())
        self.assertIn('email', form.errors.keys())
        self.assertEqual(form.errors['email'][0], 'This field is required.')

        # Add your test for the 'message' field here
        form = CollaborateForm(
            {'name': 'John Doe', 'email': 'test@test.com', 'message': ''})
        self.assertFalse(form.is_valid())
        self.assertIn('message', form.errors.keys())
        self.assertEqual(form.errors['message'][0], 'This field is required.')
